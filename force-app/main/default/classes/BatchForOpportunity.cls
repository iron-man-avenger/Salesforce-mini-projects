global class BatchForOpportunity implements Database.Batchable<sObject>{ 
    // Map<id,Opportunity> IdOpportunityMapBatch=new Map<id,Opportunity>();
    // global BatchForOpportunity(Map<id,Opportunity> IdOpportunityMap)
    // {
    //     IdOpportunityMapBatch=IdOpportunityMap; 
    // } 
        
    global Database.QueryLocator start(Database.BatchableContext BC) { 
            return Database.getQueryLocator([SELECT id,Amount, Discount__c 
                                            from Opportunity 
                                            ]); 
    } 
        
    global void execute(Database.BatchableContext BC, List<Opportunity> myList) { 
        // for (opportunity myOpportunity : myList){
        //     if (myOpportunity.Amount == 100) {
        //         myOpportunity.Discount__c = 0;             where id in:IdOpportunityMapBatch.keySet()]
        //     } 
        //     else if (myOpportunity.Amount == 50) {
        //         myOpportunity.Discount__c = 50;
        //     } 
        //     else if (myOpportunity.Amount == 0) {
        //         myOpportunity.Discount__c = 100;
        //     }
        // //update myList;
        // }
        // System.debug('BatchForOpportunity batch class'+myList);
    }
    global void finish(Database.BatchableContext BC) { 

    }
}