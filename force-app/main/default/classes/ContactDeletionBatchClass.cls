public class ContactDeletionBatchClass implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT Id FROM Contact WHERE Name LIKE \'%Test%\'';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext context, List<Contact> scope) {
        List<Contact> contactsToDelete = new List<Contact>();
        
        for (Contact contact : scope) {
            contactsToDelete.add(contact);
        }
        
        if (!contactsToDelete.isEmpty()) {
            delete contactsToDelete;
        }
    }
    
    public void finish(Database.BatchableContext context) {
        // Optional finishing logic
    }
}