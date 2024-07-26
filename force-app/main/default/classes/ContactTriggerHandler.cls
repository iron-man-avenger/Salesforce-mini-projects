public class ContactTriggerHandler implements TriggerHandler{

    //variable to disable this trigger 
    public static Boolean triggerDisabled = true;

    //check if the trigger is disabled
    public Boolean isDisabled(){
        return triggerDisabled;
    }

    public void beforeInsert(List<sObject> newList) {
        ContacTriggertHelper.handleBeforeInsertUpdate(Trigger.new);
    }

    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {

    }

    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        ContacTriggertHelper.handleBeforeInsertUpdate(Trigger.new);
    }

    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap) {
        
    }


    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {

    }
}