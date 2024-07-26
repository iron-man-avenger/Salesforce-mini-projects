public with sharing class AccountRelatedContactCreation {
    public static void contactCreation() {
        Account accounts = new Account();
        accounts.Name='practice';
        insert accounts;
        ID acctID = accounts.ID;
        List<Contact> contact = new List<Contact>();
            for(Integer i = 0 ; i < 5 ; i++) {
                Contact c = new Contact(
                    LastName = 'Contact for Account ' + 5 ,
                    AccountId = acctID );
                    contact.add(c);
            }
        insert contact;
    }
}