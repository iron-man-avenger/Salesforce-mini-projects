public class AccountTriggerHandler implements TriggerHandlerForAccount{

    //variable to disable this trigger 
    public static Boolean triggerDisabled = true;

    //check if the trigger is disabled
    public Boolean isDisabled(){
        return triggerDisabled;
    }

    public void beforeInsert(List<sObject> newList) {
        // AccountTriggerHelper.accAddressUpdate(Trigger.new);
        
        
    }

    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
    //     AccountTriggerHelper.sendEmailToAdmin(Trigger.new);
    //     AccountTriggerHelper.updateClientContactFieldOnAccount(Trigger.new);
    }

    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        // AccountTriggerHelper.accAddressUpdate(Trigger.new);
        // AccountTriggerHelper.totalAmountofRelatedOpp(Trigger.new);
    }

    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        // AccountTriggerHelper.updateAccRelatedOpp(Trigger.new);
        AccountBillingCityHelper.handleAfterUpdate(Trigger.new, Trigger.newMap, Trigger.oldMap);
    }


    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {

    }
}