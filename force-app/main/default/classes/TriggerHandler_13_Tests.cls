
@isTest
private class TriggerHandler_13_Tests {

    // Set up the test data
    @testSetup
    static void setup() {
        // No specific setup required for testing getCount method
        // since we are not dependent on any SObjects or database operations
    }

    // Test the default count upon instantiation
    @isTest
    static void testDefaultCount() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount();
        // Assert the default loop count is 0
        System.assertEquals(0, lc.getCount(), 'The default count should be 0.');
    }

    // Test the count after setting a maximum loop count
    @isTest
    static void testSetMaxLoopCount() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount(3);
        // Assert the loop count is still 0 after setting max
        System.assertEquals(0, lc.getCount(), 'The count should be 0 after setting max loop count.');
    }

    // Test the count after some increments
    @isTest
    static void testIncrementCount() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount(3);
        lc.increment(); // increment once
        lc.increment(); // increment twice
        // Assert the count is 2 after two increments
        System.assertEquals(2, lc.getCount(), 'The count should be 2 after two increments.');
    }
}
