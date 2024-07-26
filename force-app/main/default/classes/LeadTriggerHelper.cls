public class LeadTriggerHelper {
    // This class serves as a helper class for handling logic related to Lead triggers.
    // This method is triggered after Lead records are updated.
    public static void handleAfterUpdate(List<Lead> newLeadsList, Map<Id, Lead> oldLeadMap) {
        try {
            // Create empty lists to store records that need to be created
            List<Paper_Test__c> paperTestsToCreateList = new List<Paper_Test__c>();
            List<Paper_Test__c> newPaperTestList = new List<Paper_Test__c>();
            Map<Id, Paper_Test__c> oldPaperTestMap = new Map<Id, Paper_Test__c>();
            List<Event> eventsToCreateList = new List<Event>();
            Map<Id, Lead> newLeadMap = new Map<Id, Lead>(newLeadsList);
            List<Lead> newLeadlist = new List<Lead>();
            Set<Id> leadIds = new Set<Id>();
            // Iterate over each Lead record in the newLeadsList
            for (Lead leadRecord : newLeadsList) {
                // Get the corresponding old Lead record from the oldLeadMap based on the Lead Id
                Lead oldLeadRecord = oldLeadMap.get(leadRecord.Id);
                // Check if the Lead's status changed to 'Paper Test' from a different status or if it's a new Lead
                if (leadRecord.Status == 'Paper Test' && (oldLeadRecord == null || oldLeadRecord.Status != 'Paper Test' || newLeadMap.get(leadRecord.Id).Status == 'Paper Test')) {
                    // Check if there is no existing Paper Test related to this Lead
                    if (!hasExistingPaperTest(leadRecord.Id)) {
                        // Create a new Paper Test record with specific field values
                        Paper_Test__c paperTest = new Paper_Test__c(
                            Version__c = '5.0',
                            Test_Date__c = Date.today(),
                            Language__c = 'Sanskrit',
                            Related_To_Lead__c = leadRecord.Id
                        );
                        // Add the Paper Test record to the list for insertion
                        paperTestsToCreateList.add(paperTest);
                    }
                    // Update the count in the Paper Test object field for the Lead
                    updateLeadStatusCount(leadRecord.Id);
                }
                // Check if the Lead's status changed from 'In Progress' to 'Paper Test'
                if (leadRecord.Status == 'Paper Test' && oldLeadRecord != null && oldLeadRecord.Status == 'In Progress') {
                    // This part of the code is empty and no logic is implemented here.
                    eventOnPaperTestObject(newPaperTestList, oldPaperTestMap);
                }
                // Collect Lead Ids for further processing
                leadIds.add(leadRecord.Id);
                newLeadlist.add(leadRecord);
            }
            // Insert the newly created Paper Test records
            if (paperTestsToCreateList.size() > 0) {
                insert paperTestsToCreateList;
            }
            // Check if there are any existing Paper Test records related to the Leads
            if (leadIds.size() > 0) {
                newPaperTestList = [SELECT Id FROM Paper_Test__c WHERE Related_To_Lead__c IN :leadIds];
                oldPaperTestMap = new Map<Id, Paper_Test__c>(newPaperTestList);
            }
            // Invoke the eventOnPaperTestObject method for further processing
            if (newPaperTestList.size() > 0) {
                eventOnPaperTestObject(newPaperTestList, oldPaperTestMap);
            }
            // Debug output for the created Paper Test records
            System.debug(paperTestsToCreateList);
        } catch (Exception error) {
            // Debug output for any exceptions that occur
            System.debug('The following exception has occurred: ' + error.getMessage());
        }
    }
    // This method handles the creation of Revisit Event records on the Paper Test object.
    private static void eventOnPaperTestObject(List<Paper_Test__c> newPaperTestList, Map<Id, Paper_Test__c> oldPaperTestMap) {
        List<Event> eventsToCreateList = new List<Event>();
        for (Paper_Test__c paperTestRecord : newPaperTestList) {
            Paper_Test__c oldPaperTestRecord = oldPaperTestMap.get(paperTestRecord.Id);
            // Check if there is no existing Revisit Event related to this Lead
            if (!hasExistingRevisitEvent(paperTestRecord.Id)) {
                // Create a new Event record for revisiting the Lead
                Event revisitEvent = new Event(
                    Subject = 'Revisit Lead',
                    WhatId = paperTestRecord.Id,
                    ActivityDate = Date.today(),
                    IsAllDayEvent = true
                );
                // Add the Revisit Event record to the list for insertion
                eventsToCreateList.add(revisitEvent);
            }
        }
        // Insert the newly created Revisit Event records
        if (eventsToCreateList.size() > 0) {
            insert eventsToCreateList;
        }
        // Debug output for the created Revisit Event records
        System.debug(eventsToCreateList);
    }
    // Check if there is an existing Paper Test related to the Lead
    private static boolean hasExistingPaperTest(Id leadId) {
        Integer count = [SELECT COUNT() FROM Paper_Test__c WHERE Related_To_Lead__c = :leadId];
        return count > 0;
    }
    // Check if there is an existing Revisit Event related to the Lead
    private static boolean hasExistingRevisitEvent(Id papertestId) {
        Integer count = [SELECT COUNT() FROM Event WHERE WhatId = :papertestId AND Subject = 'Revisit Lead'];
        return count > 0;
    }
    // Update the count of Lead status in the Paper Test object field
    private static void updateLeadStatusCount(Id leadId) {
        try {
            // Retrieve existing Paper Test records related to the Lead
            List<Paper_Test__c> existingPaperTestsList = [SELECT Id, Count_of_lead_status__c FROM Paper_Test__c WHERE Related_To_Lead__c = :leadId];
            // Update the count in the first existing Paper Test record (if any)
            if (!existingPaperTestsList.isEmpty()) {
                Paper_Test__c paperTest = existingPaperTestsList[0];
                // Increment the count by 1 or set it to 1 if it was null
                paperTest.Count_of_lead_status__c = paperTest.Count_of_lead_status__c != null ? paperTest.Count_of_lead_status__c + 1 : 1;
                // Update the Paper Test record
                if (paperTest != null) {
                    update paperTest;
                }
            }
        } catch (Exception error) {
            // Debug output for any exceptions that occur
            System.debug('The following exception has occurred: ' + error.getMessage());
        }
    }
}