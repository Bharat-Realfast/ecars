
@isTest
private class TriggerHandler_11_Tests {

    // Test setup method to create test data
    @testSetup
    static void setup() {
        // In this case, no specific setup is required as we are testing a utility method
    }

    // Happy Path: Test that exceeded() returns false if the count has not exceeded the max
    @isTest
    static void testExceeded_ReturnsFalse_WhenCountNotExceeded() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount(3);
        lc.increment(); // count = 1
        lc.increment(); // count = 2
        Boolean hasExceeded = lc.exceeded();
        
        System.assertFalse(hasExceeded, 'The loop count should not be marked as exceeded.');
    }

    // Happy Path: Test that exceeded() returns false when max is set to a negative value
    @isTest
    static void testExceeded_ReturnsFalse_WhenMaxIsNegative() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount(-1);
        Boolean hasExceeded = lc.exceeded();
        
        System.assertFalse(hasExceeded, 'The loop count should not be marked as exceeded when max is negative.');
    }

    // Sad Path: Test that exceeded() returns true when the count exceeds the max
    @isTest
    static void testExceeded_ReturnsTrue_WhenCountExceedsMax() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount(1);
        lc.increment(); // count = 1
        lc.increment(); // count = 2, this should exceed the max
        Boolean hasExceeded = lc.exceeded();
        
        System.assertTrue(hasExceeded, 'The loop count should be marked as exceeded.');
    }
}
