
@isTest
private class TriggerHandler_9_Tests {

    // Happy Path: Test LoopCount constructor with a positive value
    @isTest
    static void testLoopCountWithPositiveMax() {
        Integer testMax = 5;
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount(testMax);
        System.assertEquals(testMax, loopCountInstance.getMax(), 'The max loop count should be equal to the passed value.');
        System.assertEquals(0, loopCountInstance.getCount(), 'Initial count should be zero.');
    }

    // Happy Path: Test LoopCount constructor allowing infinite loops (-1)
    @isTest
    static void testLoopCountWithNegativeOne() {
        Integer testMax = -1;
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount(testMax);
        System.assertEquals(testMax, loopCountInstance.getMax(), 'The max loop count should allow infinite loops.');
        System.assertFalse(loopCountInstance.exceeded(), 'The count should not be considered exceeded for -1 max value.');
    }

    // Sad Path: There is no explicit sad path for the constructor as it currently stands, since we are not testing with null values
    // or with any context that would cause an exception or error during object creation.

    // Note: We do not have to write a test for an exceptional scenario since the constructor does not throw exceptions.
}
