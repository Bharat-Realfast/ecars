
@isTest
private class TriggerHandler_7_Tests {

    // Test setup method to create necessary data for testing
    @testSetup
    static void setup() {
        // Since we're testing static methods that operate on a static variable,
        // no setup data is required for this test class.
    }

    // Test method to verify that clearAllBypasses clears the bypassed handlers
    @isTest
    static void testClearAllBypasses_HappyPath() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        // Ensure that handlers are bypassed before clearing
        System.assertEquals(true, TriggerHandler.isBypassed('AccountTriggerHandler'));
        System.assertEquals(true, TriggerHandler.isBypassed('MDTAccountTriggerHandler'));

        // Act
        TriggerHandler.clearAllBypasses();

        // Assert
        System.assertEquals(false, TriggerHandler.isBypassed('AccountTriggerHandler'), 'AccountTriggerHandler should no longer be bypassed');
        System.assertEquals(false, TriggerHandler.isBypassed('MDTAccountTriggerHandler'), 'MDTAccountTriggerHandler should no longer be bypassed');
    }

    // Test method to verify that no handlers are incorrectly marked as bypassed after clearing
    @isTest
    static void testClearAllBypasses_SadPath() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        // Clear all bypasses
        TriggerHandler.clearAllBypasses();

        // Act - No action necessary for this sad path test

        // Assert
        System.assertEquals(false, TriggerHandler.isBypassed('AccountTriggerHandler'), 'AccountTriggerHandler should not be bypassed after clearing all');
        System.assertEquals(false, TriggerHandler.isBypassed('MDTAccountTriggerHandler'), 'MDTAccountTriggerHandler should not be bypassed as it was never added');
    }
}
