// This is a test class for the CountOpportunityContactRole Apex class.
// It is annotated with @isTest to indicate that it is a test class.
// The class is defined as private to ensure it is only accessible within the test context.
@isTest
private class CountOpportunityContactRoleTest {

    // This is a test method that tests the functionality of the
    // CountOpportunityContactRole.CountOpportunityContactRoleWithIndividualMember() method.
    // It is annotated with @isTest to indicate that it is a test method.
    @isTest
    static void testCountOpportunityContactRoleWithIndividualMember() {

        
        // Create a test Contact record that will be associated with the OpportunityContactRole.
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe'
        );
        if (testContact != null) {
            insert testContact;
            
        }

        // Create a test Opportunity record.
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );
        insert testOpportunity;

        // Create three OpportunityContactRole records with the 'Individual Member' role
        // and associate them with the test Opportunity and Contact.
        List<OpportunityContactRole> testContactRoles = new List<OpportunityContactRole>();
        for (Integer i = 0; i < 3; i++) {
            OpportunityContactRole contactRole = new OpportunityContactRole(
                OpportunityId = testOpportunity.Id,
                Role = 'Individual Member',
                ContactId = testContact.Id
            );
            testContactRoles.add(contactRole);
        }
        insert testContactRoles;

        // Create a test Certificate record associated with the test Opportunity.
        Certificate__c testCertificate = new Certificate__c(Opportunity__c = testOpportunity.Id);
        insert testCertificate;

        // Call the method to be tested
        // Call the method under test within Test.startTest() and Test.stopTest() blocks.
        // This ensures that any asynchronous operations triggered by the method are completed
        // and allows the test framework to collect performance data.
        Test.startTest();
        CountOpportunityContactRole.CountOpportunityContactRoleWithIndividualMember();
        Test.stopTest();

        // Retrieve the updated Certificate record.
        Certificate__c updatedCertificate = [SELECT Count_of_Opportunity_Contact_Role__c
                                            FROM Certificate__c
                                            WHERE Id = :testCertificate.Id];

        // Assert the count is correct
        // Verify that the Count_of_Opportunity_Contact_Role__c field on the Certificate record
        // has been correctly updated to the expected count.
        System.assertEquals(3, updatedCertificate.Count_of_Opportunity_Contact_Role__c);
    }
}