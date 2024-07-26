public class DMLDBupdate {
    public static void DMLDBupdate(){
        List<Account> accountsToUpdate = new List<Account>();
		for (Account acc : [SELECT Id, Name, Type FROM Account WHERE Name = 'Default']) {
    	// Update the account's name
    	acc.Name = 'DefaultNorgwrgfg';
    	// Add the account to the list of records to be updated
    	accountsToUpdate.add(acc);
		}
		// Update the records using Database.update
		List<Database.SaveResult> updateResults = Database.update(accountsToUpdate, false);
		// Check the results of the update operation
		for (Database.SaveResult result : updateResults) {
    			if (result.isSuccess()) {
        			System.debug('Account updated successfully: ' + result.getId());
    			} else {
        			for (Database.Error error : result.getErrors()) {
            		System.debug('Error updating account ' + result.getId() + ': ' + error.getMessage());
        			}
    			}
			}
    }
}