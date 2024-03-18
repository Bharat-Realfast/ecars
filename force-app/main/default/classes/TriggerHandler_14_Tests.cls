
@isTest
public class TriggerHandler_14_Tests {
    
    @isTest
    static void test_setMaxLoopCount_Positive(){
        TriggerHandler handler = new TriggerHandler();
        Test.startTest();
        Exception except = null;
        try {
            handler.setMaxLoopCount(5);
        } catch (Exception e) {
            except = e;
        }
        Test.stopTest();
        System.assert(except == null, 'No exception should be thrown');
    }
    
    @isTest
    static void test_setMaxLoopCount_PreviouslyNotSet(){
        TriggerHandler handler = new TriggerHandler();
        handler.setMaxLoopCount(5);
        Test.startTest();
        Exception except = null;
        try {
            handler.setMaxLoopCount(3);
        } catch (Exception e) {
            except = e;
        }
        Test.stopTest();
        System.assert(except == null, 'No exception should be thrown');
    }
}
