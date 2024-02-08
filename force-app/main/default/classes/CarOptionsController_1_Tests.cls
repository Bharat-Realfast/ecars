
@isTest
private class CarOptionsController_1_Tests {
    
    @testSetup
    static void setup() {
        // Setting up test data - Car_Configuration__c and Car_Options__c are created without setting the Name field

        Car_Configuration__c carConfig = new Car_Configuration__c();
        insert carConfig;
        
        Car_Options__c carOptions = new Car_Options__c(
            Car_Configuration__c = carConfig.Id,
            Range__c = 'Long Range',
            Exterior_Color__c = 'Midnight Silver Metallic',
            Interior_Color__c = 'Black'
        );
        insert carOptions;
    }
    
    @isTest
    static void testGetCarOptionsHappyPath() {
        // Query the existing test data
        Car_Configuration__c testCarConfig = [SELECT Id FROM Car_Configuration__c LIMIT 1];
        
        Test.startTest();
        
        // Call the method under test
        Car_Options__c options = CarOptionsController.getCarOptions(testCarConfig.Id);
        
        Test.stopTest();
        
        // Assert that the correct Car_Options__c record is returned
        System.assertNotEquals(null, options, 'Car_Options__c should not be null');
        System.assertEquals('Long Range', options.Range__c, 'Range should match the test data');
    }
    
    @isTest
    static void testGetCarOptionsSadPath() {
        // Create a Car_Configuration__c record that does not link to any Car_Options__c
        Car_Configuration__c carConfig = new Car_Configuration__c();
        insert carConfig;
        
        Test.startTest();
        
        // Call the method under test
        Car_Options__c options = CarOptionsController.getCarOptions(carConfig.Id);
        
        Test.stopTest();
        
        // Assert that no Car_Options__c record is returned
        System.assertEquals(null, options, 'Car_Options__c should be null');
    }
    
    @isTest
    static void testGetCarOptionsExceptionalScenario() {
        // Pass an invalid ID to the method
        Id recordId = 'a03500000000000'; // This is an arbitrarily invalid ID format for testing
        
        Test.startTest();
        
        try {
            // Call the method with an invalid ID to catch the exception
            Car_Options__c options = CarOptionsController.getCarOptions(recordId);
        } catch (Exception e) {
            // Verify that an exception is thrown
            String expectedMessage = 'System.QueryException';
            System.assert(e.getMessage().contains(expectedMessage), 'Expected a QueryException to be thrown');
        }
        
        Test.stopTest();
    }
}
