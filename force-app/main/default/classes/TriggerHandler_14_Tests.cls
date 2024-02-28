
@isTest
private class TriggerHandler_14_Tests {

    // Bypass the triggers for the test execution context
    private static void bypassTriggersForTest() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Test to ensure setMaxLoopCount sets the loop count appropriately
    @isTest
    static void testSetMaxLoopCount() {
        bypassTriggersForTest();
        TriggerHandler handler = new MockTriggerHandler();

        // Set max loop count to 1 for the first time and simulate trigger execution
        handler.setMaxLoopCount(1);
        
        // Simulate running the handler once, which should succeed without exception
        handler.run();
        
        // Attempt to run a second time to exceed the loop count and expect an exception
        Boolean isExceptionThrown = false;
        try {
            handler.run();
        } catch (TriggerHandler.TriggerHandlerException e) {
            isExceptionThrown = true;
        }
        
        // Verify that an exception was thrown as the loop count was exceeded
        System.assert(isExceptionThrown, 'An exception should be thrown when max loop count is exceeded.');
    }
    
    // Test to ensure setMaxLoopCount updates the loop count when called again
    @isTest
    static void testUpdateMaxLoopCount() {
        bypassTriggersForTest();
        TriggerHandler handler = new MockTriggerHandler();

        // Set max loop count to 2 and simulate trigger execution
        handler.setMaxLoopCount(2);
        handler.run(); // First run
        handler.run(); // Second run, should still not throw exception
        
        // Try running for a third time to exceed the loop count and expect an exception
        Boolean isExceptionThrown = false;
        try {
            handler.run();
        } catch (TriggerHandler.TriggerHandlerException e) {
            isExceptionThrown = true;
        }

        // Verify that an exception was thrown as the loop count was exceeded
        System.assert(isExceptionThrown, 'An exception should be thrown when max loop count is exceeded.');
    }

    // Test to ensure setMaxLoopCount allows infinite executions when set to a negative number
    @isTest
    static void testNegativeMaxLoopCount() {
        bypassTriggersForTest();
        TriggerHandler handler = new MockTriggerHandler();

        // Set max loop count to -1 to allow for infinite executions
        handler.setMaxLoopCount(-1);

        // Simulate running the handler multiple times, expecting no exceptions
        try {
            for (Integer i = 0; i < 5; i++) {
                handler.run();
            }
        } catch (TriggerHandler.TriggerHandlerException e) {
            System.assert(false, 'No exception should be thrown when max loop count is negative.');
        }
    }
    
    // Mock handler class for testing
    private class MockTriggerHandler extends TriggerHandler {
        public override void beforeInsert() {
            // Custom logic for the beforeInsert event, if any
        }
    }
}
