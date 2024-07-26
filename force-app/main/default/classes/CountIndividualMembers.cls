public with sharing class CountIndividualMembers {
  public static void updateCertificateCounts(List<sObject> myList) {
      // Collect all Opportunity IDs
      Set<Id> opportunityIds = new Set<Id>();
      for (sObject record : myList) {
          if (record instanceof Opportunity) {
              Opportunity opportunity = (Opportunity)record;
              opportunityIds.add(opportunity.Id);
          }
      }
      // Query for the count of Opportunity Contact Roles with the role 'Individual Member'
      Map<Id, Integer> opportunityRoleCounts = new Map<Id, Integer>();
      for (AggregateResult result : [
          SELECT OpportunityId, COUNT(Id) roleCount
          FROM OpportunityContactRole
          WHERE OpportunityId IN :opportunityIds AND Role = 'Individual Member'
          GROUP BY OpportunityId
      ]) {
          opportunityRoleCounts.put((Id)result.get('OpportunityId'), (Integer)result.get('roleCount'));
      }
      // Retrieve and update the associated Certificate objects
      List<Certificate__c> certificatesToUpdate = new List<Certificate__c>();
      for (Opportunity opportunity : [SELECT Id, (SELECT Id, Count_of_Opportunity_Contact_Role__c FROM Certificates__r LIMIT 1) FROM Opportunity WHERE Id IN :opportunityIds]) {
          Certificate__c certificate = opportunity.Certificates__r.isEmpty() ? new Certificate__c() : opportunity.Certificates__r[0];
          certificate.Opportunity__c = opportunity.Id;
          certificate.Name = 'Certificate for ' + opportunity.Name;
          certificate.Count_of_Opportunity_Contact_Role__c = opportunityRoleCounts.get(opportunity.Id);
          certificatesToUpdate.add(certificate);
      }
      // Save the updated Certificate objects
      if (!certificatesToUpdate.isEmpty()) {
          update certificatesToUpdate;
      }
      System.debug(certificatesToUpdate);
  }
}