
@isTest
private class TriggerHandler_3_Tests {

    // Utility method to create a dummy TriggerHandler instance
    private static TriggerHandler getDummyHandlerInstance() {
        TriggerHandler th = new TriggerHandler();
        th.setTriggerContext('before insert', true);
        return th;
    }

    // Test method to verify that calling clearMaxLoopCount sets the loop count to have no maximum limit
    @isTest
    static void testClearMaxLoopCountSetsNoLimit() {
        // Arrange
        TriggerHandler handler = getDummyHandlerInstance();
        handler.setMaxLoopCount(1);

        // Act & Assert
        Test.startTest();
        handler.clearMaxLoopCount();

        // Normally, this would exceed the loop count and throw an exception,
        // but since we cleared the max loop count, it should not throw an exception.
        try {
            handler.run();
            handler.run();
        } catch (TriggerHandler.TriggerHandlerException e) {
            System.assert(false, 'No exception should be thrown since max loop count is cleared');
        }
        Test.stopTest();
    }

    // Test method to verify behavior when there is no loop count set and we clear it
    @isTest
    static void testClearMaxLoopCountWithoutInitialSet() {
        // Arrange
        TriggerHandler handler = getDummyHandlerInstance();

        // Act & Assert
        Test.startTest();
        handler.clearMaxLoopCount();

        // Normally, this would exceed the default loop count and throw an exception,
        // but since we cleared the max loop count, it should not throw an exception.
        try {
            handler.run();
            for (Integer i = 0; i < 10; i++) { // Exceed the normal default count
                handler.run();
            }
        } catch (TriggerHandler.TriggerHandlerException e) {
            System.assert(false, 'No exception should be thrown since max loop count is cleared');
        }
        Test.stopTest();
    }
}
