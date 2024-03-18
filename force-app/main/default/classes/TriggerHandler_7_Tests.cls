
@isTest
public class TriggerHandler_7_Tests {

    @testSetup
    static void setupTestData() {
        // Create necessary test data
    }

    /**
     * Test for clearAllBypasses method
     */
    @isTest
    static void testClearAllBypasses() {
        // Add handlers to the bypassedHandlers set
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('ContactTriggerHandler');

        // Clear bypasses
        TriggerHandler.clearAllBypasses();

        // Assert that the bypassedHandlers set is now empty
        System.assertEquals(false, TriggerHandler.isBypassed('AccountTriggerHandler'), 'AccountTriggerHandler should be removed from the bypassedHandlers');
        System.assertEquals(false, TriggerHandler.isBypassed('ContactTriggerHandler'), 'ContactTriggerHandler should be removed from the bypassedHandlers');
    }
}
