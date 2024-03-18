
@isTest
public class VehicleTriggerHandler_1_Tests {
    @testSetup
    static void setupTestData() {
        // Create a Vehicle__c record with Status__c as 'Available'
        Vehicle__c vehicle = new Vehicle__c(Model__c = 'Model 1', Status__c = 'Available');
        insert vehicle;
    }

    @isTest
    static void testAfterUpdateVehicleStatusToSold() {
        // Prepare
        List<Vehicle__c> vehicles = [SELECT Model__c, Status__c FROM Vehicle__c LIMIT 1];
        vehicles[0].Status__c = 'Sold';
        
        // Execute
        Test.startTest();
        update vehicles;
        Test.stopTest();

        // Verify
        List<Task> tasks = [SELECT Subject, WhatId FROM Task WHERE WhatId = :vehicles[0].Id];
        System.assertEquals(1, tasks.size(), 'Expected one new task to be created');
        System.assertEquals(
            'The vehicle Model 1 is sold. Call your Sales Director',
            tasks[0].Subject,
            'The subject of the task is not as expected'
        );
    }

    @isTest
    static void testAfterUpdateVehicleStatusToAvailable() {
        // Prepare
        List<Vehicle__c> vehicles = [SELECT Model__c, Status__c FROM Vehicle__c LIMIT 1];
        vehicles[0].Status__c = 'Available';
        
        // Execute
        Test.startTest();
        update vehicles;
        Test.stopTest();

        // Verify
        List<Task> tasks = [SELECT Subject, WhatId FROM Task WHERE WhatId = :vehicles[0].Id];
        System.assertEquals(0, tasks.size(), 'Expected no task to be created');
    }
}
