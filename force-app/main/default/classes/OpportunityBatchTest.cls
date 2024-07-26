@isTest
private class OpportunityBatchTest {
    @isTest
    static void testOpportunityBatch() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account', BillingStreet = '32 Biker St');
        insert testAccount;
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = testAccount.Id,
            CloseDate = System.today().addDays(-1),
            StageName = 'Open'
            
        );
        insert testOpportunity;

        // Set up batch job
        OpportunityBatch batchJob = new OpportunityBatch();
        Test.startTest();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify changes
        Opportunity updatedOpportunity = [SELECT StageName, Description FROM Opportunity WHERE Id = :testOpportunity.Id];
        System.assertEquals('Closed Lost', updatedOpportunity.StageName);
        System.assertEquals('Opportunity closed due to missed deadline.', updatedOpportunity.Description);
    }
}