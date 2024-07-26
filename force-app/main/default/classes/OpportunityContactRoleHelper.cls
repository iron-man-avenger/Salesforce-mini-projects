public with sharing class OpportunityContactRoleHelper {
    // This helper method assigns a default Role to OpportunityContactRole records
    public static void assignContactRole(List<OpportunityContactRole> newRolesList) {
        try {
            // Iterate over the OpportunityContactRole records
            for (OpportunityContactRole contactRole : newRolesList) {
                // Check if the Role is blank
                if (String.isBlank(contactRole.Role)) {
                    // Assign a default Role of 'Admin'
                    contactRole.Role = 'Admin';
                }
            }
        } catch (Exception error) {
            System.debug('The following exception has occurred: ' + error.getMessage());    
        }
    }
    
    // This method is called after new OpportunityContactRole records are inserted
    public static void handleAfterInsert(List<OpportunityContactRole> newOpportunityContactRoles, Map<Id, OpportunityContactRole> newOpportunityContactRoleMap) {
        try {
            Set<Id> opportunityIds = new Set<Id>();
            
            // Iterate over the new OpportunityContactRole records
            for (OpportunityContactRole individualMemberOpportunityContactRole : newOpportunityContactRoles) {
                // Check if the Role is 'Individual Member'
                if (individualMemberOpportunityContactRole.Role == 'Individual Member') {
                    // Add the OpportunityId to the set of opportunityIds
                    opportunityIds.add(individualMemberOpportunityContactRole.OpportunityId);
                }
            }
            
            // Call the updateCertificateCounts method to update the relevant certificates
            if (opportunityIds.size()>0) {
                updateCertificateCounts(opportunityIds);
            }
        } catch (Exception error) {
            System.debug('The following exception has occurred: ' + error.getMessage());    
        }
    }
    
    // This method is called after existing OpportunityContactRole records are deleted
    public static void handleAfterDelete(List<OpportunityContactRole> oldOpportunityContactRoles, 
                                        Map<Id, OpportunityContactRole> oldOpportunityContactRoleMap) {
        try {
            Set<Id> opportunityIds = new Set<Id>();
            
            // Iterate over the deleted OpportunityContactRole records
            for (OpportunityContactRole individualMemberOpportunityContactRole : oldOpportunityContactRoles) {
                // Check if the Role was 'Individual Member'
                if (individualMemberOpportunityContactRole.Role == 'Individual Member') {
                    // Add the OpportunityId to the set of opportunityIds
                    opportunityIds.add(individualMemberOpportunityContactRole.OpportunityId);
                }
            }
            
            // Call the updateCertificateCounts method to update the relevant certificates
            if (opportunityIds.size()>0) {
                updateCertificateCounts(opportunityIds);
            }
        } catch (Exception error) {
            System.debug('The following exception has occurred: ' + error.getMessage());    
        }
    }
    
    // This method updates the Count_of_Opportunity_Contact_Role__c field on related Certificate records
    public static void updateCertificateCounts(Set<Id> opportunityIds) {
        try {
            List<Certificate__c> certificatesToUpdate = new List<Certificate__c>();
            
            // Retrieve the existing Certificate records related to the provided opportunityIds
            List<Certificate__c> existingCertificates = [SELECT Id, Opportunity__c, Count_of_Opportunity_Contact_Role__c
                                                        FROM Certificate__c
                                                        WHERE Opportunity__c IN :opportunityIds];
        
            // Create a map of OpportunityId to corresponding Certificate record for efficient lookup
            Map<Id, Certificate__c> certificateMap = new Map<Id, Certificate__c>();
            for (Certificate__c existingCertificate : existingCertificates) {
                certificateMap.put(existingCertificate.Opportunity__c, existingCertificate);
            }
        
            // Query the count of OpportunityContactRole records with Role as 'Individual Member' for the given opportunityIds
            Map<Id, Integer> individualMemberCounts = new Map<Id, Integer>();
            for (AggregateResult result : [SELECT OpportunityId, COUNT(Id) individualMemberCount
                                            FROM OpportunityContactRole
                                            WHERE OpportunityId IN :opportunityIds AND Role = 'Individual Member'
                                            GROUP BY OpportunityId]) {

                // Extract the OpportunityId and corresponding count from the query results and store them in the individualMemberCounts map
                Id opportunityId = (Id)result.get('OpportunityId');
                Integer count = (Integer)result.get('individualMemberCount');
                individualMemberCounts.put(opportunityId, count);
            }
        
            // Iterate over the provided opportunityIds and update the Count_of_Opportunity_Contact_Role__c field on the related Certificate records
            for (Id opportunityId : opportunityIds) {
                Certificate__c existingCertificate = certificateMap.get(opportunityId);
                if (existingCertificate != null) {
                    Integer individualMemberCount = individualMemberCounts.get(opportunityId);
                    existingCertificate.Count_of_Opportunity_Contact_Role__c = individualMemberCount;
                    certificatesToUpdate.add(existingCertificate);
                }
            }
        
            // Update the relevant Certificate records if there are any changes
            if (certificatesToUpdate.size()>0) {
                update certificatesToUpdate;
            }
        
            // Output the updated certificates for debugging purposes
            System.debug(certificatesToUpdate);
        } catch (Exception error) {
            System.debug('The following exception has occurred: ' + error.getMessage());    
        }
    }
}