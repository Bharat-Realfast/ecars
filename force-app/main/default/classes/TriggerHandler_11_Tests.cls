
@isTest
public class TriggerHandler_11_Tests {

    @testSetup
    static void setupTestData() {
        //No test data setup required for this test class
    }

    @isTest
    static void testExceededFalse() {
        // Given
        TriggerHandler.LoopCount loopCountObj = new TriggerHandler.LoopCount(5);
        // When
        Boolean isExceeded = loopCountObj.exceeded();
        // Then
        System.assertEquals(false, isExceeded, 'The exceeded method should return false when count is less than max');
    }

    @isTest
    static void testExceededTrue() {
        // Given
        TriggerHandler.LoopCount loopCountObj = new TriggerHandler.LoopCount(0);
        loopCountObj.increment();
        // When
        Boolean isExceeded = loopCountObj.exceeded();
        // Then
        System.assertEquals(true, isExceeded, 'The exceeded method should return true when count exceeds max');
    }

}
