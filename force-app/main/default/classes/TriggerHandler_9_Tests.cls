
@isTest
private class TriggerHandler_9_Tests {

    // Utility method to simulate setting the LoopCount for testing
    private static void simulateLoopCount(String handlerName, Integer max, Integer iterations) {
        TriggerHandler.bypass(handlerName); // Bypass trigger to avoid actual execution
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(max);
        
        // Simulate the number of iterations that would increment the loop count
        for (Integer i = 0; i < iterations; i++) {
            try {
                handler.run();
            } catch (TriggerHandler.TriggerHandlerException e) {
                // Catch the possible loop exception if max is reached
            }
        }
    }

    // Happy Path: Setting the maximum loop count for a new trigger handler
    @isTest
    static void shouldSetMaxLoopCountForNewHandler() {
        String handlerName = 'AccountTriggerHandler';
        simulateLoopCount(handlerName, 3, 0);
        
        // Assertions would need to be indirect as we cannot access private variables
        Boolean exceptionThrown = false;
        try {
            simulateLoopCount(handlerName, 3, 4); // This should throw an exception on the 4th run
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'An exception should be thrown when max loop count is exceeded.');
    }
    
    // Happy Path: Updating the maximum loop count for an existing trigger handler
    @isTest
    static void shouldUpdateMaxLoopCountForExistingHandler() {
        String handlerName = 'MDTAccountTriggerHandler';
        simulateLoopCount(handlerName, 2, 1); // Set and use up one iteration

        // Attempt to run the trigger again, which should not throw an exception because we update the max
        Exception exceptionThrown = null;
        try {
            simulateLoopCount(handlerName, 5, 1);
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = e;
        }
        System.assertEquals(null, exceptionThrown, 'No exception should be thrown since max loop count is increased.');
    }
    
    // Sad Path: Passing a null value for the maximum loop count
    @isTest
    static void shouldHandleNullMaxLoopCount() {
        String handlerName = 'AccountTriggerHandler';
        TriggerHandler.bypass(handlerName); // Bypassing trigger to avoid actual execution
        
        TriggerHandler handler = new TriggerHandler();
        
        Exception thrownException = null;
        try {
            handler.setMaxLoopCount(null);
        } catch (Exception e) {
            thrownException = e;
        }
        
        // Assertions
        System.assertNotEquals(null, thrownException, 'Passing null should throw an exception.');
    }
    
    // Exceptional Scenario: Handling a case where the max is less than the count
    @isTest
    static void shouldHandleMaxLessThanCount() {
        String handlerName = 'AccountTriggerHandler';
        simulateLoopCount(handlerName, 1, 1); // Set max to 1 and use up one iteration

        Boolean exceptionThrown = false;
        try {
            simulateLoopCount(handlerName, 1, 1); // This should throw an exception on the 2nd run
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'An exception should be thrown when max loop count is exceeded.');
    }
}
