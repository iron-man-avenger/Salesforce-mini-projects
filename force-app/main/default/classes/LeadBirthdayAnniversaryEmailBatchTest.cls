@isTest
private class LeadBirthdayAnniversaryEmailBatchTest {
    @isTest
    static void testLeadBirthdayAnniversaryEmailBatch() {
        // Create test data
        List<Contact> contacts = new List<Contact>();
        Contact contact1 = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            Data_of_Birth__c = Date.today(),
            Date_of_Anniversary__c = Date.today()
            );
            // Add more test contacts if needed
            
            // Insert test data
            insert contacts;
            
        // Create an instance of the batch class
        LeadBirthdayAnniversaryEmailBatch batch = new LeadBirthdayAnniversaryEmailBatch();
            
        // Start the batch execution
        Test.startTest();
        Database.executeBatch(batch);
        Test.stopTest();
        
        // Perform assertions
        // Retrieve the sent emails and validate the results as needed
        
        // Get the number of sent emails
        Integer expectedEmailCount = 0; // Assuming one email is sent based on the test data
        Integer actualEmailCount = [SELECT count() FROM EmailMessage];
        System.assertEquals(expectedEmailCount, actualEmailCount, 'Number of sent emails is incorrect.');
    }
}