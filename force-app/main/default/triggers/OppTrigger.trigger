trigger OppTrigger on Opportunity (after update) {

        // List<Opportunity> opportunityList = [SELECT  Amount, Discount__c FROM Opportunity WHERE Id = '0062w00000MFeqzAAD'];
        // for (Opportunity myOpportunity : Trigger.new) {
        //         if (myOpportunity.Amount == 100) {
        //                 myOpportunity.Discount__c = 0;
        //         } else if (myOpportunity.Amount == 50) {
        //                 myOpportunity.Discount__c = 50;
        //         } else if (myOpportunity.Amount == 0) {
        //                 myOpportunity.Discount__c = 90;
                        
        //         }
                
        //         //update opportunityList;
        //         System.debug(opportunityList);
        // }
        
        //         Database.executeBatch(new SecondBatch(), 100);
        
    // if (trigger.IsBefore && trigger.IsInsert) {(, before insert, before update)
    //     System.debug('I am in before insert context');
    // }

    // if (trigger.IsUpdate) {
    //     if (trigger.IsBefore) {
    //         for (Opportunity opp : trigger.new) {
    //             System.debug('New Name :' + opp.Name);
    //             System.debug('Old Name :' + trigger.oldMap.get(opp.Id).Name);
    //             System.debug('New stage :' + opp.StageName);
    //             System.debug('Old stage :' + trigger.oldMap.get(opp.Id).StageName);
    //             if (trigger.new) {

    //             }
    //         }
    //     }
    // }


}