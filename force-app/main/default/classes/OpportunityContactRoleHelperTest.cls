@isTest
public class OpportunityContactRoleHelperTest {
    @isTest
    static void testHandleBeforeInsert() {
        // Create test data
        Opportunity opportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = '0012w00001FYwxdAAD'
        );
        insert opportunity;
        Contact contact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'johndoe@example.com'
        );
        insert contact;
        OpportunityContactRole contactRole = new OpportunityContactRole(
            OpportunityId = opportunity.Id,
            ContactId = contact.Id,
            Role = ''
        );
        List<OpportunityContactRole> newRoles = new List<OpportunityContactRole>();
        newRoles.add(contactRole);
        // Call the trigger handler method
        Test.startTest();
        OpportunityContactRoleHelper.assignContactRole(newRoles);
        Test.stopTest();
        // Verify the default role assignment
        System.assertEquals('Admin', contactRole.Role);
    }
}