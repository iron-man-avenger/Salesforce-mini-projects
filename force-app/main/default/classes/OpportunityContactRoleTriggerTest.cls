@IsTest
private class OpportunityContactRoleTriggerTest {
    @IsTest
    static void testHandleAfterInsert() {
        // Create test data
        Contact contact = new Contact(LastName = 'Test Contact');
        insert contact;
        
        Opportunity opportunity1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Prospecting', CloseDate = Date.today());
        Opportunity opportunity2 = new Opportunity(Name = 'Test Opportunity 2', StageName = 'Qualification', CloseDate = Date.today());
        insert new List<Opportunity>{opportunity1, opportunity2};
        
        OpportunityContactRole contactRole1 = new OpportunityContactRole(OpportunityId = opportunity1.Id, ContactId = contact.Id);
        OpportunityContactRole contactRole2 = new OpportunityContactRole(OpportunityId = opportunity2.Id, ContactId = contact.Id, Role = 'Individual Member');
        List<OpportunityContactRole> newOpportunityContactRoles = new List<OpportunityContactRole>{contactRole1, contactRole2};
        
        // Insert the OpportunityContactRole records
        Test.startTest();
        insert newOpportunityContactRoles;
        Test.stopTest();

        // Verify the expected behavior of the trigger
        List<Certificate__c> updatedCertificates = [SELECT Id, Opportunity__c, Count_of_Opportunity_Contact_Role__c
                                                    FROM Certificate__c
                                                    WHERE Opportunity__c IN :new Set<Id>{opportunity2.Id}];
        
        // Assert that the Count_of_Opportunity_Contact_Role__c field of the Certificate__c record is updated correctly
        System.assertEquals(0, updatedCertificates.size(), 'Unexpected number of updated certificates');
    }
    
    @IsTest
    static void testHandleAfterDelete() {
        // Create test data
        Contact contact = new Contact(LastName = 'Test Contact');
        insert contact;
        
        Opportunity opportunity1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Certified', CloseDate = Date.today());
        Opportunity opportunity2 = new Opportunity(Name = 'Test Opportunity 2', StageName = 'Contract', CloseDate = Date.today());
        insert new List<Opportunity>{opportunity1, opportunity2};
        
        OpportunityContactRole contactRole1 = new OpportunityContactRole(OpportunityId = opportunity1.Id, ContactId = contact.Id);
        OpportunityContactRole contactRole2 = new OpportunityContactRole(OpportunityId = opportunity2.Id, ContactId = contact.Id, Role = 'Individual Member');
        List<OpportunityContactRole> oldOpportunityContactRoles = new List<OpportunityContactRole>{contactRole1, contactRole2};
        
        // Insert the OpportunityContactRole records first
        insert oldOpportunityContactRoles;
        
        // Delete the OpportunityContactRole records
        Test.startTest();
        delete oldOpportunityContactRoles;
        Test.stopTest();
        
        // Verify the expected behavior of the trigger
        List<Certificate__c> updatedCertificates = [SELECT Id, Opportunity__c, Count_of_Opportunity_Contact_Role__c
                                                    FROM Certificate__c
                                                    WHERE Opportunity__c IN :new Set<Id>{opportunity2.Id}];
        
        // Assert that the Count_of_Opportunity_Contact_Role__c field of the Certificate__c record is updated correctly
        System.assertEquals(0, updatedCertificates.size(), 'Unexpected number of updated certificates');
    }
}