
@isTest
public class TriggerHandler_6_Tests {
    @testSetup
    static void setupTestData() {
        // No specific data setup required for this test class
    }

    // Test for when handlerName is bypassed
    @isTest
    static void testIsBypassedWhenHandlerIsBypassed() {
        String handlerName = 'AccountTriggerHandler';
        TriggerHandler.bypass(handlerName);
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);

        System.assertEquals(true, isBypassed, 'The handler was not bypassed as expected');
    }

    // Test for when handlerName is not bypassed
    @isTest
    static void testIsBypassedWhenHandlerIsNotBypassed() {
        String handlerName = 'AccountTriggerHandler';
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);

        System.assertEquals(false, isBypassed, 'The handler was bypassed which was not expected');
    }

    // Test for when handlerName is null
    @isTest
    static void testIsBypassedWhenHandlerNameIsNull() {
        String handlerName = null;
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);

        System.assertEquals(false, isBypassed, 'The handler was bypassed which was not expected for null handlerName');
    }

    // Test for when handlerName is empty
    @isTest
    static void testIsBypassedWhenHandlerNameIsEmpty() {
        String handlerName = '';
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);

        System.assertEquals(false, isBypassed, 'The handler was bypassed which was not expected for empty handlerName');
    }

    // Test to ensure bypassed handler is not bypassed after clearBypass
    @isTest
    static void testClearBypass() {
        String handlerName = 'AccountTriggerHandler';
        TriggerHandler.bypass(handlerName);
        TriggerHandler.clearBypass(handlerName);

        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);

        System.assertEquals(false, isBypassed, 'The handler was bypassed which was not expected after clearBypass');
    }

    // Test to ensure all bypassed handlers are not bypassed after clearAllBypasses
    @isTest
    static void testClearAllBypasses() {
        String handlerName1 = 'AccountTriggerHandler';
        String handlerName2 = 'ContactTriggerHandler';
        TriggerHandler.bypass(handlerName1);
        TriggerHandler.bypass(handlerName2);
        TriggerHandler.clearAllBypasses();

        Boolean isBypassed1 = TriggerHandler.isBypassed(handlerName1);
        Boolean isBypassed2 = TriggerHandler.isBypassed(handlerName2);

        System.assertEquals(false, isBypassed1, 'The handler1 was bypassed which was not expected after clearAllBypasses');
        System.assertEquals(false, isBypassed2, 'The handler2 was bypassed which was not expected after clearAllBypasses');
    }
}
