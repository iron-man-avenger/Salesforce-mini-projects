public with sharing class ContacTriggertHelper {
    public static void handleBeforeInsertUpdate(List<Contact> contactsList) {
        try {
            // Create a set to store unique Account Ids
            Set<Id> accountIds = new Set<Id>();
            // Create a map to store Account records with their Ids as keys
            Map<Id, Account> accountsMap = new Map<Id, Account>();
            // Create a set to store unique contact vehicle types
            Set<String> contactVehicleTypesSet = new Set<String>();
            // Iterate over the list of Contact records
            for (Contact contact : contactsList) {
                // Add the AccountId of each Contact to the set
                accountIds.add(contact.AccountId);
                // Collect unique contact vehicle types
                if (contact.Vehicle_Types__c != null) {
                    contactVehicleTypesSet.addAll(contact.Vehicle_Types__c.split(';'));
                }
            }
            // Retrieve Account records from the database using the Account Ids
            accountsMap = new Map<Id, Account>([SELECT Id, Vehicle_Types__c
                                                FROM Account
                                                WHERE Id IN :accountIds WITH SECURITY_ENFORCED]);
            System.debug('account map'+accountsMap);
            // Query Vehicle records based on unique contact vehicle types
            List<Vehicle__c> vehiclesList = [SELECT Name, URL__c
                                            FROM Vehicle__c
                                            WHERE Name IN :contactVehicleTypesSet WITH SECURITY_ENFORCED];
            // Create a map to store the URL__c field of each vehicle based on the vehicle type
            Map<String, String> vehicleUrlMap = new Map<String, String>();
            for (Vehicle__c vehicle : vehiclesList) {
                vehicleUrlMap.put(vehicle.Name, vehicle.URL__c);
            }
            // Iterate over the Contact records
            for (Contact contact : contactsList) {
                // Get the associated Account record from the accountsMap
                Account account = accountsMap.get(contact.AccountId);
                // Check if the Account exists
                if (account != null) {
                    // Split the Vehicle_Types__c field of the Account into an array of vehicle types
                    String[] accountVehicleTypes = account.Vehicle_Types__c.split(';');
                    // Check if the Contact's Vehicle_Types__c field is not null
                    if (contact.Vehicle_Types__c != null) {
                        // Split the Vehicle_Types__c field of the Contact into an array of vehicle types
                        String[] contactVehicleTypes = contact.Vehicle_Types__c.split(';');
                        // Create a boolean variable to track if any vehicle types match
                        Boolean matchingTypes = false;
                        // Create a set of Account vehicle types
                        Set<String> accountVehicleTypesSet = new Set<String>(accountVehicleTypes);
                        // Check if any contact vehicle type matches the account vehicle types
                        accountVehicleTypesSet.retainAll(new Set<String>(contactVehicleTypes));
                        // Update the matchingTypes variable based on whether any matches were found
                        matchingTypes = !accountVehicleTypesSet.isEmpty();
                        // Print the accountVehicleTypes for debugging purposes
                        System.debug(accountVehicleTypes);
                        // If no matching vehicle types were found, add an error to the Contact record
                        if (!matchingTypes) {
                            contact.addError('No matching vehicle types found on the associated account.');
                        }
                        // Retrieve a Vehicle__c record based on the first matching contact vehicle type
                        String firstVehicleType = contactVehicleTypes[0];
                        String vehicleUrl = vehicleUrlMap.get(firstVehicleType);
                        // Check if a valid vehicle record was found and it has a non-null URL__c field
                        if (vehicleUrl != null) {
                            // Update the Car_Image__c field of the Contact with the URL__c field of the Vehicle__c record
                            contact.Car_Image__c = vehicleUrl;
                        }
                        // Print the URL__c field of the vehicle and the Car_Image__c field of the Contact for debugging purposes
                        System.debug(vehicleUrl);
                        System.debug(contact.Car_Image__c);
                    } else {
                        contact.Car_Image__c = null;
                    }
                }
            }
        } catch (Exception error) {
            // Print the exception message for debugging purposes
            System.debug('The following exception has occurred: ' + error.getMessage());
            
        }
    }
}