
@isTest
private class VehicleTriggerHandler_1_Tests {

    @testSetup
    static void makeTestData() {
        List<Vehicle__c> vehicles = new List<Vehicle__c>{
            new Vehicle__c(Model__c = 'Model X', Status__c = 'Available'),
            new Vehicle__c(Model__c = 'Model S', Status__c = 'Available')
        };
        insert vehicles;
    }
    
    @isTest
    static void testVehicleStatusChangedToSold() {
        // Prepare - Query for a test vehicle record and update its status to 'Sold'
        Vehicle__c testVehicle = [SELECT Id, Status__c FROM Vehicle__c WHERE Model__c = 'Model X' LIMIT 1];
        testVehicle.Status__c = 'Sold';
        
        Test.startTest();
        update testVehicle; // This should trigger the afterUpdate method in VehicleTriggerHandler
        Test.stopTest();

        // Verify - A Task has been created related to the vehicle
        List<Task> tasks = [SELECT Id, WhatId FROM Task WHERE WhatId = :testVehicle.Id];
        System.assertEquals(1, tasks.size(), 'A single task should be created for the sold vehicle.');
        System.assertEquals(testVehicle.Id, tasks[0].WhatId, 'The task should be related to the vehicle.');
    }
    
    @isTest
    static void testVehicleStatusNotChangedToSold() {
        // Prepare - Query for a test vehicle record & attempt to update its status to a value other than 'Sold'
        Vehicle__c testVehicle = [SELECT Id, Status__c FROM Vehicle__c WHERE Model__c = 'Model S' LIMIT 1];
        testVehicle.Status__c = 'Under Maintenance';
        
        Test.startTest();
        update testVehicle; // This should trigger the afterUpdate method in VehicleTriggerHandler
        Test.stopTest();

        // Verify - No Task has been created as the status is not 'Sold'
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :testVehicle.Id];
        System.assertEquals(0, tasks.size(), 'No tasks should be created for a vehicle not sold.');
    }
    
    // ... Other test methods as needed ...
}
