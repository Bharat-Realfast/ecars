
@isTest
private class TriggerHandler_6_Tests {
    
    // Test to check if a bypassed handler is successfully identified as bypassed
    @isTest
    static void whenHandlerIsBypassed_ShouldReturnTrue() {
        // Setup test data
        TriggerHandler.bypass('AccountTriggerHandler');
        
        Test.startTest();
        Boolean isHandlerBypassed = TriggerHandler.isBypassed('AccountTriggerHandler');
        Test.stopTest();
        
        System.assertEquals(true, isHandlerBypassed, 'Handler should be bypassed.');
    }
    
    // Test to check if a non-bypassed handler is rightly identified as not bypassed
    @isTest
    static void whenHandlerIsNotBypassed_ShouldReturnFalse() {
        // Setup test data
        // Intentionally not bypassing 'MDTAccountTriggerHandler' to check for false
        
        Test.startTest();
        Boolean isHandlerBypassed = TriggerHandler.isBypassed('MDTAccountTriggerHandler');
        Test.stopTest();
        
        System.assertEquals(false, isHandlerBypassed, 'Handler should not be bypassed.');
    }
    
    // Test to check behavior when null is passed as a handler name
    @isTest
    static void whenHandlerNameIsNull_ShouldHandleGracefully() {
        // Setup test data
        // Intentionally not bypassing null to check for false
        
        Test.startTest();
        Boolean isHandlerBypassed = TriggerHandler.isBypassed(null);
        Test.stopTest();
        
        System.assertEquals(false, isHandlerBypassed, 'Null handler name should not be considered as bypassed.');
    }
}
