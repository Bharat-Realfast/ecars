
@isTest
private class TriggerHandler_5_Tests {

    @testSetup
    static void setup() {
        // Generally, we create test data here, but for this specific method, no data setup is required.
    }

    /**
     * Happy Path - Handler is bypassed and then cleared successfully.
     */
    @isTest
    static void testClearBypassAfterBypass() {
        // Arrange
        String handlerName = 'AccountTriggerHandler';
        TriggerHandler.bypass(handlerName);

        // Assert pre-clear
        Boolean isBypassedBefore = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(true, isBypassedBefore, 'Handler should be bypassed initially');

        // Act
        TriggerHandler.clearBypass(handlerName);

        // Assert post-clear
        Boolean isBypassedAfter = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(false, isBypassedAfter, 'Handler should no longer be bypassed after clearBypass is called');
    }

    /**
     * Sad Path - Attempting to clear a handler that was not bypassed.
     */
    @isTest
    static void testClearBypassWithoutBypass() {
        // Arrange
        String handlerName = 'AccountTriggerHandler';

        // Act
        TriggerHandler.clearBypass(handlerName);

        // Assert
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(false, isBypassed, 'Handler should not be bypassed');
    }
}
