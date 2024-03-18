
@isTest
public class TriggerHandler_5_Tests {
    // Test where 'handlerName' is successfully removed from the bypassedHandlers map
    @isTest
    static void testClearBypassSuccess() {
        // Add a handler to bypassedHandlers
        TriggerHandler.bypass('HandlerToBypass');
        
        // Assert that the handler is in bypassedHandlers
        System.assertEquals(true, TriggerHandler.isBypassed('HandlerToBypass'), 'HandlerToBypass should initially be in bypassedHandlers');
        
        // Attempt to clear the bypass on the handler
        TriggerHandler.clearBypass('HandlerToBypass');
        
        // Assert the handler is no longer being bypassed
        System.assertEquals(false, TriggerHandler.isBypassed('HandlerToBypass'), 'HandlerToBypass should no longer be in bypassedHandlers after clearBypass');
    }

    // Test where 'handlerName' is not present in bypassedHandlers when clearBypass is called
    @isTest
    static void testClearBypassHandlerNotPresent() {
        // Assert that the handler is not in bypassedHandlers
        System.assertEquals(false, TriggerHandler.isBypassed('HandlerNotPresent'), 'HandlerNotPresent should initially not be in bypassedHandlers');
        
        // Attempt to clear the bypass on the handler
        TriggerHandler.clearBypass('HandlerNotPresent');
        
        // Assert the handler is still not being bypassed, as it was not present to begin with
        System.assertEquals(false, TriggerHandler.isBypassed('HandlerNotPresent'), 'HandlerNotPresent should still not be in bypassedHandlers');
    }
}
