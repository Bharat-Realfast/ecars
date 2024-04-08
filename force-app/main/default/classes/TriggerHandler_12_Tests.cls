
@isTest
private class TriggerHandler_12_Tests {

    @isTest
    static void testGetMax_DefaultValue() {
        // Setup test data
        TriggerHandler.LoopCount defaultLoopCount = new TriggerHandler.LoopCount();
        
        // Execute the method being tested
        Integer expectedDefaultMax = 5; // default value as per the inner class constructor
        Integer actualMax = defaultLoopCount.getMax();
        
        // Verify the results
        System.assertEquals(expectedDefaultMax, actualMax, 'The default max loop count should be 5.');
    }

    @isTest
    static void testGetMax_SpecificValue() {
        // Setup test data
        Integer expectedMax = 10;
        TriggerHandler.LoopCount loopCountWithMax = new TriggerHandler.LoopCount(expectedMax);
        
        // Execute the method being tested
        Integer actualMax = loopCountWithMax.getMax();
        
        // Verify the results
        System.assertEquals(expectedMax, actualMax, 'The max loop count should be the value set by constructor.');
    }

    @isTest
    static void testGetMax_NegativeValue() {
        // Setup test data
        Integer expectedMax = -1;
        TriggerHandler.LoopCount loopCountWithNegativeMax = new TriggerHandler.LoopCount(expectedMax);
        
        // Execute the method being tested
        Integer actualMax = loopCountWithNegativeMax.getMax();
        
        // Verify the results
        System.assertEquals(expectedMax, actualMax, 'The max loop count should represent no limit when negative value is set.');
    }

}
