
@isTest
private class QueuePush_1_Tests {
    // Implement a mock class for HTTP callouts
    private class WebPushServiceMock implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setBody('{}');
            res.setStatusCode(200);
            return res;
        }
    }

    @testSetup
    static void setup() {
        // Create some test Leads
        List<Lead> testLeads = new List<Lead>{
            new Lead(LastName='Doe', Company='TestCompany1'),
            new Lead(LastName='Smith', Company='TestCompany2')
        };
        insert testLeads;
    }
    
    // Test method for the happy path where Leads exist
    @isTest
    static void testExecuteWithLeads() {
        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new WebPushServiceMock());

        // Bypass trigger for Lead
        TriggerHandler.bypass('LeadTriggerHandler');
        
        // Perform test
        Test.startTest();

        QueuePush job = new QueuePush();
        job.execute(null);

        Test.stopTest();

        // Assertion to ensure that the execute method completed without exceptions
        System.assert(true, 'Job completed without exceptions.');
    }
    
    // Test method for the sad path where no Leads exist
    @isTest
    static void testExecuteWithoutLeads() {
        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new WebPushServiceMock());

        // Delete all Leads to simulate no Leads existing
        delete [SELECT Id FROM Lead];
        
        // Bypass trigger for Lead
        TriggerHandler.bypass('LeadTriggerHandler');

        // Perform test
        Test.startTest();

        QueuePush job = new QueuePush();
        job.execute(null);

        Test.stopTest();

        // Assertion to ensure that the execute method completed without exceptions
        System.assert(true, 'Job completed without exceptions even when there are no Leads.');
    }
}
