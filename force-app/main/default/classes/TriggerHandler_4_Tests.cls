
@isTest
private class TriggerHandler_4_Tests {
    
    // Happy Path Scenario: Bypass a valid handler
    @isTest
    static void shouldBypassValidHandler() {
        // Arrange
        String handlerName = 'AccountTriggerHandler';
        
        // Act
        TriggerHandler.bypass(handlerName);
        
        // Assert
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assert(isBypassed, 'The handler should be bypassed.');
    }
    
    // Sad Path Scenario: Bypass a null handler
    // Since bypass method doesn't prevent null, assertion is that it will be bypassed.
    @isTest
    static void shouldHandleBypassNullHandler() {
        // Arrange
        String handlerName = null;
        
        // Act
        TriggerHandler.bypass(handlerName);
        
        // Assert
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assert(isBypassed, 'A null handler should be considered bypassed as the method does not validate input.');
    }
    
    // Sad Path Scenario: Bypass an empty string handler
    // Since bypass method doesn't prevent empty string, assertion is that it will be bypassed.
    @isTest
    static void shouldHandleBypassEmptyStringHandler() {
        // Arrange
        String handlerName = '';
        
        // Act
        TriggerHandler.bypass(handlerName);
        
        // Assert
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assert(isBypassed, 'An empty string handler should be considered bypassed as the method does not validate input.');
    }
    
    // Sad Path Scenario: Bypass an already bypassed handler (idempotency check)
    @isTest
    static void shouldHandleBypassAlreadyBypassedHandler() {
        // Arrange
        String handlerName = 'MDTAccountTriggerHandler';
        TriggerHandler.bypass(handlerName);
        
        // Act
        TriggerHandler.bypass(handlerName);
        
        // Assert
        Boolean isBypassed = TriggerHandler.isBypassed(handlerName);
        System.assert(isBypassed, 'The handler should still be bypassed after a second bypass call.');
    }
    
    // Additional test to ensure bypassing one handler does not affect another
    @isTest
    static void bypassOneHandlerShouldNotAffectAnother() {
        // Arrange
        String handlerNameToBypass = 'AccountTriggerHandler';
        String otherHandlerName = 'MDTAccountTriggerHandler';
        
        // Act
        TriggerHandler.bypass(handlerNameToBypass);
        
        // Assert
        Boolean isFirstHandlerBypassed = TriggerHandler.isBypassed(handlerNameToBypass);
        System.assert(isFirstHandlerBypassed, 'The first handler should be bypassed.');
        
        Boolean isSecondHandlerBypassed = TriggerHandler.isBypassed(otherHandlerName);
        System.assert(!isSecondHandlerBypassed, 'The second handler should not be bypassed.');
    }
}
