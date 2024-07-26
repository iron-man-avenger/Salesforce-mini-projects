public with sharing class AccountRealtedOpportunityStageHandler implements TriggerHandler{
        //variable to disable this trigger 
    public static Boolean triggerDisabled = true;
    public static Boolean isFirstTime = true;

    //check if the trigger is disabled
    public Boolean isDisabled(){
        return triggerDisabled;
    }

    public void beforeInsert(List<sObject> newList) {
        // System.debug('Handler');
        // AccountTriggerHelper.doTask1(Trigger.new);
        // OpportunityHepler.changeAmountThenchangeDiscount(Trigger.new);
        // System.debug('After insert context is working');
    }

    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
        
    }

    public void beforeUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        // OpportunityHepler.changeAmountThenchangeDiscount(Trigger.new);
        // System.debug(Trigger.new);
        // System.debug('Before Update context changeAmountThenchangeDiscount is working');
        
        
        // SecondBatch obj = new SecondBatch();
        // ID JobId = Database.ExecuteBatch(obj, 200);
        // Map<Id, Opportunity> idOpportunityMap = new Map<Id, Opportunity>([Select Id, Amount,Name from Opportunity where Name = 'fgjdyj']);
        // for (Opportunity allopportunity : Trigger.new) {
        //         if (allopportunity.Amount != 0) {
        //         idOpportunityMap.put(allopportunity.id,allopportunity);
        // }
        // }
        // if (idOpportunityMap.size()>0) {
        //         Database.ExecuteBatch(new SecondBatch(idOpportunityMap));
        // }
        
        //Database.ExecuteBatch(new SecondBatch(newMap));


    }

    public void afterUpdate(Map<Id, sObject> newMap, Map<Id, sObject> oldMap) {
        // OpportunityHepler.changeAmountThenchangeDiscount(Trigger.new);
        System.debug('29999999');
        //AccountRealtedOpportunityStageHelper.changeStageinAccount(Trigger.new);
        // SecondBatch obj = new SecondBatch();
        // ID JobId = Database.ExecuteBatch(obj, 200);

        // System.debug('job id value: '+JobId);
    
    }

    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {

    }

    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {

    }
}