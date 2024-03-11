
@isTest
private class CarOptionsController_1_Tests {
    
    @testSetup
    static void setupTestData() {
        // Creating a Car Configuration for testing
        Car_Configuration__c config = new Car_Configuration__c();
        // If Name is a required field and is writeable, set it here. Otherwise, omit or set a different field.
        // config.Name = 'Test Config';
        insert config;
        
        // Creating a Car Options record related to the configuration
        Car_Options__c carOption = new Car_Options__c(
            Car_Configuration__c = config.Id,
            Range__c = 'Long',
            Exterior_Color__c = 'Red',
            Interior_Color__c = 'Black'
        );
        insert carOption;
        
        // Bypassing related triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }
    
    @isTest
    static void testGetCarOptionsHappyPath() {
        // Retrieve the inserted Car Configuration record for the Id
        Car_Configuration__c config = [SELECT Id FROM Car_Configuration__c LIMIT 1];
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getCarOptions(config.Id);
        Test.stopTest();
        
        // Asserting that the result is not null and correct record is returned
        System.assertNotEquals(null, result, 'Car Options should not be null');
        // Assuming Range__c is a picklist, using toLabel in the query would return the label, not the API name.
        System.assertEquals('Long Range', result.Range__c, 'Range label should be Long Range');
    }
    
    @isTest
    static void testGetCarOptionsSadPath() {
        // Creating a Car Configuration that doesn't have related Car Options
        Car_Configuration__c config = new Car_Configuration__c();
        // If the Name field is required and writeable, set it here. Otherwise, omit or set a different field.
        // config.Name = 'Empty Config';
        insert config;
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getCarOptions(config.Id);
        Test.stopTest();
        
        // Asserting that the result is null since no related Car Options exist
        System.assertEquals(null, result, 'Car Options should be null for a configuration without related options');
    }
    
    @isTest
    static void testGetCarOptionsInvalidId() {
        // Passing a null Id to the method which should be handled by the method
        Test.startTest();
        Exception caughtException = null;
        try {
            Car_Options__c result = CarOptionsController.getCarOptions(null);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();
        
        // Assert that an exception was thrown
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for a null Id');
    }
}
