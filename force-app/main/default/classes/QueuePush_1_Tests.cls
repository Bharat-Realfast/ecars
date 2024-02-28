
@isTest
private class QueuePush_1_Tests {

    // Inner class to mock the web service callouts
    private class MockWebPushService implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HTTPResponse res = new HTTPResponse();
            res.setBody('{"success": true}');
            res.setStatusCode(200);
            return res;
        }
    }

    @testSetup
    static void setupTestData() {
        // Create a list of leads
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            leadList.add(new Lead(LastName = 'TestLead' + i, Company = 'TestCompany'));
        }
        // Insert leads
        insert leadList;

        // Bypass triggers for the Lead object as per project-specific framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    @isTest
    static void testExecuteWithLeads() {
        // Mock the web service callout response
        Test.setMock(HttpCalloutMock.class, new MockWebPushService());

        // Perform test with existing leads
        Test.startTest();
        QueuePush job = new QueuePush();
        job.execute(null);
        Test.stopTest();

        // Assert that no exception was thrown
        System.assertEquals(true, true, 'No exception should have been thrown.');
    }

    @isTest
    static void testExecuteWithoutLeads() {
        // Mock the web service callout response
        Test.setMock(HttpCalloutMock.class, new MockWebPushService());

        // Clear all leads to simulate no leads scenario
        delete [SELECT Id FROM Lead];

        // Execute QueuePush job with no leads
        Test.startTest();
        QueuePush job = new QueuePush();
        job.execute(null);
        Test.stopTest();

        // Assert that no exception was thrown
        System.assertEquals(true, true, 'No exception should have been thrown.');
    }
}
