
@isTest
public class TriggerHandler_13_Tests {
    
    // Test getCount() method
    @isTest
    static void testGetCount() {
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount();
        
        // Initial count should be 0
        System.assertEquals(0, loopCounter.getCount(), 'Count should initialize to 0');
        
        // Increment the loop count
        loopCounter.increment();
        
        // Count should be 1 after one increment
        System.assertEquals(1, loopCounter.getCount(), 'Count should be 1 after one increment');
        
        // Increment the loop count to 5
        for (Integer i = 0; i < 4; i++) {
            loopCounter.increment();
        }
        
        // Count should be 5 after five increments
        System.assertEquals(5, loopCounter.getCount(), 'Count should be 5 after five increments');
    }
}
