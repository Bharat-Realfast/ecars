
@isTest
private class TriggerHandler_7_Tests {

    @isTest
    static void testClearAllBypasses_HappyPath() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('ContactTriggerHandler');
        
        // Pre-check to ensure bypasses are set
        System.assert(TriggerHandler.isBypassed('AccountTriggerHandler'), 'AccountTriggerHandler should be bypassed');
        System.assert(TriggerHandler.isBypassed('ContactTriggerHandler'), 'ContactTriggerHandler should be bypassed');
        
        // Act
        TriggerHandler.clearAllBypasses();
        
        // Assert
        System.assert(!TriggerHandler.isBypassed('AccountTriggerHandler'), 'AccountTriggerHandler should not be bypassed after clearing');
        System.assert(!TriggerHandler.isBypassed('ContactTriggerHandler'), 'ContactTriggerHandler should not be bypassed after clearing');
    }
}
