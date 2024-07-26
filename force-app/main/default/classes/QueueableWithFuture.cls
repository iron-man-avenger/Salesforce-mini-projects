public class QueueableWithFuture implements Queueable {
    public void execute(QueueableContext context) {

        for (integer i=1; i<51; i++) {
            FutureMethod.someFutureMethod();
        }
        System.debug('Queueable is running.....');

        Contact insertcontact = new contact(firstname = 'Pratham', lastname = 'Dhamecha', phone = '9988276364');
        insert insertcontact;
        System.debug(insertcontact);
    }
}