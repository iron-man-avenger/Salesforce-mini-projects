global class SecondBatch implements Database.Batchable<sObject>,Database.Stateful {
    List<opportunity> listNameopp = new List<opportunity>();
    global Database.QueryLocator start(Database.BatchableContext BC) {   
        String query = 'SELECT  Id, Name, Amount, Discount__c FROM Opportunity Where Id != null AND Amount IN (0, 50, 100)';
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> myList) {
        if(AccountRealtedOpportunityStageHandler.isFirstTime){
            for (opportunity myOpportunity : myList){
                if ((myOpportunity.Amount == 100) || (myOpportunity.Amount == 50) 
                    || (myOpportunity.Amount == 0 || (myOpportunity.Amount == null))){
                    
                    if (myOpportunity.Amount == 100) {
                        myOpportunity.Discount__c = 0;
                    } 
                    else if (myOpportunity.Amount == 50) {
                        myOpportunity.Discount__c = 50;
                    } 
                    else if (myOpportunity.Amount == 0) {
                        myOpportunity.Discount__c = 100;
                    }
                    listNameopp.add(myOpportunity);
                }
            }
                
        }
    }   
                    

    global void finish(Database.BatchableContext BC ) {
        if (listNameopp.size()>0) {
            update listNameopp;
        }
        AccountRealtedOpportunityStageHandler.isFirstTime = false;
        System.debug(listNameopp);
    }
}