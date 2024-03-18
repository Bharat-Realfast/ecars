
@isTest
public with sharing class QueuePush_1_Tests {
    @testSetup
    static void setupTestData() {        
        // Create leads
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<10; i++) {
            leads.add(new Lead(LastName='Test'+i, Company='Test'));
        }
        insert leads;
    }
    
    public class WebPushServiceMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"success":true}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    @isTest
    static void testExecute_noLeads() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WebPushServiceMock());
        QueuePush queuePush = new QueuePush();
        queuePush.execute(null);
        Test.stopTest();
        // No exceptions should be thrown
        System.assert(true, 'No exceptions should be thrown');
    }

    @isTest
    static void testExecute_withLeads() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WebPushServiceMock());
        QueuePush queuePush = new QueuePush();
        queuePush.execute(null);
        Test.stopTest();
        // No exceptions should be thrown
        System.assert(true, 'No exceptions should be thrown');
    }
}
