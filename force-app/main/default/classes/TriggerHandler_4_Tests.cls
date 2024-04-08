
@isTest
private class TriggerHandler_4_Tests {

    // Method to test adding a handler to the bypassed list
    @isTest
    static void shouldAddHandlerToBypass() {
        // Act
        TriggerHandler.bypass('TestHandler');
        
        // Assert
        System.assert(TriggerHandler.isBypassed('TestHandler'), 'Handler should be bypassed.');
    }

    // Method to test bypassing an already bypassed handler
    @isTest
    static void shouldNotAffectBypassWhenHandlerAlreadyBypassed() {
        // Arrange
        TriggerHandler.bypass('TestHandler');
        Integer bypassCountBefore = TriggerHandler.bypassedHandlers.size();
        
        // Act
        TriggerHandler.bypass('TestHandler');
        
        // Assert
        Integer bypassCountAfter = TriggerHandler.bypassedHandlers.size();
        System.assertEquals(bypassCountBefore, bypassCountAfter, 'Bypassing an already bypassed handler should not change bypass count.');
        System.assert(TriggerHandler.isBypassed('TestHandler'), 'Handler should still be bypassed.');
    }
}
