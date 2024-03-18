
@isTest
public class TriggerHandler_12_Tests {

  @testSetup
  static void setupTestData() {
    // There are no dependencies for our target method, so no setup data needed
  }

  @isTest
  static void testTriggerHandlerMaxLoopCount() {
    // Instantiate the TriggerHandler
    TriggerHandler triggerHandler = new TriggerHandler();

    // Set max loop count to 1
    triggerHandler.setMaxLoopCount(1);

    // Run the triggerHandler once, which should be fine
    triggerHandler.run();

    // Run the triggerHandler again, which should throw a TriggerHandlerException
    Exception actualException = null;
    try {
      triggerHandler.run();
    } catch (Exception ex) {
      actualException = ex;
    }
    
    // Verify that the exception was thrown
    System.assertNotEquals(null, actualException, 'Exception was not thrown');
  }
}
