public with sharing class ChangeAccountNameToOriginalName {
    public static void GetOriginalName() {
        List<Account> accListToUpdate = new List<Account>();
            for(Account acc : [SELECT Id, Name FROM Account]) {
                if(acc.Name.contains('Update by Batch job')) {
                    String newName = acc.Name.replace('Update by Batch job', '');
                    acc.Name = newName;
                    accListToUpdate.add(acc);
                }
                update accListToUpdate;
            }
            // List<Account> allAccounts = [SELECT Name FROM Account];
            // Set<String> accountNames = new Set<String>();
            // List<Account> accountsToDelete = new List<Account>();
            // for (Account a : allAccounts) {
            //     if (accountNames.contains(a.Name)) {
            //         accountsToDelete.add(a);
            //     }
            //     else {
            //         accountNames.add(a.Name);
            //     }
            // }
            // delete accountsToDelete;
    }
}