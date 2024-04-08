
@isTest
private class TriggerHandler_10_Tests {

    // Setting up common test data
    @testSetup
    static void setup() {
        // Since the addToLoopCount method operates on static variables,
        // there is no need for data setup for this particular test.
    }

    // Test method for the happy path scenario
    @isTest
    static void testIncrementLoopCountWithinMax() {
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(3); // Setting a max loop count of 3
        String handlerName = handler.getHandlerName();

        Test.startTest();
        handler.run(); // First run should increment the count to 1
        handler.run(); // Second run should increment the count to 2
        Integer countAfterRuns = TriggerHandler.loopCountMap.get(handlerName).getCount();
        Test.stopTest();

        // Assertions
        System.assertEquals(2, countAfterRuns, 'Loop count should be 2 after two runs.');
        System.assert(!TriggerHandler.loopCountMap.get(handlerName).exceeded(), 
                       'Loop count should not be marked as exceeded.');
    }

    // Test method for the edge case scenario
    @isTest
    static void testIncrementLoopCountAtMax() {
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(1); // Setting a max loop count to 1
        String handlerName = handler.getHandlerName();

        Test.startTest();
        handler.run(); // First run, count should reach max but not exceed
        Integer countAfterRun = TriggerHandler.loopCountMap.get(handlerName).getCount();
        Test.stopTest();

        // Assertions
        System.assertEquals(1, countAfterRun, 'Loop count should be 1 after one run.');
        System.assert(!TriggerHandler.loopCountMap.get(handlerName).exceeded(), 
                       'Loop count should not be marked as exceeded.');
    }

    // Test method for the sad path scenario
    @isTest
    static void testIncrementLoopCountExceedsMax() {
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(1); // Setting a max loop count of 1

        Test.startTest();
        handler.run(); // First run should increment count to 1, at max
        Boolean exceptionThrown = false;
        try {
            handler.run(); // Second run should throw an exception
        } catch (TriggerHandler.TriggerHandlerException ex) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assertions
        System.assert(exceptionThrown, 'An exception should have been thrown for exceeding loop count.');
    }

    // Test method for the exceptional scenario
    @isTest
    static void testIncrementLoopCountWithNoHandlerEntry() {
        TriggerHandler handler = new TriggerHandler();
        // Deliberately not setting a loop count to create a scenario where the handler name isn't in loopCountMap

        Test.startTest();
        handler.run(); // Running without setting max loop count, should not throw an exception
        Boolean exceptionThrown = false;
        try {
            handler.run(); // Running again to confirm no increment or exception
        } catch (Exception ex) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assertions
        System.assert(!exceptionThrown, 'No exception should have been thrown as the handler name is not in loopCountMap.');
    }
}
