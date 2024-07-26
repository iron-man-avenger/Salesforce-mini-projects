public with sharing class TriggerDispatcher {
    public static void run(TriggerHandler handler, String triggerName){

        //trigger active information 
        Boolean isActive = true;

        if(isActive){
            //Check trigger context from trigger operation type
            switch on Trigger.operationType {

                when BEFORE_INSERT {
                    //Invoke before insert trigger handler
                    handler.beforeInsert(Trigger.new);
                }
                when AFTER_INSERT {
                    //Invoke after insert trigger handler
                    handler.afterInsert(Trigger.new, Trigger.newMap);
                }
                when BEFORE_UPDATE {
                    //Invoke before update trigger handler
                    handler.beforeUpdate(Trigger.newMap , Trigger.oldMap);
                }
                when AFTER_UPDATE {
                    //Invoke after update trigger handler
                    handler.afterUpdate(Trigger.new, Trigger.newMap);
                }
                when BEFORE_DELETE {
                    //Invoke before delete trigger handler
                    handler.beforeDelete(Trigger.old, Trigger.oldMap);
                }
                when AFTER_DELETE {
                    //Invoke after delete trigger handler
                    handler.afterDelete(Trigger.old, Trigger.oldMap);
                }
                when AFTER_UNDELETE {
                    //Invoke after undelete trigger handler
                    handler.afterUnDelete(Trigger.new, Trigger.newMap);
                }
            }
        }
    }
}