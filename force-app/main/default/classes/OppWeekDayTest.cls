@IsTest
private class OppWeekDayTest {
    @IsTest
    static void testGetWeekDates() {
        // Test input date
        String dateString = '2023-05-18';
        // Call the method
        Map<String, Object> result = OppWeekDay.getWeekDates(dateString);
        // Verify the results
        Date startOfWeek = (Date) result.get('startOfWeek');
        Date endOfWeek = (Date) result.get('endOfWeek');
        try {
            System.assertEquals(Date.valueOf('2023-05-15'), startOfWeek);
            System.assertEquals(Date.valueOf('2023-05-21'), endOfWeek);
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}