global class OpportunityScheduleBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
        OpportunityBatch b = new OpportunityBatch(); 
        database.executebatch(b);
    }
}