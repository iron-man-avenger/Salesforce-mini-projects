// This class is a trigger handler for the OpportunityContactRole object.
// It provides methods to handle various trigger events on OpportunityContactRole records.
public class OpportunityContactRoleTriggerHandler implements TriggerHandler {

    // Variable to disable this trigger
    public static Boolean triggerDisabled = true;

    // Check if the trigger is disabled
    public Boolean isDisabled() {
        return triggerDisabled;
    }

    // This method is executed before inserting OpportunityContactRole records
    public void beforeInsert(List<sObject> newList) {
        // Call the assignContactRole method of OpportunityContactRoleHelper class
        // OpportunityContactRoleHelper.assignContactRole(Trigger.new);
    }
    
    // This method is executed after inserting OpportunityContactRole records
    public static void afterInsert(List<SObject> newRecords, Map<Id, SObject> newRecordMap) {
        OpportunityContactRoleHelper.handleAfterInsert((List<OpportunityContactRole>) newRecords, (Map<Id, OpportunityContactRole>) newRecordMap);
    }

    // This method is executed before updating OpportunityContactRole records
    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        // No action is performed in this method
    }

    // This method is executed after updating OpportunityContactRole records
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap) {
        // No action is performed in this method
    }

    // This method is executed before deleting OpportunityContactRole records
    public void beforeDelete(List<sObject> oldList, Map<Id, sObject> oldMap) {
        // No action is performed in this method
    }

    // This method is executed after deleting OpportunityContactRole records
    public static void afterDelete(List<SObject> oldRecords, Map<Id, SObject> oldRecordMap) {
        OpportunityContactRoleHelper.handleAfterDelete((List<OpportunityContactRole>) oldRecords, (Map<Id, OpportunityContactRole>) oldRecordMap);
    }

    // This method is executed after undeleting OpportunityContactRole records
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
        // No action is performed in this method
    }
    
}