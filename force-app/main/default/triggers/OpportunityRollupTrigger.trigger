trigger OpportunityRollupTrigger on Opportunity (after insert, after update, after delete, after undelete) {
Set<Id> accountIds = new Set<Id>();

if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
    for (Opportunity opportunity : Trigger.new) {
        accountIds.add(opportunity.AccountId);
    }
}

if (Trigger.isUpdate || Trigger.isDelete) {
    for (Opportunity opportunity : Trigger.old) {
        accountIds.add(opportunity.AccountId);
    }
}
List<Account> accountsToUpdate = [
    SELECT Id,  (SELECT Amount FROM Opportunities)
    FROM Account
    WHERE Id IN :accountIds
];



for (Account account : accountsToUpdate) {
    Decimal totalAmount = 0;
    for (Opportunity opportunity : account.Opportunities) {
        totalAmount += opportunity.Amount;
    }
    account.Total_Amount_Of_Opportunities__c = totalAmount;
}

update accountsToUpdate;
System.debug(accountsToUpdate);
}