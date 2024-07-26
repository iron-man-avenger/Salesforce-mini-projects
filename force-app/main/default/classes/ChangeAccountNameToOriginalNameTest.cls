@isTest
private class ChangeAccountNameToOriginalNameTest {
    @testSetup
    static void createTestData() {
        // Create test data
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<5; i++) {
            Account newaccount = new Account(Name='Test Account '+i);
            accounts.add(newaccount);
        }
        insert accounts;
        // Add accounts with 'Update by Batch job' in their name
        List<Account> accountsToUpdate = new List<Account>();
        for(Integer i=5; i<10; i++) {
            Account newaccount = new Account(Name='Test Account '+i+' Update by Batch job');
            accountsToUpdate.add(newaccount);
        }
        try {
            if (accountsToUpdate.size()>0) {
                insert accountsToUpdate;
            }
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
    @isTest
    static void testGetOriginalName() {
        // Call the method to test
            ChangeAccountNameToOriginalName.GetOriginalName();
            // Verify that the account names have been updated correctly
            List<Account> updatedAccounts = [SELECT Id, Name FROM Account WHERE Name LIKE '%Update by Batch job%'];
            System.assertEquals(0, updatedAccounts.size(), 'Accounts with "Update by Batch job" in their name should have been updated');
            System.assert(false, 'Exception expected');
    }
}