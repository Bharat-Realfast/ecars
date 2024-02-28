
@isTest
private class TriggerHandler_8_Tests {
    
    // Helper method to simulate setting the trigger context for tests
    private static void simulateTriggerContext(TriggerHandler handler, String context) {
        handler.setTriggerContext(context, true); // Set test mode to true
    }
    
    @isTest
    static void testIncrementLoopCountWithinMax() {
        TriggerHandler handler = new TriggerHandler();
        simulateTriggerContext(handler, 'before insert'); // Simulate trigger context
        handler.setMaxLoopCount(5);

        // Expect no exception to be thrown, so set a flag to catch unexpected exceptions
        Boolean exceptionThrown = false;
        
        try {
            Test.startTest();
            // Disable triggers
            TriggerHandler.bypass('AccountTriggerHandler');
            TriggerHandler.bypass('MDTAccountTriggerHandler');
            handler.run(); // Should increment loop count without exceeding max
            Test.stopTest();
        } catch (Exception e) {
            exceptionThrown = true;
        }
        
        // Assert that no exception was thrown
        System.assert(!exceptionThrown, 'No exception should be thrown for loop count within max.');
    }
    
    @isTest
    static void testIncrementLoopCountExceedMax() {
        String expectedMessage = 'Maximum loop count of 1 reached in TriggerHandler';
        TriggerHandler handler = new TriggerHandler();
        simulateTriggerContext(handler, 'before insert'); // Simulate trigger context
        handler.setMaxLoopCount(1);

        // Increment to 1, within limit
        handler.run();

        Boolean exceptionThrown = false;
        String actualMessage = '';
        
        try {
            Test.startTest();
            // Disable triggers
            TriggerHandler.bypass('AccountTriggerHandler');
            TriggerHandler.bypass('MDTAccountTriggerHandler');
            handler.run(); // Attempt to increment beyond limit
            Test.stopTest();
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = true;
            actualMessage = e.getMessage();
        }
        
        // Assert that the correct exception was thrown
        System.assert(exceptionThrown, 'An exception should have been thrown because the loop count exceeded max.');
        System.assertEquals(expectedMessage, actualMessage, 'The exception message should match expected when loop count exceeded max.');
    }

    // Additional test methods would be defined here, following the same pattern.
}
