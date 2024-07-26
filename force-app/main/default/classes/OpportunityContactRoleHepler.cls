public with sharing class OpportunityContactRoleHepler {
    // This helper method assigns a default Role to OpportunityContactRole records
    public static void assignContactRole(List<OpportunityContactRole> newRoles) {
        // Iterate over the OpportunityContactRole records
        for (OpportunityContactRole contactRole : newRoles) {
            // Check if the Role is blank
            if (String.isBlank(contactRole.Role)) {
                // Assign a default Role of 'Admin'
                contactRole.Role = 'Admin';
            }
        }
    }
}