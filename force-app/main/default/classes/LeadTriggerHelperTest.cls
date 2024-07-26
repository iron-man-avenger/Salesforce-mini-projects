@isTest
public class LeadTriggerHelperTest {
    @isTest
    public static void testHandleAfterUpdate() {
        // Create test data
        Lead lead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Status = 'New',
            Company = 'MicroSoft',
            Data_of_Birth__c = Date.today()
        );
        //Check the lead is not null
        if (lead != null) {
            insert lead;
        }
        // Create a map of old Lead records
        Map<Id, Lead> oldLeadMap = new Map<Id, Lead>();
        oldLeadMap.put(lead.Id, lead);
        // Update the Lead record's status to 'Paper Test'
        lead.Status = 'Paper Test';
        //Check the lead is not null
        if (lead != null) {
            update lead;
        }
        // Create a test Paper_Test__c record related to the Lead
        Paper_Test__c paperTest1 = new Paper_Test__c(Related_To_Lead__c = lead.Id);
        insert paperTest1;

        // Verify the creation of Paper_Test__c record
        List<Paper_Test__c> paperTests = [SELECT Version__c, Test_Date__c, Language__c, Count_of_lead_status__c, 
                                        Related_To_Lead__c 
                                        FROM Paper_Test__c 
                                        WHERE Related_To_Lead__c = :lead.Id];
        System.assertEquals(2, paperTests.size());
        Paper_Test__c paperTest = paperTests[0];
        System.assertEquals('5.0', paperTest.Version__c);
        System.assertEquals(Date.today(), paperTest.Test_Date__c);
        System.assertEquals('Sanskrit', paperTest.Language__c);
        System.assertEquals(lead.Id, paperTest.Related_To_Lead__c);
        System.assertEquals(null, paperTest.Count_of_lead_status__c);


        // Create a map of old Paper_Test__c records
        Map<Id, Paper_Test__c> oldPaperTestMap = new Map<Id, Paper_Test__c>();
        oldPaperTestMap.put(paperTest.Id, paperTest);
        
        
        // Verify the creation of Event record
        List<Event> events = [SELECT Subject, WhatId, ActivityDate, IsAllDayEvent FROM Event];
        System.assertEquals(1, events.size());

        if (!events.isEmpty()) {
        Event revisitEvent = events[0];
        System.assertEquals('Revisit Lead', revisitEvent.Subject);
        System.assertEquals(paperTest.Id, revisitEvent.WhatId);
        System.assertEquals(Date.today(), revisitEvent.ActivityDate);
        } else {
        // Handle the case when the list is empty
        System.assert(false, 'No events found');
        }

    }
}