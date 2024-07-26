public class DMLinsertacc {
    public static void myMethod(){
        
        //insert an account and associated contacts and opportunities//
        
        Account a = new Account(Name = 'Disney', NumberOfEmployees = 2000);
    	insert a;
        
        //Associated contactsLeadManager//
        
        Contact c = new Contact(firstName = 'John', lastname = 'Waker', accountId = a.Id);
        Contact c1 = new Contact(firstname = 'Mark', lastname = 'Waker', accountId = a.Id);
        
        List<Contact> conList= new List<Contact>();
        conList.add(c);
        conList.add(c1);
        
        insert conList;
        
        //Associated opportunities//
        
        Date d = Date.today() + 50;
        
        Opportunity o = new Opportunity(Name = 'Sell tyers', Stagename = 'Prospecting', CloseDate = d, Reason__c = 'any reason', accountId = a.Id);
        Opportunity o1 = new Opportunity(Name = 'Sell Papers', Stagename = 'Prospecting', CloseDate = d,Reason__c = 'any reason', accountId = a.Id);
        
        List<Opportunity> oppList= new List<Opportunity>();
        oppList.add(o);
        oppList.add(o1);
        
        insert oppList;
        
           
    }
}