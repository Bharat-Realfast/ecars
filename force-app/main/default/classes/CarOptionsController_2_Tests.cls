
@isTest
private class CarOptionsController_2_Tests {

    // Setup data for tests
    @testSetup
    static void makeTestData() {
        // Since we're testing CarOptionsController, we do not need to bypass Account triggers
        // Create test data for Vehicle_Order__c and Car_Options__c
        Vehicle_Order__c testOrder = new Vehicle_Order__c(Configuration__c = 'dummyConfigId');
        insert testOrder;

        Car_Options__c testCarOptions = new Car_Options__c(
            Car_Configuration__c = testOrder.Id // Use the inserted testOrder's ID for relationship
        );
        insert testCarOptions;
    }
    
    // Test for happy path
    @isTest
    static void testGetOrderCarOptionsWithValidData() {
        // Query the test data
        Vehicle_Order__c testOrder = [SELECT Id, Configuration__c FROM Vehicle_Order__c LIMIT 1];
        Car_Options__c expectedOptions = [SELECT Id FROM Car_Options__c WHERE Car_Configuration__c = :testOrder.Id LIMIT 1];
        
        Test.startTest();
        Car_Options__c actualOptions = CarOptionsController.getOrderCarOptions(testOrder.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, actualOptions, 'The Car_Options__c record should not be null');
        System.assertEquals(expectedOptions.Id, actualOptions.Id, 'The IDs of the expected and actual Car_Options__c should match');
    }
    
    // Test for sad path where Vehicle_Order__c is not found
    @isTest
    static void testGetOrderCarOptionsWithInvalidOrderId() {
        Id invalidOrderId = '000000000000000AAA';

        try {
            Test.startTest();
            Car_Options__c actualOptions = CarOptionsController.getOrderCarOptions(invalidOrderId);
            Test.stopTest();
        } catch (QueryException qe) {
            // Assertions
            System.assert(qe.getMessage().contains('List has no rows'), 'A QueryException with an appropriate message should be thrown');
        }
    }
    
    // Test for exceptional scenario where no related Car_Options__c
    @isTest
    static void testGetOrderCarOptionsWithNoRelatedCarOptions() {
        // Create a Vehicle_Order__c with no related Car_Options__c
        Vehicle_Order__c testOrder = new Vehicle_Order__c(Configuration__c = 'orphanConfigId');
        insert testOrder;

        Car_Options__c actualOptions = null;

        Test.startTest();
        actualOptions = CarOptionsController.getOrderCarOptions(testOrder.Id);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, actualOptions, 'The Car_Options__c record should be null');
    }
}
