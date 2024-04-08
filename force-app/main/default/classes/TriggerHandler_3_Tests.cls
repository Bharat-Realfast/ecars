
@isTest
private class TriggerHandler_3_Tests {
    
    @isTest
    static void testClearMaxLoopCount() {
        // Setup - create an instance of the TriggerHandler and set a max loop count
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(1);

        Test.startTest();
        // Execute the method to clear the max loop count
        handler.clearMaxLoopCount();
        Test.stopTest();

        // Assert that the max loop count is set to -1, effectively clearing it
        Integer expectedLoopCount = -1;
        Integer actualLoopCount = TriggerHandler.LoopCountMap.get(handler.getHandlerName()).getMax();
        System.assertEquals(expectedLoopCount, actualLoopCount, 'The max loop count should be cleared to -1');
    }

    @isTest
    static void testClearMaxLoopCountWithoutSettingItFirst() {
        // Setup - create an instance of the TriggerHandler
        TriggerHandler handler = new TriggerHandler();
        
        Test.startTest();
        // Execute the method to clear the max loop count without setting it first
        handler.clearMaxLoopCount();
        Test.stopTest();
        
        // Assert that the max loop count is set to -1, even without setting it first
        Integer expectedLoopCount = -1;
        Integer actualLoopCount = TriggerHandler.LoopCountMap.get(handler.getHandlerName()).getMax();
        System.assertEquals(expectedLoopCount, actualLoopCount, 'The max loop count should still be cleared to -1');
    }
}
