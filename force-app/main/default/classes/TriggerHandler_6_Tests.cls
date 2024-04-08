
@isTest
private class TriggerHandler_6_Tests {

    // Test to verify that a bypassed handler returns true
    @isTest
    static void testIsBypassedWithBypassedHandler() {
        String handlerName = 'TestHandler';
        TriggerHandler.bypass(handlerName); // Bypass the handler

        Boolean isHandlerBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(true, isHandlerBypassed, 'Handler should be bypassed');
    }

    // Test to verify that a non-bypassed handler returns false
    @isTest
    static void testIsBypassedWithNonBypassedHandler() {
        String handlerName = 'NonBypassedHandler';
        // Do not bypass the handler

        Boolean isHandlerBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(false, isHandlerBypassed, 'Handler should not be bypassed');
    }

    // Test to verify behavior with null handler name
    @isTest
    static void testIsBypassedWithNullHandlerName() {
        String handlerName = null;
        Boolean isHandlerBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(false, isHandlerBypassed, 'Null handler should not be considered as bypassed');
    }

    // Test to verify behavior with empty string handler name
    @isTest
    static void testIsBypassedWithEmptyHandlerName() {
        String handlerName = '';
        Boolean isHandlerBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(false, isHandlerBypassed, 'Empty handler name should not be considered as bypassed');
    }

}
