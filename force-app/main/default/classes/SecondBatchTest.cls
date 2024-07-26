@isTest
private class SecondBatchTest {
    static void testSecondBatch() {
        List<Opportunity> opportunities = new List<Opportunity>();
        Opportunity opportunity1 = new Opportunity(Name='Test Opp 1', StageName='Prospecting', CloseDate=Date.today(), Amount=100);
        opportunities.add(opportunity1);
        Opportunity opportunity2 = new Opportunity(Name='Test Opp 2', StageName='Qualification', CloseDate=Date.today(), Amount=50);
        opportunities.add(opportunity2);
        Opportunity opportunity3 = new Opportunity(Name='Test Opp 3', StageName='Closed Won', CloseDate=Date.today(), Amount=0);
        opportunities.add(opportunity3);
        try {
        if (opportunities.size()>0) {
                insert opportunities;
            }

            Test.startTest();
            SecondBatch batch = new SecondBatch();
            Database.executeBatch(batch);
            Test.stopTest();

            opportunity1 = [SELECT Id, Name, Amount, Discount__c, StageName, CloseDate FROM Opportunity WHERE Id = :opportunity1.Id];
            System.assertEquals(0, opportunity1.Discount__c);
            System.assertEquals('Prospecting', opportunity1.StageName);
            System.assertEquals(Date.today(), opportunity1.CloseDate);

            opportunity2 = [SELECT Id, Name, Amount, Discount__c, StageName, CloseDate FROM Opportunity WHERE Id = :opportunity2.Id];
            System.assertEquals(50, opportunity2.Discount__c);
            System.assertEquals('Qualification', opportunity2.StageName);
            System.assertEquals(Date.today(), opportunity2.CloseDate);

            opportunity3 = [SELECT Id, Name, Amount, Discount__c, StageName, CloseDate FROM Opportunity WHERE Id = :opportunity3.Id];
            System.assertEquals(100, opportunity3.Discount__c);
            System.assertEquals('Closed Won', opportunity3.StageName);
            System.assertEquals(Date.today(), opportunity3.CloseDate);
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}