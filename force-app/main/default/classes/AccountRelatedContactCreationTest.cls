@IsTest
private class AccountRelatedContactCreationTest {
    @IsTest
    static void testContactCreation() {
        // Create test Account
        Account account = new Account(Name = 'Test Account');
        insert account;
        // Create test Contacts
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 1; i++) {
            Contact newcontact = new Contact(
                    LastName = 'Contact for Account ' + account.Name,
                    AccountId = account.Id
                    );
                    contacts.add(newcontact);
                }
                try {
            if (contacts.size()>0) {
                insert contacts;
            }
            // Call the contactCreation method
            Test.startTest();
            AccountRelatedContactCreation.contactCreation();
            Test.stopTest();
            // Query the created contact and assert their existence
            List<Contact> checkContact = [SELECT Id FROM Contact WHERE AccountId = :account.Id];
            System.assertEquals(1, checkContact.size());
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}