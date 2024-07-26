public class insertAccount {
		public static void sObjectsInsert(Integer value){
        Integer N = 1;
        List<Account> addAccounts = new List<Account>();
        while(N <= value){
            System.debug('Counter Value before Incrementing ' + N);
            Account store = new Account();
            store.Name = 'Acme Inc ' + N;
            store.AccountNumber = 'A000n' + N;
            addAccounts.add(store);
            System.debug(addAccounts);
            N = N + 1;
            System.debug('Counter Value after incrementing ' + N);
        }
        System.debug('Size of Account List: ' + addAccounts.size() );
        System.debug('Elements in Account List: ' + addAccounts);
        insert addAccounts;
    }
}