// Trigger: duplicateLead
// This trigger is executed after the insert and update operations on the Lead object.
trigger duplicateLead on Lead (after insert, after update) {

    
    // Check if the trigger context is after update
    if (Trigger.isAfter && Trigger.isUpdate) {
        // Call the afterUpdate method in the LeadTriggerHandler class and pass the trigger context variables
        LeadTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}

    // if(duplicateLeadTriggerHelper.runOnce()){
    //     List<Lead> leadList = new List<Lead>();
    //     leadList = Trigger.new.deepClone();
    //     insert leadList;
    // }