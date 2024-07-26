public with sharing class AccountRealtedOpportunityStageHelper {
    //Update the Highest_Opportunity_Stage_Value__c field in Account when its related opportunity is updated.
    public static void changeStageinAccount(List<Opportunity> opportunityList) {
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity opportunityRecords : opportunityList){
            accountIdSet.add(opportunityRecords.AccountId);
        }
        Map<Id, Decimal> mapforAccountUpdate = new Map<Id, Decimal>();
        List<AggregateResult> opportunityWithHighestProbability = [SELECT AccountId, MAX(Probability) HighestProbability
                                                                    FROM Opportunity
                                                                    WHERE AccountId IN :accountIdSet
                                                                    GROUP BY AccountId];
        if(opportunityWithHighestProbability.size() > 0){
            for(AggregateResult aggregateResultsForOpportunity : opportunityWithHighestProbability){
                mapforAccountUpdate.put((Id)aggregateResultsForOpportunity.get('AccountId'),(Decimal)aggregateResultsForOpportunity.get('HighestProbability'));
            }
        }
        List<Account> updatedAccountList = new List<Account>();
        for (Id singleAccountId : mapforAccountUpdate.keySet())
            {
                Account singleAccount = new Account();
                singleAccount.Id = singleAccountId;
                if(mapforAccountUpdate.containsKey(singleAccount.Id)){
                    if(mapforAccountUpdate.get(singleAccount.Id) == 100){
                        singleAccount.Highest_Opportunity_Stage_Value__c = '5';
                    }
                     if(mapforAccountUpdate.get(singleAccount.Id) == 90){
                        singleAccount.Highest_Opportunity_Stage_Value__c = '4';
                    }
                     if(mapforAccountUpdate.get(singleAccount.Id) == 75){
                        singleAccount.Highest_Opportunity_Stage_Value__c = '3';
                    }
                     if(mapforAccountUpdate.get(singleAccount.Id) == 70){
                        singleAccount.Highest_Opportunity_Stage_Value__c = '2';
                    }
                     if(mapforAccountUpdate.get(singleAccount.Id) == 60){
                        singleAccount.Highest_Opportunity_Stage_Value__c = '1';
                    }
                    {
                        singleAccount.Highest_Opportunity_Stage_Value__c = '';
                    }
                updatedAccountList.add(singleAccount);
            }
            if(updatedAccountList.size() > 0){
                update updatedAccountList;
            }
        }
    }

    
}