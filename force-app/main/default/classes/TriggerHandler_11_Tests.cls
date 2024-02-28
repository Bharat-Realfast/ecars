
@isTest
private class TriggerHandler_11_Tests {

    // Test Setup to create necessary default data
    @testSetup
    static void setup() {
        // Since the method we are testing does not interact with any SObject, we do not need to insert any test data here.
    }
    
    // Method to disable related triggers
    static void disableTriggers() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Test when the count has not exceeded the max count
    @isTest
    static void testCountNotExceeded() {
        disableTriggers();
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount(1);
        Boolean hasExceeded = loopCounter.increment();
        System.assertEquals(false, hasExceeded, 'The loop count should not be exceeded.');
    }
    
    // Test when the count has exceeded the max count
    @isTest
    static void testCountExceeded() {
        disableTriggers();
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount(0);
        Boolean hasExceeded = loopCounter.increment();
        System.assertEquals(true, hasExceeded, 'The loop count should be exceeded.');
    }
    
    // Test when the max count is negative (no limit)
    @isTest
    static void testNegativeMaxCount() {
        disableTriggers();
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount(-1);
        Boolean isFirstIncrementExceeded = loopCounter.increment();
        Boolean isSecondIncrementExceeded = loopCounter.increment();
        System.assertEquals(false, isFirstIncrementExceeded, 'The loop count should not be exceeded on first increment.');
        System.assertEquals(false, isSecondIncrementExceeded, 'The loop count should not be exceeded on second increment.');
    }
}
