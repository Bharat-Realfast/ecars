
@isTest
private class TriggerHandler_12_Tests {
    
    // Test method to check the default maximum loop count
    @isTest
    static void testGetDefaultMaxLoopCount() {
        // Arrange
        TriggerHandler.LoopCount loopCount = new TriggerHandler.LoopCount();
        
        // Act
        Integer defaultMax = loopCount.getMax();
        
        // Assert
        System.assertEquals(5, defaultMax, 'The default max loop count should be 5');
    }
    
    // Test method to check the maximum loop count after setting a custom value
    @isTest
    static void testGetCustomMaxLoopCount() {
        // Arrange
        TriggerHandler.LoopCount loopCount = new TriggerHandler.LoopCount(3);
        
        // Act
        Integer customMax = loopCount.getMax();
        
        // Assert
        System.assertEquals(3, customMax, 'The custom max loop count should be set to 3');
    }
    
    // Test method to check the behavior with negative loop count
    @isTest
    static void testGetNegativeMaxLoopCount() {
        // Arrange
        TriggerHandler.LoopCount loopCount = new TriggerHandler.LoopCount(-1);
        
        // Act
        Integer negativeMax = loopCount.getMax();
        
        // Assert
        System.assertEquals(-1, negativeMax, 'The negative max loop count should be handled correctly');
    }
    
    // Setup method to bypass triggers
    @testSetup
    static void setup() {
        // Bypass triggers for Account object to prevent trigger loops during tests
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // ... (Additional setup if required) ...
    }
}
