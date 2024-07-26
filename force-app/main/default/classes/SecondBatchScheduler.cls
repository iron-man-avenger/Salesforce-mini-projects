global with sharing class SecondBatchScheduler implements Schedulable{
    global void execute(SchedulableContext sc) {
        SecondBatch b = new SecondBatch(); 
        database.executebatch(b);
        
    }
    
}