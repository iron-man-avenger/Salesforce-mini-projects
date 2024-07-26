@isTest
private class AccountBillingCityHelperTest {
    @isTest
    static void testHandleAfterUpdate() {
        // Test data setup
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();

        // Create test accounts
        Account account1 = new Account(Name = 'Test Account 1', BillingCity = 'City1');
        Account account2 = new Account(Name = 'Test Account 2', BillingCity = 'City2');
        accounts.add(account1);
        accounts.add(account2);
        insert accounts;

        // Create related test contacts
        Contact contact1 = new Contact(FirstName = 'Test', LastName = 'Contact 1', Data_of_Birth__c = Date.today(), MailingCity = 'City1', AccountId = account1.Id);
        Contact contact2 = new Contact(FirstName = 'Test', LastName = 'Contact 2', Data_of_Birth__c = Date.today(), MailingCity = 'City2', AccountId = account2.Id);
        Contact contact3 = new Contact(FirstName = 'Test', LastName = 'Contact 3', Data_of_Birth__c = Date.today(), MailingCity = 'City3', AccountId = account2.Id);
        contacts.add(contact1);
        contacts.add(contact2);
        contacts.add(contact3);
        insert contacts;

        // Update the BillingCity field on the accounts
        account1.BillingCity = 'City1-updated';
        account2.BillingCity = 'City2-updated';
        update accounts;

        // Call the handleAfterUpdate method
        Test.startTest();
        AccountBillingCityHelper.handleAfterUpdate(accounts, new Map<Id, sObject>(accounts), new Map<Id, sObject>());
        Test.stopTest();

        // Verify the updated MailingCity values on the contacts
        contacts = [SELECT Id, MailingCity FROM Contact WHERE Id IN :contacts];
        System.assertEquals('City1-updated', contacts[0].MailingCity);
        System.assertEquals('City2-updated', contacts[1].MailingCity);
        System.assertEquals('City2-updated', contacts[2].MailingCity);
    }
}