trigger OpportunityContactRoleTrigger on OpportunityContactRole (after insert, before insert, after update, after delete) {
    
    TriggerDispatcher.run(new OpportunityContactRoleTriggerHandler() , 'OpportunityContactRoleTrigger');

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            OpportunityContactRoleTriggerHandler.afterInsert(Trigger.new, Trigger.newMap);
        } else if (Trigger.isDelete) {
            OpportunityContactRoleTriggerHandler.afterDelete(Trigger.old, Trigger.oldMap);
        }
    }
    
}