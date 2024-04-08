
@isTest
private class TriggerHandler_2_Tests {
    
    // Test setup method to create reusable test data
    @testSetup
    static void setup() {
        // No specific setup required for testing this method
    }

    // Test for setting the maximum loop count for a new handler
    @isTest
    static void testSetNewMaxLoopCount() {
        TriggerHandler handler = new TriggerHandler();
        Test.startTest();
        handler.setMaxLoopCount(1);
        Test.stopTest();

        // Assertions
        System.assertEquals(1, TriggerHandler.loopCountMap.get(handler.getHandlerName()).getMax(), 'The loop max should be 1');
        System.assertEquals(0, TriggerHandler.loopCountMap.get(handler.getHandlerName()).getCount(), 'The loop count should be 0');
    }

    // Test for updating the maximum loop count for an existing handler
    @isTest
    static void testUpdateMaxLoopCount() {
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(1); // Set initial max loop count

        Test.startTest();
        handler.setMaxLoopCount(3); // Update max loop count
        Test.stopTest();

        // Assertions
        System.assertEquals(3, TriggerHandler.loopCountMap.get(handler.getHandlerName()).getMax(), 'The loop max should be updated to 3');
        System.assertEquals(0, TriggerHandler.loopCountMap.get(handler.getHandlerName()).getCount(), 'The loop count should remain 0');
    }

    // Test for passing null as max value
    // Note: This test is expected to fail due to a null pointer exception, which shows an area for improvement in the method
    @isTest
    static void testSetMaxLoopCountNullValue() {
        TriggerHandler handler = new TriggerHandler();
        Boolean exceptionThrown = false;

        try {
            Test.startTest();
            handler.setMaxLoopCount(null);
            Test.stopTest();
        } catch (NullPointerException e) {
            exceptionThrown = true;
        }

        // Assertions
        System.assert(exceptionThrown, 'Passing null should throw a NullPointerException');
    }
}
