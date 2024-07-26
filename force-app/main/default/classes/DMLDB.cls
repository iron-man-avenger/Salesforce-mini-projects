public class DMLDB {
    public static void DMLDB(){
        List<Account> acctList = new List<Account>();
		acctList.add(new Account(name = 'test1',NumberOfEmployees=100));
		acctList.add(new Account(name = 'test2',NumberOfEmployees=140));
        acctList.add(new Account(name = 'test2',NumberOfEmployees=50));
        //by default is true in database.insert(accList)
Database.SaveResult[] srList = Database.insert(acctList, false);//false can insert test1 data // true throw error and none data inserted if one data is true
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
    }
    else {
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
        }
    }
	}
}
}