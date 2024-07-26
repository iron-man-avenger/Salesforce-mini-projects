@isTest
public class MixedDMLFutureTest {
    @isTest static void unitTest1() {
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        // System.runAs() allows mixed DML operations in test context
        System.runAs(thisUser) {
            // startTest/stopTest block to run future method synchronously
            try {
                Test.startTest();        
                MixedDMLFuture.useFutureMethod();
                Test.stopTest();
            } catch (Exception Error) {
                System.assert(false, 'Exception expected');
            }
        }
        // The future method will run after Test.stopTest();
        
        // Verify account is inserted
        Account[] accts = [SELECT Id from Account WHERE Name='Acme23'];
        System.assertEquals(1, accts.size());
        // Verify user is inserted
        User[] users = [SELECT Id from User where username='techdicer8786@techdicer.com'];
        System.assertEquals(1, users.size());
    }
}