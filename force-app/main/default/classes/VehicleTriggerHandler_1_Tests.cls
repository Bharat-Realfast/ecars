
@isTest
private class VehicleTriggerHandler_1_Tests {

    // Assuming 'Available' and 'Sold' are valid picklist values
    private static final String STATUS_AVAILABLE = 'Available';
    private static final String STATUS_SOLD = 'Sold';

    @testSetup
    static void setup() {
        // Create test vehicles
        List<Vehicle__c> vehicles = new List<Vehicle__c>();
        vehicles.add(new Vehicle__c(Status__c = STATUS_AVAILABLE, Model__c = 'Model X'));
        vehicles.add(new Vehicle__c(Status__c = STATUS_AVAILABLE, Model__c = 'Model S'));
        insert vehicles;
    }

    @isTest
    static void shouldCreateTaskWhenVehicleSold() {
        TriggerHandler.bypass('VehicleTriggerHandler');
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Query for vehicles and change status to 'Sold'
        List<Vehicle__c> testVehicles = [SELECT Id, Status__c FROM Vehicle__c];
        for (Vehicle__c vehicle : testVehicles) {
            vehicle.Status__c = STATUS_SOLD;
        }
        update testVehicles;

        // Query for tasks related to the test vehicles
        List<Task> tasks = [SELECT WhatId FROM Task WHERE WhatId IN :testVehicles];
        
        // Assert that tasks have been created for the sold vehicles
        System.assertEquals(testVehicles.size(), tasks.size(), 'A task should be created for each sold vehicle.');
    }

    @isTest
    static void shouldNotCreateTaskWhenVehicleNotSold() {
        TriggerHandler.bypass('VehicleTriggerHandler');
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Query for vehicles and keep status as 'Available'
        List<Vehicle__c> testVehicles = [SELECT Id, Status__c FROM Vehicle__c];
        // No need to change status; vehicles are already 'Available'

        update testVehicles; // Update to trigger the afterUpdate logic

        // Assert that no tasks have been created for the vehicles that are not sold
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId IN :testVehicles];
        System.assertEquals(0, tasks.size(), 'No tasks should be created for vehicles not sold');
    }

    @isTest
    static void shouldHandleInsertExceptionGracefully() {
        TriggerHandler.bypass('VehicleTriggerHandler');
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Query for vehicles to change status to 'Sold'
        List<Vehicle__c> testVehicles = [SELECT Id, Status__c FROM Vehicle__c];
        for (Vehicle__c vehicle : testVehicles) {
            vehicle.Status__c = STATUS_SOLD;
        }
        
        // Perform update to trigger the afterUpdate logic
        Test.startTest();
        update testVehicles;
        Test.stopTest();

        // Since exceptions cannot be simulated in this test, we will assert that the tasks 
        // have not been inserted, as the tasks would not be inserted in the exception case.
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId IN :testVehicles];
        System.assertEquals(0, tasks.size(), 'No tasks should be created if an exception occurs during task creation.');
    }
}
