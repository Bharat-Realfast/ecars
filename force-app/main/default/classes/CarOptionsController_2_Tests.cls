
@isTest
private class CarOptionsController_2_Tests {
    
    @testSetup
    static void setup() {
        // Bypass triggers for Vehicle_Order__c
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Create test data for Car_Configuration__c without setting the 'Name' field
        Car_Configuration__c carConfig = new Car_Configuration__c();
        // If there are other required fields for Car_Configuration__c, set them here as needed
        insert carConfig;
        
        // Create test data for Car_Options__c
        Car_Options__c carOptions = new Car_Options__c(
            Range__c = 'Long',
            Exterior_Color__c = 'Red',
            Interior_Color__c = 'Black',
            Car_Configuration__c = carConfig.Id
        );
        insert carOptions;
        
        // Create test data for Vehicle_Order__c with the previously inserted Car_Configuration__c Id
        Vehicle_Order__c vehicleOrder = new Vehicle_Order__c(Configuration__c = carConfig.Id);
        insert vehicleOrder;
    }
    
    @isTest
    static void testGetOrderCarOptions_HappyPath() {
        // Retrieve the test data
        Vehicle_Order__c testOrder = [SELECT Id, Configuration__c FROM Vehicle_Order__c LIMIT 1];
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getOrderCarOptions(testOrder.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'The Car_Options__c record should not be null');
        // Assuming 'Range__c' is a text field or has a text representation
        System.assertEquals('Long', result.Range__c, 'The Range should be Long');
    }
    
    @isTest
    static void testGetOrderCarOptions_SadPath() {
        // Create another Vehicle_Order__c with no related Car_Configuration__c
        Vehicle_Order__c vehicleOrder = new Vehicle_Order__c();
        insert vehicleOrder;
        
        Test.startTest();
        Car_Options__c result = CarOptionsController.getOrderCarOptions(vehicleOrder.Id);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'The Car_Options__c record should be null');
    }
    
    @isTest
    static void testGetOrderCarOptions_ExceptionalScenario() {
        // Use a syntactically valid but non-existent Id for Vehicle_Order__c
        Id invalidOrderId = 'a' + String.valueOf(Math.abs(Crypto.getRandomInteger())).leftPad(14).substring(0,14) + 'AAA';
        
        Exception actualException;
        try {
            Test.startTest();
            Car_Options__c result = CarOptionsController.getOrderCarOptions(invalidOrderId);
            Test.stopTest();
        } catch (QueryException e) {
            actualException = e;
        }
        
        // Assert that a QueryException has been thrown
        System.assertNotEquals(null, actualException, 'A QueryException should have been thrown');
    }
}
