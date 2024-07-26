public class LeadBirthdayAnniversaryEmailBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        Date currentDate = Date.today();
        return Database.getQueryLocator([
            SELECT Id, FirstName, LastName, Email, Data_of_Birth__c, Date_of_Anniversary__c
            FROM Contact
            WHERE (Data_of_Birth__c = :currentDate AND Data_of_Birth__c != NULL)
                OR (Date_of_Anniversary__c = :currentDate AND Date_of_Anniversary__c != NULL)
        ]);
    }
    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        try{
            List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
            Set<Id> uniqueContactIds = new Set<Id>();
            // Retrieve email template Ids from custom metadata
            Map<String, String> emailTemplateIdsMap = new Map<String, String>();
            for (Email_Template__mdt template : [SELECT DeveloperName, Template_Id__c FROM Email_Template__mdt]) {
                emailTemplateIdsMap.put(template.DeveloperName, template.Template_Id__c);
            }
            for (Contact contact : contacts) {
                // Check if both birthday and anniversary fall on the same date for the contact
                if (contact.Data_of_Birth__c == contact.Date_of_Anniversary__c && contact.Data_of_Birth__c == Date.today()) {
                    if (uniqueContactIds.contains(contact.Id)) {
                        continue; // Skip sending another email if already sent for the same contact
                    }
                    uniqueContactIds.add(contact.Id);
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setTargetObjectId(contact.Id);
                    email.setTemplateId(emailTemplateIdsMap.get('General_Template'));
                    email.setToAddresses(new List<String>{contact.Email});
                    email.setSaveAsActivity(false);
                    emailMessages.add(email);
                }
                // Send birthday email if applicable
                else if (contact.Data_of_Birth__c != null && contact.Data_of_Birth__c.day() == Date.today().day()) {
                    if (uniqueContactIds.contains(contact.Id)) {
                        continue; // Skip sending another email if already sent for the same contact
                    }
                    uniqueContactIds.add(contact.Id);
                    Messaging.SingleEmailMessage birthdayEmail = new Messaging.SingleEmailMessage();
                    birthdayEmail.setTargetObjectId(contact.Id);
                    birthdayEmail.setTemplateId(emailTemplateIdsMap.get('Birthday_Template'));
                    birthdayEmail.setToAddresses(new List<String>{contact.Email});
                    birthdayEmail.setSaveAsActivity(false);
                    emailMessages.add(birthdayEmail);
                }
                // Send anniversary email if applicable
                else if (contact.Date_of_Anniversary__c != null && contact.Date_of_Anniversary__c.day() == Date.today().day()) {
                    if (uniqueContactIds.contains(contact.Id)) {
                        continue; // Skip sending another email if already sent for the same contact
                    }
                    uniqueContactIds.add(contact.Id);
                    Messaging.SingleEmailMessage anniversaryEmail = new Messaging.SingleEmailMessage();
                    anniversaryEmail.setTargetObjectId(contact.Id);
                    anniversaryEmail.setTemplateId(emailTemplateIdsMap.get('Anniversary_Template'));
                    anniversaryEmail.setToAddresses(new List<String>{contact.Email});
                    anniversaryEmail.setSaveAsActivity(false);
                    emailMessages.add(anniversaryEmail);
                }
            }
            // Send the emails
            List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(emailMessages);
            // Process the results if needed
            for (Messaging.SendEmailResult result : emailResults) {
                if (result.isSuccess()) {
                    // Email sent successfully
                    System.debug('Email sent successfully');
                } else {
                    // Email failed to send
                    System.debug('Email failed to send: ' + result.getErrors()[0].getMessage());
                }
            }
        } catch (Exception error) {
            // Debug output for any exceptions that occur
            System.debug('The following exception has occurred: ' + error.getMessage());
        }
    }
    public void finish(Database.BatchableContext context) {
    }
}