
@isTest
private class TriggerHandler_5_Tests {

    // Test setup method to initialize the test data
    @testSetup
    static void setup() {
        // For this test class, since the method is static and manipulates a static variable, 
        // we do not need to insert any data into the database
    }

    // Utility method to bypass a handler for testing purposes
    private static void bypassHandler(String handlerName) {
        TriggerHandler.bypass(handlerName);
    }

    // Happy Path Test: Successfully clear a bypassed handler
    @isTest
    static void shouldSuccessfullyClearBypassedHandler() {
        String handlerName = 'TestHandler';
        bypassHandler(handlerName);

        // Preconditions check
        System.assert(TriggerHandler.isBypassed(handlerName), 'Handler should be bypassed before clearing');

        // Test clearBypass
        Test.startTest();
        TriggerHandler.clearBypass(handlerName);
        Test.stopTest();

        // Assertions
        System.assert(!TriggerHandler.isBypassed(handlerName), 'Handler should no longer be bypassed after clearing');
    }

    // Sad Path Test: Clearing a non-bypassed handler should not throw an exception
    @isTest
    static void shouldNotThrowWhenClearingNonBypassedHandler() {
        String handlerName = 'NonExistentHandler';

        // Preconditions check
        System.assert(!TriggerHandler.isBypassed(handlerName), 'Handler should not be bypassed before clearing');

        // Test clearBypass
        Test.startTest();
        TriggerHandler.clearBypass(handlerName);
        Test.stopTest();

        // Assertions: No change expected, should still not be bypassed
        System.assert(!TriggerHandler.isBypassed(handlerName), 'Handler should still not be bypassed after clearing');
    }

    // Additional tests for exceptional scenarios are not required as the method does not throw any exceptions
}
