
@isTest
private class TriggerHandler_1_Tests {

    @isTest
    static void testRun_SuccessfulBeforeInsert() {
        // Create test data and set context
        TriggerHandler th = new TriggerHandler();
        th.setTriggerContext('before insert', true);
        
        Test.startTest();
        th.run();
        Test.stopTest();
        
        // Assertions
        System.assert(th.context == TriggerHandler.TriggerContext.BEFORE_INSERT, 'Context should be BEFORE_INSERT.');
        System.assert(!TriggerHandler.isBypassed('TriggerHandler'), 'Handler should not be bypassed.');
    }

    @isTest
    static void testRun_BypassedHandler() {
        TriggerHandler.bypass('TriggerHandler');
        TriggerHandler th = new TriggerHandler();
        th.setTriggerContext('before insert', true);

        Test.startTest();
        th.run();
        Test.stopTest();

        // Assertions
        System.assert(TriggerHandler.isBypassed('TriggerHandler'), 'Handler should be bypassed.');
        // Further assertions would be needed if there were a way to check if `beforeInsert()` was not called
    }

    @isTest(expectedExceptions = TriggerHandler.TriggerHandlerException.class)
    static void testRun_OutsideTriggerContext() {
        TriggerHandler th = new TriggerHandler();
        th.setTriggerContext(null, false);

        Test.startTest();
        th.run(); // Should throw an exception
        Test.stopTest();
    }

    @isTest(expectedExceptions = TriggerHandler.TriggerHandlerException.class)
    static void testRun_ExceedsLoopCount() {
        TriggerHandler th = new TriggerHandler();
        th.setTriggerContext('before insert', true);
        th.setMaxLoopCount(0);

        Test.startTest();
        th.run(); // Should throw an exception due to loop count exceeded
        Test.stopTest();
    }
}
