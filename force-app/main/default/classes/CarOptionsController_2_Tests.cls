
@isTest
private class CarOptionsController_2_Tests {

    @testSetup
    static void makeTestData() {
        // Assuming Car__c is a required field in Car_Configuration__c or Car_Options__c
        Car__c testCar = new Car__c();
        // Set necessary fields on testCar
        insert testCar;

        Car_Configuration__c testConfig = new Car_Configuration__c(Car__c = testCar.Id);
        // Set other necessary fields on testConfig
        insert testConfig;

        Vehicle_Order__c testOrder = new Vehicle_Order__c(Configuration__c = testConfig.Id);
        // Set other necessary fields on testOrder
        insert testOrder;

        Car_Options__c testOptions = new Car_Options__c(Car_Configuration__c = testConfig.Id);
        // Set necessary fields on testOptions
        insert testOptions;

        // Bypass triggers during test data creation
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    @isTest
    static void testGetOrderCarOptionsHappyPath() {
        // Query for test data created in test setup
        Vehicle_Order__c testOrder = [SELECT Id, Configuration__c FROM Vehicle_Order__c LIMIT 1];
        Test.startTest();
        Car_Options__c result = CarOptionsController.getOrderCarOptions(testOrder.Id);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(testOrder.Configuration__c, result.Car_Configuration__c, 'The Car Configuration should match the test order.');
    }

    @isTest
    static void testGetOrderCarOptionsSadPath() {
        // Use an arbitrary non-existent Id
        Id fakeId = '000000000000000AAA';

        Test.startTest();
        Car_Options__c result;
        Exception caughtException;
        try {
            result = CarOptionsController.getOrderCarOptions(fakeId);
        } catch (QueryException e) {
            caughtException = e;
        }
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, caughtException, 'A QueryException should be thrown for a non-existent order.');
    }

    @isTest
    static void testGetOrderCarOptionsExceptionalScenario() {
        // Assuming Car__c is a required field in Car_Configuration__c
        Car__c anotherTestCar = new Car__c();
        // Set necessary fields on anotherTestCar
        insert anotherTestCar;

        Car_Configuration__c lonelyConfig = new Car_Configuration__c(Car__c = anotherTestCar.Id);
        // Set other necessary fields on lonelyConfig
        insert lonelyConfig;

        Vehicle_Order__c orderForLonelyConfig = new Vehicle_Order__c(Configuration__c = lonelyConfig.Id);
        // Set other necessary fields on orderForLonelyConfig
        insert orderForLonelyConfig;

        Test.startTest();
        Car_Options__c result = CarOptionsController.getOrderCarOptions(orderForLonelyConfig.Id);
        Test.stopTest();

        // Assertions
        System.assertEquals(null, result, 'The result should be null when no related Car Options are found.');
    }
}
