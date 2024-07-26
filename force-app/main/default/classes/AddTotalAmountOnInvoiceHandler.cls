public class AddTotalAmountOnInvoiceHandler implements TriggerHandler{

    //variable to disable this trigger 
    public static Boolean triggerDisabled = true;

    //check if the trigger is disabled
    public Boolean isDisabled(){
        return triggerDisabled;
    }

    public void beforeInsert(List<sObject> newList) {
        
    }

    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
        AddTotalAmountOnInvoiceHelper.amountUpdate(Trigger.new);
    }

    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
    }

    public void afterUpdate(List<sObject> newList, Map<Id, sObject> oldMap) {
        AddTotalAmountOnInvoiceHelper.amountUpdate(Trigger.new);

    }


    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {

    }
}