@isTest
private class AccountRealtedOpportunityStageHelperTest {

    @isTest
    static void testChangeStageInAccount() {
        // Create test Account
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        insert testAccount;

        // Create test Opportunities related to the test Account
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'Test Opportunity 1';
        opportunity1.AccountId = testAccount.Id;
        opportunity1.Probability = 60;
        opportunity1.StageName = 'Prospecting';
        opportunity1.CloseDate = Date.today() + 30;
        insert opportunity1;
        
        Opportunity opportunity2 = new Opportunity();
        opportunity2.Name = 'Test Opportunity 2';
        opportunity2.AccountId = testAccount.Id;
        opportunity2.Probability = 70;
        opportunity2.StageName = 'Qualification';
        opportunity2.CloseDate = Date.today() + 60;
        insert opportunity2;
        
        Opportunity opportunity3 = new Opportunity();
        opportunity3.Name = 'Test Opportunity 3';
        opportunity3.AccountId = testAccount.Id;
        opportunity3.Probability = 75;
        opportunity3.StageName = 'Needs Analysis';
        opportunity3.CloseDate = Date.today() + 90;
        insert opportunity3;
        
        Opportunity opportunity4 = new Opportunity();
        opportunity4.Name = 'Test Opportunity 4';
        opportunity4.AccountId = testAccount.Id;
        opportunity4.Probability = 90;
        opportunity4.StageName = 'Proposal/Price Quote';
        opportunity4.CloseDate = Date.today() + 120;
        insert opportunity4;
        
        Opportunity opportunity5 = new Opportunity();
        opportunity5.Name = 'Test Opportunity 5';
        opportunity5.AccountId = testAccount.Id;
        opportunity5.Probability = 100;
        opportunity5.StageName = 'Closed Won';
        opportunity5.CloseDate = Date.today() + 150;
        insert opportunity5;
        
        // Call the method being tested
        Test.startTest();
        List<Opportunity> opportunityList = new List<Opportunity>{opportunity1, opportunity2, opportunity3, opportunity4, opportunity5};
        AccountRealtedOpportunityStageHelper.changeStageinAccount(opportunityList);
        Test.stopTest();
        
        // Verify that the Account's Highest_Opportunity_Stage_Value__c field was updated
        Account updatedAccount = [SELECT Highest_Opportunity_Stage_Value__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(null, updatedAccount.Highest_Opportunity_Stage_Value__c, 'Highest_Opportunity_Stage_Value__c field not updated correctly');
    }

}