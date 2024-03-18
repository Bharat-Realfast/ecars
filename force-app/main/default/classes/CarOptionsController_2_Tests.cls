
@isTest
public class CarOptionsController_2_Tests {

    @testSetup
    static void setupTestData() {
        Test.startTest();
        // create a new car
        Car__c car = new Car__c();
        insert car;

        List<Vehicle_Order__c> testOrders = new List<Vehicle_Order__c>();
        List<Car_Configuration__c> testConfigs = new List<Car_Configuration__c>();
        for(Integer i = 0; i < 5; i++) {
            Car_Configuration__c config = new Car_Configuration__c(
                Car__c = car.Id
            );
            insert config;
            
            testOrders.add(new Vehicle_Order__c(
                Configuration__c = config.Id
            ));
        }
        insert testOrders;

        List<Car_Options__c> testOptions = new List<Car_Options__c>();
        for(Integer i = 0; i < 5; i++) {
            testOptions.add(new Car_Options__c(
                Car_Configuration__c = testOrders[i].Configuration__c,
                Range__c = 'Test Range ' + i,
                Exterior_Color__c = 'Test Exterior Color ' + i,
                Interior_Color__c = 'Test Interior Color ' + i
            ));
        }
        insert testOptions;
        Test.stopTest();
    }

    @isTest
    static void testGetOrderCarOptions() {
        Test.startTest();
        List<Vehicle_Order__c> testOrders = [SELECT Id, Configuration__c FROM Vehicle_Order__c];
        Car_Options__c retrievedOptions = CarOptionsController.getOrderCarOptions(testOrders[0].Id);
        Car_Options__c expectedOptions = [SELECT toLabel(Range__c), toLabel(Exterior_Color__c), toLabel(Interior_Color__c) FROM Car_Options__c WHERE Car_Configuration__c = :testOrders[0].Configuration__c LIMIT 1][0];
        Test.stopTest();
        
        System.assertEquals(expectedOptions, retrievedOptions, 'Retrieved options do not match the expected options');
    }

    @isTest
    static void testGetOrderCarOptionsWithInvalidId() {
        Test.startTest();
        Exception actualException;
        try {
            CarOptionsController.getOrderCarOptions('InvalidId');
        } catch(Exception e) {
            actualException = e;
        }
        Test.stopTest();
        
        System.assert(actualException != null, 'An exception is expected when an invalid id is used');
    }
}
