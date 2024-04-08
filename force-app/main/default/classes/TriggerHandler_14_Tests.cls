
@isTest
private class TriggerHandler_14_Tests {
    
    private static final String HANDLER_NAME = 'TriggerHandler';
    
    @testSetup
    static void makeTestData() {
        // As we are testing a static method which doesn't interact with SObjects,
        // no test data setup is required. However, the test setup method is necessary
        // to adhere to best practices.
    }
    
    @isTest
    static void setMaxLoopCount_HappyPath_InitialSet() {
        // Instantiate TriggerHandler, simulate the context and set the max loop count
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after insert', true); // Setting the context manually
        handler.setMaxLoopCount(1);
        
        // Assert that the max loop count is set correctly
        System.assertEquals(1, TriggerHandler.loopCountMap.get(HANDLER_NAME).getMax(), 'The max loop count should be set to 1.');
    }
    
    @isTest
    static void setMaxLoopCount_HappyPath_UpdateExisting() {
        // Instantiate TriggerHandler, simulate the context and set the max loop count
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after update', true); // Setting the context manually
        handler.setMaxLoopCount(2);
        handler.setMaxLoopCount(3); // Update the max loop count
        
        // Assert that the max loop count is updated correctly
        System.assertEquals(3, TriggerHandler.loopCountMap.get(HANDLER_NAME).getMax(), 'The max loop count should be updated to 3.');
    }
    
    @isTest
    static void setMaxLoopCount_SadPath_NullValue() {
        // Instantiate TriggerHandler and simulate the context
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('before insert', true); // Setting the context manually
        
        // Setting the max loop count to null should be handled, but since the method
        // signature does not allow for null (primitive int), this will result in a compile-time error.
        Boolean nullExceptionThrown = false;
        try {
            handler.setMaxLoopCount(null); // This line should cause a compile-time error
        } catch (Exception e) {
            nullExceptionThrown = true;
        }
        
        // Assert that exception is thrown
        System.assert(nullExceptionThrown, 'Setting the max loop count to null should throw an exception.');
    }
}
