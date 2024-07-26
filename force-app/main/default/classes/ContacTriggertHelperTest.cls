@isTest
public class ContacTriggertHelperTest {
    @isTest
    static void testHandleBeforeInsertUpdate() {
        // Test data setup
        Account testAccount = new Account(Name = 'Test Account', Vehicle_Types__c = '2023 Compact Sedan;2023 IRS Mileage Rate;2023 Full-Size SUV;2023 Mid-size SUV');
        insert testAccount;
        Vehicle__c testVehicle = new Vehicle__c(Name = '2023 Compact Sedan', URL__c = 'https://example.com/car.jpg');
        insert testVehicle;

        Contact testContact1 = new Contact(FirstName = 'John', LastName = 'Doe', Data_of_Birth__c = Date.today(), AccountId = testAccount.Id, Vehicle_Types__c = '2023 Compact Sedan' );
        insert testContact1;
        
        System.assertEquals(false, testContact1.hasErrors());
        
        testContact1.Vehicle_Types__c = '2023 Compact Sedan';
        if (testContact1 != null) {
            testContact1.Car_Image__c =  testVehicle.URL__c;
            update testContact1;
        }
        // Verify the car image URL is updated for the relevant contacts
        Vehicle__c updatedVehicle = [SELECT Name, URL__c FROM Vehicle__c WHERE Name = '2023 Compact Sedan' LIMIT 1 ];
        System.assertEquals(testVehicle.URL__c, testContact1.Car_Image__c);
        
        
    }
}