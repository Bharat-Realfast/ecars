
@isTest
public class CarOptionsController_1_Tests {
    // Method to create common test data
    @testSetup
    static void setupTestData() {
        // Create a Car__c record
        Car__c car = new Car__c(Name = 'Test Car');
        insert car;

        // Create a Car_Configuration__c record associated with the Car__c record
        Car_Configuration__c carConfiguration = new Car_Configuration__c(Car__c = car.Id);
        insert carConfiguration;

        // Create a Car_Options__c record associated with the Car_Configuration__c record
        Car_Options__c carOptions = new Car_Options__c(
            Car_Configuration__c = carConfiguration.Id,
            Range__c = 'Short',
            Exterior_Color__c = 'White', // Updated color value
            Interior_Color__c = 'Red'
        );
        insert carOptions;
    }

    // Test to verify that the getCarOptions method returns the correct Car_Options__c record
    @isTest
    static void testGetCarOptions_HappyPath() {
        // Use test data
        Car_Configuration__c carConfiguration = [SELECT Id FROM Car_Configuration__c LIMIT 1];
        // Call the method
        Car_Options__c carOptions = CarOptionsController.getCarOptions(carConfiguration.Id);
        // Verify the result
        System.assertNotEquals(null, carOptions, 'Car Options should not be null');
        System.assertEquals('Short', carOptions.Range__c, 'Incorrect Range');
    }

    // Test to verify that the getCarOptions method returns null when an invalid Id is passed
    @isTest
    static void testGetCarOptions_InvalidId() {
        // Call the method with an invalid Id
        Car_Options__c carOptions = CarOptionsController.getCarOptions('INVALID_ID');
        // Verify the result
        System.assertEquals(null, carOptions, 'Car Options should be null');
    }

    // Test to verify that the getCarOptions method throws an exception when null is passed
    @isTest
    static void testGetCarOptions_NullId() {
        // Define the exception
        Exception expectedException;
        // Call the method with null
        try {
            Car_Options__c carOptions = CarOptionsController.getCarOptions(null);
        } catch (Exception e) {
            expectedException = e;
        }
        // Verify that an exception was thrown
        System.assertNotEquals(null, expectedException, 'Exception was not thrown');
    }
}
