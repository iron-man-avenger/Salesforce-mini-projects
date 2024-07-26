public with sharing class GroheController1 {
    @AuraEnabled(cacheable=true)
    public static List<GROHE__c> getGroheRecords(String searchKey, String sortBy, String sortDirection) {
        // Define your SOQL query to retrieve GROHE records based on search, sort, and filter criteria
        String soqlQuery = 'SELECT Id, Name, Area__c, Code__c, Image__c, Discount__c, MRP__c, Quantity__c, Total__c FROM GROHE__c';
        
        if (!String.isBlank(searchKey)) {
            soqlQuery += ' WHERE (Name LIKE \'%' + searchKey + '%\' OR Area__c LIKE \'%' + searchKey + '%\'  OR Code__c LIKE \'%' + searchKey + '%\')';
        }        
    
        if (!String.isBlank(sortBy) && !String.isBlank(sortDirection)) {
            soqlQuery += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
    
        List<GROHE__c> groheRecords = Database.query(soqlQuery);
    
        return groheRecords;
    }
    
    @AuraEnabled
    public static void generatePDF(List<String> selectedRecordIds) {
        if (selectedRecordIds.isEmpty()) {
            // Handle the case where no records are selected
            return;
        }
    
        // Generate the PDF using the selected record ids
        // ...
    }
}
