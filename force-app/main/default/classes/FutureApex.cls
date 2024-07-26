public class FutureApex {
    @future
    public static void insertUserWithRole(String uname, String alias1, String email1, String lastname1) {

        Profile profile1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole role = [SELECT Id FROM UserRole WHERE Name='COO'];
        // Create new user with a non-null user role ID 
        User user1 = new User(alias = alias1, email=email1, 
            emailencodingkey='UTF-8', lastname=lastname1, 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = profile1.Id, userroleid = role.Id,
            timezonesidkey='America/Los_Angeles', 
            username=uname);
        insert user1;
        System.debug(user1);
    }
}