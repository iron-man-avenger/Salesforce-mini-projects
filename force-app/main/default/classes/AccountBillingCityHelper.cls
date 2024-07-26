public with sharing class AccountBillingCityHelper {
    public static void handleAfterUpdate(List<Account> newAccounts, 
                                        Map<Id, sObject> newMap, 
                                        Map<Id, sObject> oldMap) {
        try {
            Set<Id> accountIds = new Set<Id>();
            for (Account myAccount : newAccounts) {
                Account oldAccount = (Account)oldMap.get(myAccount.Id);
                // Check if BillingCity field has been updated
                if (myAccount.BillingCity != oldAccount.BillingCity) {
                    accountIds.add(myAccount.Id);
                }
            }
            if (!accountIds.isEmpty()) {
                List<Contact> contactsToUpdate = [SELECT Id, MailingCity, AccountId FROM Contact WHERE AccountId IN :accountIds];
                // Update MailingCity with the new BillingCity value
                for (Contact myContact : contactsToUpdate) {
                    Account relatedAccount = (Account)newMap.get(myContact.AccountId);
                    myContact.MailingCity = relatedAccount.BillingCity;
                }
                // Perform bulk update on contacts
                if (!contactsToUpdate.isEmpty()) {
                    update contactsToUpdate;
                }
                System.debug(contactsToUpdate);
            }
        } catch (Exception error) {
            // Debug output for any exceptions that occur
            System.debug('The following exception has occurred: ' + error.getMessage());
        }
    }
}