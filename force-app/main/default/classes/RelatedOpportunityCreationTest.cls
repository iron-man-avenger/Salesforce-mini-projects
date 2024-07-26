@IsTest
private class RelatedOpportunityCreationTest {
    @IsTest
    static void testOpportunityCreation() {
        // Create test Account
        Account account = new Account(Name = 'Test Account');
        insert account;
        // Create test Contacts
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 1; i++) {
            Contact c = new Contact(
                LastName = 'Contact for Account ' + account.Name,
                AccountId = account.Id
            );
            contacts.add(c);
        }
        insert contacts;
        // Call the opportunityCreation method
        Test.startTest();
        RelatedOpportunityCreation.opportunityCreation();
        Test.stopTest();
        // Query the created opportunities and assert their existence
        List<Contact> checkContact = [SELECT Id FROM Contact WHERE AccountId = :account.Id];
        System.assertEquals(1, checkContact.size());
    }
}