/**
 * OpportunityBatch class implements the Database.Batchable interface in Salesforce Apex.
 * It processes open opportunities that have passed the closing date, updates them to 'Closed Lost' stage,
 * adds a description indicating the missed deadline, and sends an email to the system administrator
 * with an attachment containing the opportunity records.
 */
global class OpportunityBatch implements Database.Batchable<SObject>, Database.Stateful{

    /**
     * start method is called at the beginning of the batch job and returns a QueryLocator
     * that defines the scope of records to be processed.
     */
    List<Opportunity> opportunitiesToUpdateList = new List<Opportunity>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Query for open opportunities that have passed the closing date
        String query = 'SELECT Id, Name, Account.Name, CloseDate, StageName FROM Opportunity WHERE StageName != \'Closed Lost\' AND CloseDate < TODAY AND IsClosed = false';
        return Database.getQueryLocator(query);
    }

    /**
     * execute method is called for each batch of records returned by the start method.
     * It updates the opportunities to 'Closed Lost' stage and adds a description,
     * and sends an email with an attachment to the system administrator.
     */
    global void execute(Database.BatchableContext bc, List<SObject> opportunityReocrdList) {
        try {
        for (SObject record : opportunityReocrdList) {
            Opportunity myOpportunity = (Opportunity)record;
            myOpportunity.StageName = 'Closed Lost';
            myOpportunity.Description = 'Opportunity closed due to missed deadline.';
            opportunitiesToUpdateList.add(myOpportunity);
        }
        //use try catch if there is an error in code it will print error
            //Check the list is not empty
            if (opportunitiesToUpdateList.size()>0) {
                //Update the opportunities
                update opportunitiesToUpdateList;
                
            }
        } catch (Exception errorInUpdateOpportunityRecord) {
            System.debug(errorInUpdateOpportunityRecord);
        }
    }
    
    /**
     * finish method is called at the end of the batch job.
     * It can be used for any cleanup or post-processing tasks.
     */
    global void finish(Database.BatchableContext bc) {
        sendEmailToAdminWithAttachment(opportunitiesToUpdateList);
    }

    /**
     * sendEmailToAdminWithAttachment method sends an email to the system administrator
     * with an attachment containing the opportunity records.
     */
    private void sendEmailToAdminWithAttachment(List<Opportunity> opportunityList) {
        try {
            //This string used for records header
            String finalBodyString = 'OpportunityId,OpportunityName,AccountName,CloseDate,StageName\n';
            //get Opportunity Records in and add into string
            for (Opportunity opportunityRecord : opportunityList) {
            String recordString = '"' + opportunityRecord.Id + '","' 
                                + opportunityRecord.Name + '","' 
                                + opportunityRecord.Account.Name + '","' 
                                + opportunityRecord.CloseDate + '","' 
                                + opportunityRecord.StageName + '"\n';
            finalBodyString = finalBodyString + recordString;
            }
            System.debug(finalBodyString);
            // Get the system administrator user
            User adminUser = [SELECT Id, Name, Profile.Name, Email 
                                FROM User 
                                WHERE Profile.Name = 'System Administrator' 
                                LIMIT 1];
        
                                // Create an email attachment with the opportunity records
                                Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
                                Blob csvBlob = Blob.valueOf(finalBodyString);
                                csvAttachment.setFileName('OpportunityRecords.csv');
            csvAttachment.setBody(csvBlob);
            
            // Create an email message
            Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
            singleEmail.setSubject('Opportunity Records attachment file');
            singleEmail.setToAddresses(new List<String>{adminUser.Email});
            singleEmail.setPlainTextBody('Hello ' + adminUser.Name + '\nHere is the attached file of opportunity records');
            singleEmail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
            
            // Send the email to the system administrator
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{singleEmail});
        
            // Check the success status of the email sending operation
            if (result[0].success) {
                // If the email was sent successfully, log a debug statement
                System.debug('Email sent successfully');
            }
        } catch (Exception errorInSendingMail) {
            System.debug(errorInSendingMail);
        }
        
    }
    
}