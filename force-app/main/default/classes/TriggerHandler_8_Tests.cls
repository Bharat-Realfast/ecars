
@isTest
private class TriggerHandler_8_Tests {

    // Use @testSetup to create test data
    @testSetup
    static void setup() {
        // Setup logic if necessary
        // For this test class, no specific setup is required as we are testing loop counters which are static in nature and do not require record creation
    }

    // Test method for the happy path where the loop count does not exceed the maximum
    @isTest
    static void testIncrementLoopCountWithinLimit() {
        TriggerHandler testHandler = new TriggerHandler();
        testHandler.setMaxLoopCount(2); // Set maximum loop count to 2

        Test.startTest();
        testHandler.run(); // First run should not throw an exception
        testHandler.run(); // Second run should not throw an exception
        Test.stopTest();

        // Assertions
        System.assert(TriggerHandler.loopCountMap.get(testHandler.getHandlerName()).getCount() == 2, 'Loop count should be 2');
        System.assert(TriggerHandler.loopCountMap.get(testHandler.getHandlerName()).getMax() == 2, 'Max loop count should be 2');
    }

    // Test method for the sad path where the loop count exceeds the maximum
    @isTest
    static void testIncrementLoopCountExceedsLimit() {
        TriggerHandler testHandler = new TriggerHandler();
        testHandler.setMaxLoopCount(1); // Set maximum loop count to 1
        
        Boolean exceptionThrown = false;
        try {
            Test.startTest();
            testHandler.run(); // First run should not throw an exception
            testHandler.run(); // Second run should throw an exception
            Test.stopTest();
        } catch (TriggerHandler.TriggerHandlerException ex) {
            exceptionThrown = true;
        }

        // Assertions
        System.assert(exceptionThrown, 'An exception should have been thrown because the loop count exceeded the maximum');
    }

    // Test method for the exceptional scenario where the maximum loop count is set to a negative number
    @isTest
    static void testNegativeMaxLoopCount() {
        TriggerHandler testHandler = new TriggerHandler();
        testHandler.setMaxLoopCount(-1); // Set maximum loop count to -1 which means no limit

        Test.startTest();
        testHandler.run(); // Run multiple times - should not throw an exception
        testHandler.run();
        testHandler.run();
        Test.stopTest();

        // Assertions
        System.assert(TriggerHandler.loopCountMap.get(testHandler.getHandlerName()).getCount() > 0, 'Loop count should be greater than 0');
        System.assert(TriggerHandler.loopCountMap.get(testHandler.getHandlerName()).getMax() == -1, 'Max loop count should be -1 indicating no limit');
    }
}
