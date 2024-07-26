global class AccountUpdateBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {        
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> myList) {
        
        System.debug('Batch job is running.............');
    }   
    
    global void finish(Database.BatchableContext BC) {
        // for (integer i=1; i<2; i++) {
        //     System.enqueueJob(new QueueableWithFuture(), 2); 
        //     System.debug('running queue..' + i);
        // }
        for (integer i=1; i<102; i++) {
            DataBase.executeBatch(new SecondBatch(), 100);
        }
        System.debug('Batch job is finished.............');
    }
}