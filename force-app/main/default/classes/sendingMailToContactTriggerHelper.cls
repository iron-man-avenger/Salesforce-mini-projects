public with sharing class sendingMailToContactTriggerHelper {
    public static void sendingMail(List<Contact> conlist) {
        List<Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body 
                                        from EmailTemplate 
                                        where name = 'Create Contact'];
        for(Contact conObj : conlist){
            if (conObj.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(conObj.Id);
                mail.setSenderDisplayName('System Administrator');
                mail.setUseSignature(false);
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
                mail.setTemplateID(emailTemplate.Id);
                mail.toAddresses = new String[]{conObj.Email};
                emailList.add(mail);
            }
        }
        if(emailList.size()>0){
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
                if (results[0].success){
                    System.debug('The email was sent successfully.');
                } 
                else {
                    System.debug('The email failed to send: '+ results[0].errors[0].message);
                }
        }
    }
}