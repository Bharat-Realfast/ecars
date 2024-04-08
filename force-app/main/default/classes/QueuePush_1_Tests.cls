
@isTest
public class QueuePush_1_Tests {
  
    private static Integer calloutCount = 0;

    // Create test data for Leads
    @testSetup
    static void setupTestData() {
        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 5; i++) {
            testLeads.add(new Lead(LastName = 'TestLead'+i, Company = 'TestCompany'+i));
        }
        insert testLeads;
    }
    
    // Happy Path: Test with Leads present
    
    
    // Sad Path: Test with no Leads
    @isTest
    static void testWithNoLeads() {
        // Reset callout count
        calloutCount = 0;
        
        // First, delete all Leads to simulate no leads scenario
        delete [SELECT Id FROM Lead];
        
        Test.startTest();
        // Mock the web push service callout
        Test.setMock(WebServiceMock.class, new WebPushServiceMock());
        QueuePush job = new QueuePush();
        System.enqueueJob(job);
        Test.stopTest();
        
        // Assert that no callouts were made
        System.assertEquals(0, calloutCount, 'No web push service calls should be made with no leads.');
    }

    // Mock class for WebPushService callout
    private class WebPushServiceMock implements WebServiceMock {
        
        public void doInvoke(
                Object stub,
                Object request,
                Map<String, Object> response,
                String endpoint,
                String soapAction,
                String requestName,
                String responseNS,
                String responseName,
                String responseType) {
            // Increment callout count
            QueuePush_1_Tests.calloutCount++;
            // Simulate a successful response
            response.put('responseX', new Map<String, Object> { 'responseElement' => 'success' });
        }
    }
}
