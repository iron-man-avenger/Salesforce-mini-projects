public with sharing class AccountTriggerHelper {
    
    //Trigger scenario 1  automatically account billing address should populate into the account shipping address
    public static void accAddressUpdate(List<Account> newAccount) {
        //Set<Account> accId = new Set<Account>([select Id from Account]);
        for (Account populate : newAccount) {
            
            if (populate.BillingStreet != null) {
                populate.ShippingStreet = populate.BillingStreet;
            }
            
            else {
                populate.addError('BillingStreet is not entered');
            }
        }
    System.debug('Task 1 run successfully');
}

//Trigger scenario 2  update Account related Opportunities based on a condition
public static void updateAccRelatedOpp(List<Account> newAccount) {
        //OppoStageUpdate on account
        Set<Id> accountIds = new Set<Id>();
        for(Account a: newAccount){
        accountIds.add(a.Id);
        }
        DateTime day30 = System.today().addDays(-30);
        List<Opportunity> oppListToUpdate = new List<Opportunity>();

        //getting the opportunities whose account has been updated
        List<Opportunity> opportunityList = [Select Id, AccountId, StageName, CreatedDate, CloseDate 
        from Opportunity where AccountId in :accountIds];
        if(opportunityList.size()>0){
            for(Opportunity opp : opportunityList){
                if(opp.CreatedDate<day30 && opp.StageName!='Closed Won'){
                    opp.StageName='Closed Lost';
                    opp.CloseDate=system.today();
                    oppListToUpdate.add(opp);
                }
            }
        }
        else {
            System.debug('Opportunity is not available');
        }
        if(oppListToUpdate.size()>0){
            update oppListToUpdate;
        }
    }

    //Trigger scenario 3  trigger sendEmailToAdmin on Account
    public static void sendEmailToAdmin(List<Account> newAccount1){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        User userInfo = [select Id, Profile.Name,Email 
                        from User 
                        where Profile.Name = 'System Administrator'];
        for (Account acc : newAccount1) {
            if(userInfo.Email != null){
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSenderDisplayName('Salesforce');
                mail.setUseSignature(false);
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
                mail.toAddresses = new String[]{userInfo.Email};
                mail.setSubject('New Account was Created.');
                String body = 'Dear System Administrator, <br/>';
                body += 'An account has been created and name is '+acc.Name+'.';
                mail.setHtmlBody(body);
                mails.add(mail);
                }
        }
        if (mails.size()>0) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
                if (results[0].success) {
                    System.debug('Email send successfully: ');
                }
                else {
                    System.debug('The email failed to send: '+ results[0].errors[0].message);
                }
        }
    }

    //trigger totalAmountofRelatedOpp on Account
    public static void totalAmountofRelatedOpp(List<Account> newAccount2 ){
        Set<Id> accId = new Set<Id>();
        for (Account acc : newAccount2) {
            acc.Total_Opportunity_Amount__c = 0;
            accId.add(acc.Id);
        }
        Map<Id, Double> accIdOppAmountmap = new Map<Id, Double>();
        List<AggregateResult> results = [select AccountId,sum(Amount)TotalAmount 
                                        from opportunity 
                                        where AccountId in :accId group by AccountId];
        if (results.size()>0) {
            for (AggregateResult a : results) {
                Id accountId = (Id)a.get('AccountId');
                double TotalAmount = (Double)a.get('TotalAmount');
                accIdOppAmountmap.put(accountId, TotalAmount);
            }
        }
        for (Account acc : newAccount2) {
            if (accIdOppAmountmap.containskey(acc.Id)) {
                acc.Total_Opportunity_Amount__c = accIdOppAmountmap.get(acc.id);
                System.debug(acc.Total_Opportunity_Amount__c);
            }
        }
    }

    // Task 5 Update Client_Contact__c Field On Account
    public static void updateClientContactFieldOnAccount(List<Account> newAccount3){
        List<Account> accountListUpdate = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        Set<Id> accountId = new Set<Id>();
        Map<Id,Account> accIdandRecordmap = new Map<Id,Account>();
        for (Account accountObject : newAccount3) {
            Contact contactObject =new Contact();
            contactObject.LastName = accountObject.Name;
            contactObject.AccountId = accountObject.Id;
            contactList.add(contactObject);
            accountId.add(contactObject.AccountId);
        }
        if (contactList.size()>0) {
            insert contactList;
        }
        List<Account> accountList = [Select Id,Client_Contact__c 
                                from Account 
                                where Id=:accountId];
        if(accountList.size()>0){
            for (Account account : accountList) {
                accIdandRecordmap.put(account.Id,account);
            }
        if(contactList.size()>0){
            for(Contact newContactObject : contactList){
                if(accIdandRecordmap.containsKey(newContactObject.AccountId)){
                    Account newAccountObject = accIdandRecordmap.get(newContactObject.AccountId);
                    newAccountObject.Client_Contact__c = newContactObject.Id;
                    accountListUpdate.add(newAccountObject);
                }
            }
        }
        //Update the Account 
        if(accountListUpdate.size()>0){
            update accountListUpdate;
            
        }
        }
    }
}