
@isTest
public class TriggerHandler_10_Tests {

    // A utility method to bypass triggers and simulate the run method call multiple times
    private static void simulateRunMethod(Integer maxLoop) {
        // Bypass triggers to prevent unwanted side effects
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        TriggerHandler th = new TriggerHandler();
        th.setMaxLoopCount(maxLoop); // Set the max loop count.

        // Run the handler the specified number of times
        for (Integer i = 0; i < maxLoop; i++) {
            th.run(); // This should succeed until the maxLoop count is reached.
        }
    }

    @isTest
    static void testAddToLoopCountSuccess() {
        // Set up a loop count that should succeed without throwing an exception
        Boolean isExceptionThrown = false;
        try {
            simulateRunMethod(1);
        } catch (TriggerHandler.TriggerHandlerException e) {
            isExceptionThrown = true;
        }
        
        // Assert that no exception is thrown for a successful loop count increment
        System.assert(!isExceptionThrown, 'No exception should be thrown for a successful loop count increment.');
    }

    @isTest
    static void testAddToLoopCountException() {
        // Set up a loop count that should fail on the second increment
        TriggerHandler th = new TriggerHandler();
        th.setMaxLoopCount(1);

        Boolean exceptionThrown = false;
        try {
            th.run(); // First run should succeed.
            th.run(); // Second run should throw an exception.
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = true;
        }
        
        // Assert that an exception is thrown when the maximum loop count is exceeded
        System.assert(exceptionThrown, 'An exception should have been thrown due to max loop count reached.');
    }
    
    @isTest
    static void testAddToLoopCountWithNoInitialSetup() {
        // Attempt to run the handler without setting up the loop count in the loopCountMap
        TriggerHandler th = new TriggerHandler();

        Boolean exceptionThrown = false;
        try {
            th.run(); // This should throw an exception because no max loop was set.
        } catch (TriggerHandler.TriggerHandlerException e) {
            exceptionThrown = true;
        }
        
        // Assert that an exception is thrown when attempting to run without setting up the loop count
        System.assert(exceptionThrown, 'An exception should have been thrown due to missing setup.');
    }
}
