
@isTest
public class TriggerHandler_8_Tests {
    @isTest 
    static void testLoopCountWithoutParameters() {
        // Test LoopCount() constructor without parameters
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount();
        // The default count should be 0
        System.assertEquals(0, loopCountInstance.getCount(), 'Default count should be 0');
        // The default max should be 5
        System.assertEquals(5, loopCountInstance.getMax(), 'Default max should be 5');
    }
    
    @isTest 
    static void testLoopCountWithParameters() {
        // Test LoopCount() constructor with parameter
        Integer maxLoop = 10;
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount(maxLoop);
        // The default count should be 0
        System.assertEquals(0, loopCountInstance.getCount(), 'Default count should be 0');
        // The max should be the passed parameter
        System.assertEquals(maxLoop, loopCountInstance.getMax(), 'Max should be the passed parameter');
    }
    
    @isTest 
    static void testIncrementAndExceeded() {
        // Test increment() and exceeded() methods
        Integer maxLoop = 3;
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount(maxLoop);
       
        // Increment the count and check if it exceeds max
        for(Integer i = 1; i <= maxLoop + 1; i++) {
            Boolean isExceeded = loopCountInstance.increment();
            if(i <= maxLoop) {
                System.assert(!isExceeded, 'Count should not exceed max before exceeding it');
            } else {
                System.assert(isExceeded, 'Count should exceed max when it exceeds it');
            }
        }
    }
    
    @isTest 
    static void testSetMax() {
        // Test setMax() method
        Integer initialMaxLoop = 3;
        Integer newMaxLoop = 5;
        TriggerHandler.LoopCount loopCountInstance = new TriggerHandler.LoopCount(initialMaxLoop);
        
        // Set a new max
        loopCountInstance.setMax(newMaxLoop);
        // The max should be the new value set
        System.assertEquals(newMaxLoop, loopCountInstance.getMax(), 'Max should be the new value set');
    }
}
