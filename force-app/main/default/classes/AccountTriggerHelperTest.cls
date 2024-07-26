@isTest
private class AccountTriggerHelperTest {
    @IsTest
    static void testAccountTrigger(){
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.BillingStreet = 'Billing Street';
        testAccount.ShippingStreet = testAccount.BillingStreet;
        testAccount.Total_Opportunity_Amount__c = 1000;        
        insert testAccount;
        
        
        Opportunity testOpportunity = new Opportunity();
        testOpportunity.Name = 'Test Opportunity';
        testOpportunity.AccountId = testAccount.Id;
        testOpportunity.StageName = 'Closed Lost';
        testOpportunity.Amount = 1000;
        testOpportunity.CloseDate = System.today();
        insert testOpportunity;
        
        testAccount.BillingStreet = 'Updated Billing Street 1';
        List<Account> accountsToUpdate = new List<Account>{ testAccount};
        try {
            if (accountsToUpdate.size()>0) {
                update accountsToUpdate;
            }

            List<Account> accounts = [SELECT Id, Total_Opportunity_Amount__c 
                                        FROM Account 
                                        WHERE Id IN :new Set<Id>{testAccount.Id}];
            // Update the accounts
            for (Account myaccount : accounts) {
                myaccount.Total_Opportunity_Amount__c = 0;
            }
            if (accounts.size()>0) {
                update accounts;
            }
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}