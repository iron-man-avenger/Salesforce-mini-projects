public with sharing class sendingMailToContactTriggerHandler implements TriggerHandler{
    //variable to disable this trigger 
    public static Boolean triggerDisabled = true;

    //check if the trigger is disabled
    public Boolean isDisabled(){
        return triggerDisabled;
    }

    public void beforeInsert(List<sObject> newList) {
        // System.debug('Handler');
        // AccountTriggerHelper.doTask1(Trigger.new);
    }

    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
        // sendingMailToContactTriggerHelper.sendingMail(Trigger.new);
    }

    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {

    }

    public void afterUpdate(List<SObject> newList,Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {

    }

    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {

    }
}