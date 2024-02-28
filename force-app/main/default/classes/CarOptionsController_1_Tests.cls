
@isTest
private class CarOptionsController_1_Tests {

    @testSetup
    static void setupTestData(){
        // Create test data, including Car_Configuration__c and Car_Options__c records.
        
        Car_Configuration__c carConfig = new Car_Configuration__c();
        // Assume other required fields are set here if needed.
        insert carConfig;
        
        Car_Options__c carOptions = new Car_Options__c(
            Car_Configuration__c = carConfig.Id,
            Range__c = 'Long Range',
            Exterior_Color__c = 'Midnight Silver Metallic',
            Interior_Color__c = 'Black'
        );
        insert carOptions;
        
        // Bypass the trigger handlers during the test since we are only testing the CarOptionsController
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }
    
    @isTest
    static void testGetCarOptionsWithValidId(){
        // Retrieve the test data
        Car_Configuration__c testCarConfig = [SELECT Id FROM Car_Configuration__c LIMIT 1];
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getCarOptions(testCarConfig.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals('Long Range', result.Range__c, 'The range should match the test data.');
    }
    
    @isTest
    static void testGetCarOptionsWithNoMatchingRecord(){
        // Generate a random Id that doesn't exist in the Car_Options__c records.
        Id dummyId = Schema.SObjectType.Car_Configuration__c.getKeyPrefix() + 'ABCDEFG';
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getCarOptions(dummyId);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'The result should be null when no record is found.');
    }
}
