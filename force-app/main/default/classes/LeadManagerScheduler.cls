global class LeadManagerScheduler implements Schedulable {
    global void execute(SchedulableContext scheduleContext) {
        LeadManager newbatch = new LeadManager(); 
        database.executebatch(newbatch);
    }
}