public with sharing class Weekday {
    public static Map<String, Object> OppCountWeekdayDate(String dateString) {
        Map<String, Object> result = new Map<String, Object>();
        Date inputDate = Date.valueOf(dateString); // Convert user input to Date format

// Find the start and end dates of the week (Monday to Sunday) that the input date falls in
        Date startOfWeek = inputDate.toStartOfWeek();
        Date endOfWeek = startOfWeek.addDays(6);
        

// Query for the opportunities created during that week
        List<Opportunity> opportunities = [SELECT Name, CreatedDate 
                                        FROM Opportunity 
                                        WHERE CreatedDate >= :startOfWeek 
                                        AND CreatedDate <= :endOfWeek];
        
// Create a map to store the counts of opportunities created on each weekday
        Map<String, Integer> weekdayCounts = new Map<String, Integer>{
            'Monday' => 0,
            'Tuesday' => 0,
            'Wednesday' => 0,
            'Thursday' => 0,
            'Friday' => 0,
            'Saturday' => 0,
            'Sunday' => 0
        };
// Iterate over the opportunities and increment the count for the corresponding weekday in the map
        for (Opportunity opportunity : opportunities) {
            String weekday = opportunity.CreatedDate.format('EEEE');
            weekdayCounts.put(weekday, weekdayCounts.get(weekday) + 1);
        }
        Map<String, String> weekdayOrder = new Map<String, String>{
            'Monday' => '1',
            'Tuesday' => '2',
            'Wednesday' => '3',
            'Thursday' => '4',
            'Friday' => '5',
            'Saturday' => '6',
            'Sunday' => '7'
        };
        
// Create a List to hold the day maps
        List<Map<String, Object>> result1 = new List<Map<String, Object>>();
        // Iterate over the weekdayCounts Map to create day maps
        for (String weekday : weekdayCounts.keySet()) {
            Integer count = weekdayCounts.get(weekday);
            String date1 = null;
            Integer daysToAdd = Integer.valueOf(weekdayOrder.get(weekday));
            DateTime newDateTime = DateTime.newInstance(startOfWeek.year(), startOfWeek.month(), startOfWeek.day() + daysToAdd);
            date1 = newDateTime.format('MM/dd/yyyy');
                
            Map<String, Object> dayMap = new Map<String, Object>{
                'Weekday' => weekday,
                'Count' => count,
                'Date' => date1
            };
            result1.add(dayMap); 
        }
        System.debug(result1);
        
        //Return the startdate  and enddate of the week
        result.put('startOfWeek', startOfWeek);
        result.put('endOfWeek', endOfWeek);
        return result;
    }
}