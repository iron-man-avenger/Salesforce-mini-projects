global class LeadManager implements Database.Batchable<SObject>{

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
        
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId('00Q2w00000TcNh8EAF');
              //message.setSenderDisplayName('Company Support');
              //message.setReplyTo('dhiraj.lohar@getoncrm.com');
            message.setUseSignature(false);
            message.setBccSender(false);
            message.setSaveAsActivity(false);
            EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'ClosedTemp'];
            message.setTemplateID(emailTemplate.Id);
             //message.setWhatId('00Q8Z00001gDVptUAG'); //This is important for the merge fields in template to work
            message.setToAddresses(new List<String>{lead.Email});
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            message.setToAddresses(new List<String>{lead.Email});
           //email.setSubject('Lead Status Update: ' + lead.Name);
           //EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'ClosedTemp'];
            //email.setTemplateID(emailTemplate.Id); 
           //email.setTemplateId('00X2w000000nJ3HEAU');
           //email.setHtmlBody(emailTemplate.HtmlValue);
            emails.add(message);


        }
        System.debug(emails);
        if (closedleads.size() > 0) {
        Database.update(closedLeads);
        }
        Messaging.sendEmail(emails);
    }

    global void finish(Database.BatchableContext bc) {
    
    }
}