public class MixedDMLFuture {
    public static void useFutureMethod() {
        // First DML operation
        Account a = new Account(Name='Acme23', AccountNumber='123333');
        insert a;
        
        // This next operation (insert a user with a role) 
        // can't be mixed with the previous insert unless 
        // it is within a future method. 
        // Call future method to insert a user with a role.
        FutureApex.insertUserWithRole('techdicer86@techdicer.com', 'tech321', 'techdicer346@techdicer.com', 'techdicer671');        
        // System.debug(a);
    }
}