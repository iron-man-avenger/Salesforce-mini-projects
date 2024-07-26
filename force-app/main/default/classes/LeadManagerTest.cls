@isTest
private class LeadManagerTest {
    static testMethod void testLeadManagerBatch() {
        // Create test leads
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(
                FirstName = 'Test',
                LastName = 'Lead ' + i,
                Company = 'Test Company',
                Email = 'test' + i + '@example.com',
                Status = 'New'));
            }
            try {
            if (testLeads.size()>0) {
                insert testLeads;
            }
            
            Test.startTest();
            // Execute the batch job
            LeadManager batch = new LeadManager();
            Database.executeBatch(batch);
            Test.stopTest();
            
            // Verify that all leads have been closed
            List<Lead> closedLeads = [SELECT Id, Status 
                                        FROM Lead 
                                        WHERE Id IN :testLeads];
            for (Lead lead : closedLeads) {
                System.assertEquals('Closed', lead.Status);
            }
            
            // Verify that emails have been sent
            Integer expectedEmails = Math.min(testLeads.size(), Limits.getLimitEmailInvocations());
            System.assertEquals(expectedEmails, Limits.getEmailInvocations());
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}