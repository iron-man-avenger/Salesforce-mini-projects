public class LeadTriggerHandler {
    // This method is called from the after update trigger context
    public static void afterUpdate(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
        // Call the handleAfterUpdate method of LeadTriggerHelper class
        LeadTriggerHelper.handleAfterUpdate(newLeads, oldLeadMap);
    }
}