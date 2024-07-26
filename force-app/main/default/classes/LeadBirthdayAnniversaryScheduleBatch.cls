global with sharing class LeadBirthdayAnniversaryScheduleBatch {
    global void execute(SchedulableContext scheduleContenx) {
        LeadBirthdayAnniversaryEmailBatch newBatch = new LeadBirthdayAnniversaryEmailBatch(); 
        database.executebatch(newBatch);
    }
}