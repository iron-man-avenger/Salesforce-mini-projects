global class DemoClass implements Database.Batchable<SObject>{
   
    global Database.QueryLocator start(Database.BatchableContext bc) {
        Date cutoffDate = Date.today().addDays(-10);
        return Database.getQueryLocator([SELECT Id, Name, Email, Status FROM Lead WHERE status = 'New']);
    }

    global void execute(Database.BatchableContext bc, List<Lead> leads) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        List<Lead> closedLeads = new List<Lead>();
        for (Lead lead : leads) {
            lead.Status = 'Closed';
            closedLeads.add(lead);
            
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{lead.Email});
            email.setSubject('Lead Status Update: ' + lead.Name);
            email.setTemplateId('00X2w000000nJ3HEAU');
            //email.setPlainTextBody('Dear ' + lead.Name + ',\n\nSince we did not receive a reply to this request, we will have to close this case.\n\n	Though this case remains closed, please feel free to re-apply at any point of time.\n\nSincerely,\nGetOnCRM Solutions');
            emails.add(email);
            
        }
         
    if (closedleads.size() > 0) {
        Database.update(closedLeads);
    }
        
        Messaging.sendEmail(emails);
    }

    global void finish(Database.BatchableContext bc) {
       
    }
}