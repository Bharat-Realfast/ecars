
@isTest
public class InventoryController_1_Tests {
    @testSetup
    static void setupTestData() {
        List<Vehicle__c> vehiclesToInsert = new List<Vehicle__c>();
        for (Integer i = 0; i < 20; i++) {
            vehiclesToInsert.add(new Vehicle__c(
                Exterior_Color__c = 'Blue',
                Interior_Color__c = 'White',
                Model__c = 'Model ' + i,
                Status__c = 'Available',
                Year__c = '2020',
                Package__c = 'Package ' + i,
                VIN__C = 'VIN' + i
            ));
        }
        insert vehiclesToInsert;
    }

    @isTest
    static void testGetVehicles_HappyPath() {
        Test.startTest();
        Object result = InventoryController.getVehicles();
        Test.stopTest();
        
        System.assert(result != null, 'No vehicles were returned');
        List<Vehicle__c> vehicles = (List<Vehicle__c>)result;
        System.assertEquals(20, vehicles.size(), 'Not all Vehicles were returned');
    }

    @isTest
    static void testGetVehicles_NoVehicles() {
        delete [SELECT Id FROM Vehicle__c];
        
        Test.startTest();
        Object result = InventoryController.getVehicles();
        Test.stopTest();
        
        System.assert(result != null, 'No vehicles were returned');
        List<Vehicle__c> vehicles = (List<Vehicle__c>)result;
        System.assertEquals(0, vehicles.size(), 'Vehicles were returned when none should exist');
    }
}
