public with sharing class FutureMethod {
    @future
    public static void someFutureMethod() {
        List<String> result = new List<String>();
        result.add('First');
        result.add('Second');
        System.debug('future method of Queueable is running.........' + result);
    }
    @future
    public static void SecondMethod() {
        List<String> result = new List<String>();
        result.add('Third');
        result.add('Fourth');
        System.debug('future method of Batch is running.........' + result);
    }
}