
@isTest
public class TriggerHandler_4_Tests {
    
    @isTest
    static void test_bypass_AddsHandlerNameToBypassedHandlers() {
        // Given
        String handlerName = 'TestHandler';
        
        // When
        TriggerHandler.bypass(handlerName);
        
        // Then
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(true, isBypassed, 'Handler should be added to bypassed handlers');
    }
    
    @isTest
    static void test_bypass_WithEmptyHandlerName() {
        // Given
        String handlerName = '';
        
        // When
        TriggerHandler.bypass(handlerName);
        
        // Then
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assertEquals(true, isBypassed, 'Empty handler name should be added to bypassed handlers when passed');
    }
    
    @isTest
    static void test_bypass_WithNullHandlerNameDoesNotThrowException() {
        // Given
        String handlerName = null;
        
        // When
        Exception actualException;
        try {
            TriggerHandler.bypass(handlerName);
        } catch (Exception e) {
            actualException = e;
        }
        
        // Then
        System.assertEquals(null, actualException, 'Exception should not be thrown when null handler name is passed');
    }
}
