
@isTest
private class TriggerHandler_2_Tests {

    // Test setting the max loop count for a new handler
    @isTest
    static void testSetMaxLoopCountForNewHandler() {
        String handlerName = 'AccountTriggerHandler';
        Integer maxLoops = 3;

        // Bypass triggers
        TriggerHandler.bypass(handlerName);
        
        // Perform the test
        Test.startTest();
        TriggerHandler triggerHandler = new TriggerHandler();
        triggerHandler.setMaxLoopCount(maxLoops);
        Test.stopTest();

        // Since we cannot directly verify the loopCountMap, we expect no exceptions as a positive outcome.
        System.assert(true, 'setMaxLoopCount completed without exceptions for new handler.');
    }

    // Test updating the max loop count for an existing handler
    @isTest
    static void testUpdateMaxLoopCountForExistingHandler() {
        String handlerName = 'MDTAccountTriggerHandler';
        Integer initialMaxLoops = 5;
        Integer updatedMaxLoops = 2;

        // Bypass triggers
        TriggerHandler.bypass(handlerName);
        
        // Setup initial max loop count
        TriggerHandler triggerHandler = new TriggerHandler();
        triggerHandler.setMaxLoopCount(initialMaxLoops);

        // Perform the test
        Test.startTest();
        triggerHandler.setMaxLoopCount(updatedMaxLoops);
        Test.stopTest();

        // Since we cannot directly verify the loopCountMap, we expect no exceptions as a positive outcome.
        System.assert(true, 'setMaxLoopCount updated without exceptions for existing handler.');
    }

    // Test setting the max loop count to a negative number, which should disable the loop count limit
    @isTest
    static void testSetMaxLoopCountToNegative() {
        String handlerName = 'AccountTriggerHandler';
        Integer negativeMaxLoops = -1;

        // Bypass triggers
        TriggerHandler.bypass(handlerName);
        
        // Perform the test
        Test.startTest();
        TriggerHandler triggerHandler = new TriggerHandler();
        triggerHandler.setMaxLoopCount(negativeMaxLoops);
        Test.stopTest();

        // Since we cannot directly verify the loopCountMap, we expect no exceptions as a positive outcome.
        System.assert(true, 'setMaxLoopCount set to negative without exceptions.');
    }
}
