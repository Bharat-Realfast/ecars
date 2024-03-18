
@isTest
public class TriggerHandler_2_Tests {
    
    @isTest
    static void testSetMaxLoopCount() {
        TriggerHandler th = new TriggerHandler();
        th.setMaxLoopCount(4);
        System.assert(TriggerHandler.loopCountMap.containsKey(String.valueOf(th)), 'Max loop count not set correctly');
        System.assertEquals(4, TriggerHandler.loopCountMap.get(String.valueOf(th)).getMax(), 'Max loop count not set correctly');
    }
    
    @isTest
    static void testSetMaxLoopCountExist() {
        TriggerHandler th = new TriggerHandler();
        th.setMaxLoopCount(4);
        th.setMaxLoopCount(5);
        System.assert(TriggerHandler.loopCountMap.containsKey(String.valueOf(th)), 'Max loop count not updated correctly');
        System.assertEquals(5, TriggerHandler.loopCountMap.get(String.valueOf(th)).getMax(), 'Max loop count not updated correctly');
    }
    
    @isTest
    static void testSetMaxLoopCountException() {
        TriggerHandler th = new TriggerHandler();
        Exception actualException;
        try {
            th.setMaxLoopCount(null);
        } catch(Exception e) {
            actualException = e;
        }
        System.assertNotNull(actualException, 'Exception not thrown for null max loop count');
    }
}
