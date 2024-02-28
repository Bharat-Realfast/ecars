
@isTest
public class TriggerHandler_13_Tests {

    // Test setup method to create data
    @testSetup
    static void setup() {
        // Intentionally left blank as no test data is required for unit testing getCount()
        // However, this method is a placeholder for creating test data if needed in the future
    }
    
    // Test method for verifying the count when no loops have occurred
    @isTest
    static void testGetCountWhenNoLoops() {
        // Given
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount();

        // When
        Integer count = loopCounter.getCount();

        // Then
        System.assertEquals(0, count, 'The loop count should be 0 when no loops have occurred');
    }
    
    // Test method for verifying the count after a few loops
    @isTest
    static void testGetCountAfterFewLoops() {
        // Given
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount();
        loopCounter.increment();
        loopCounter.increment();
        loopCounter.increment();

        // When
        Integer count = loopCounter.getCount();

        // Then
        System.assertEquals(3, count, 'The loop count should equal the number of times increment was called');
    }
    
    // Test method for verifying the count with default constructor
    @isTest
    static void testGetCountWithDefaultConstructor() {
        // Given
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount();

        // When
        Integer count = loopCounter.getCount();
        // Default count should be 0 with default constructor
        // Then
        System.assertEquals(0, count, 'The loop count should be 0 with default constructor');
    }
    
    // Test to ensure loop count doesn't exceed the max when set to -1 (unlimited)
    @isTest
    static void testGetCountWithNoMaxLimit() {
        // Given
        TriggerHandler.LoopCount loopCounter = new TriggerHandler.LoopCount(-1); // -1 for unlimited

        // When
        for(Integer i = 0; i < 100; i++) { // simulate 100 increments
            loopCounter.increment();
        }
        Integer count = loopCounter.getCount();

        // Then
        System.assertEquals(100, count, 'The loop count should match the number of increments with no max limit');
    }
}
