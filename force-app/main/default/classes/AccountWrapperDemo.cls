public class AccountWrapperDemo {
    public Account acc {get; set;}
    public Contact cont {get; set;}
    public Boolean isSelected {get; set;}
    
    public AccountWrapperDemo(Account acc) {
        this.acc = acc;
        this.isSelected = false;
    }
    
    public void printAccount() {
        System.debug('Account Name: ' + this.acc.Name + ', Is Selected: ' + this.isSelected);
    }
}