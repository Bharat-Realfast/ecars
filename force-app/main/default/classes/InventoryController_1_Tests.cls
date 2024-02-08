
@isTest
private class InventoryController_1_Tests {

    @testSetup
    static void setup() {
        // Prepare test data for Vehicle__c records
        List<Vehicle__c> vehiclesToInsert = new List<Vehicle__c>();
        for(Integer i = 0; i < 25; i++){
            vehiclesToInsert.add(new Vehicle__c(
                Exterior_Color__c = 'Color' + i,
                Interior_Color__c = 'Interior' + i,
                Model__c = 'Model' + i,
                Status__c = 'Available',
                Year__c = String.valueOf(2020 + i), // Corrected the assignment here
                Package__c = 'Package' + i,
                VIN__c = 'VIN' + i
            ));
        }
        insert vehiclesToInsert;
    }

    @isTest
    static void testGetVehiclesWithResult() {
        // Test to verify vehicles are returned by getVehicles when available

        Test.startTest();
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();
        
        // Asserts
        System.assertNotEquals(null, vehicles, 'The returned object should not be null.');
        System.assert(vehicles.size() <= 20, 'The returned list should not contain more than 20 records.');
    }

    @isTest
    static void testGetVehiclesWithoutResult() {
        // Test to verify no vehicles are returned by getVehicles when none are available

        // Deleting all vehicles to simulate no vehicles scenario
        delete [SELECT Id FROM Vehicle__c];

        Test.startTest();
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();
        
        // Asserts
        System.assertEquals(0, vehicles.size(), 'The returned list should be empty when no vehicles are present.');
    }

    // Exception scenario test methods would be implemented here if we could simulate security exceptions
}
