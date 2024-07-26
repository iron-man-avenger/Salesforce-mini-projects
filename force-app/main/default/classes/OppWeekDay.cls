public with sharing class OppWeekDay {
    public static Map<String, Object> getWeekDates(String dateString) {
            Map<String, Object> result = new Map<String, Object>();
            
            // Convert user input to Date format
            Date inputDate = Date.valueOf(dateString);
            
            // Find the date of the previous Monday
            Date startOfWeek = inputDate.toStartOfWeek().addDays(1);
            
            // Find the date of the following Sunday
            Date endOfWeek = startOfWeek.addDays(6);
            
            // Add results to map
            result.put('startOfWeek', startOfWeek);
            result.put('endOfWeek', endOfWeek);
            return result;


        }

    }