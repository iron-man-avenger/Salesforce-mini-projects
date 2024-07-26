trigger AccountTrigger on Account(before insert, 
                                after insert, 
                                after update, 
                                before update) {
        TriggerDispatcherForAccount.run(new AccountTriggerHandler() , 'AccountTrigger');
}
































            // Set<Id> accountIds = new Set<Id>();
            // Map<Id,String> accountMap = new Map<Id,String>();
            // for(Account accountvalue : Trigger.new) {
            //     System.debug(Trigger.oldMap.get(accountvalue.Id).Similar_Value__c);
            //     System.debug(accountvalue.Similar_Value__c);
            //     if (accountvalue.Similar_Value__c != Trigger.oldMap.get(accountvalue.Id).Similar_Value__c) {
            //         accountIds.add(accountvalue.Id);
            //         accountMap.put(accountvalue.Id, accountvalue.Similar_Value__c);
            //         System.debug('This is my account value' + accountvalue);
            //     }
            // }
            // if (!accountIds.isEmpty()) {
            //     List<Opportunity> opportunityToUpdate = [SELECT Id, AccountId, Similar_Value__c 
            //                                             FROM Opportunity 
            //                                             WHERE AccountId IN :accountIds];
            //     for (Opportunity opportunityAndAccountIdandFieldValue : opportunityToUpdate) {
            //         opportunityAndAccountIdandFieldValue.Similar_Value__c = accountMap.get(opportunityAndAccountIdandFieldValue.AccountId);
            //     System.debug('Value................'+opportunityAndAccountIdandFieldValue);
            //     }
                    // if (Opportunity.size()>0) {
                    //     update opportunityToUpdate;
                    // }
            //     
                
            // }