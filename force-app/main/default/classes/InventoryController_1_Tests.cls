
@isTest
private class InventoryController_1_Tests {
    
    @testSetup
    static void makeTestData() {
        // Prepare a list of Vehicle__c records to insert
        List<Vehicle__c> vehicleList = new List<Vehicle__c>();
        for (Integer i = 0; i < 25; i++) { // Create more than 20 to test the limit
            Vehicle__c vehicle = new Vehicle__c(
                Exterior_Color__c = 'Color' + i,
                Interior_Color__c = 'Color' + i,
                Model__c = 'Model' + i,
                Status__c = 'Available',
                Year__c = '202' + (i % 10), // Correct string concatenation
                Package__c = 'Package' + i,
                VIN__C = 'VIN' + i
            );
            vehicleList.add(vehicle);
        }
        insert vehicleList;
    }

    @isTest
    static void testGetVehiclesWithRecords() {
        Test.startTest();
        // Bypass the triggers as a best practice even if they are not directly related to the test
        // Since there is no specific VehicleTriggerHandler mentioned, this line is commented out.
        // TriggerHandler.bypass('VehicleTriggerHandler');
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, vehicles, 'The vehicle list should not be null');
        System.assertEquals(20, vehicles.size(), 'The vehicle list should return a maximum of 20 records');
    }

    @isTest
    static void testGetVehiclesWithoutRecords() {
        // Clear all test data
        delete [SELECT Id FROM Vehicle__c];
        
        Test.startTest();
        // Bypass the triggers as a best practice even if they are not directly related to the test
        // Since there is no specific VehicleTriggerHandler mentioned, this line is commented out.
        // TriggerHandler.bypass('VehicleTriggerHandler');
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, vehicles, 'The vehicle list should not be null');
        System.assertEquals(0, vehicles.size(), 'The vehicle list should be empty');
    }
}
