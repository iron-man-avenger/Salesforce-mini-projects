public class NewAccounts {
    public static void sObjectsInsert(){
        Account store = new Account();
        store.Name = 'The Tea Factory';
        store.AccountNumber = '356281';
        store.Phone = '998-7873';
        insert store;
    }
}