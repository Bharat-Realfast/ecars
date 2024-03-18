
@isTest
public class PdfCreateService_1_Tests {
    @testSetup
    static void setupTestData() {
        // Create a Lead Record
        Lead testLead = new Lead(LastName='Doe', Company='TestCo');
        insert testLead;
    }
    
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"pdf":"success"}');
            res.setStatusCode(200);
            return res;
        }
    }

    public class MockHttpResponseGeneratorUnsuccessful implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"error":"failure"}');
            res.setStatusCode(500);
            return res;
        }
    }
    
    // Test for Happy Path
    @isTest static void testInvokePdfCreateService_HappyPath() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Blue';
        input.interiorColor = 'Black';
        input.range = '500';
        input.price = 50000.0;
        input.leadRecordId = [SELECT Id FROM Lead LIMIT 1].Id;
        
        Test.startTest();
        Boolean isSuccess = PdfCreateService.invokePdfCreateService(input);
        Test.stopTest();
        
        System.assertEquals(true, isSuccess, 'Expected successful PDF service invocation');
    }

    // Test for HTTP Response other than 200
    @isTest static void testInvokePdfCreateService_UnsuccessfulResponse() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorUnsuccessful());
        
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Blue';
        input.interiorColor = 'Black';
        input.range = '500';
        input.price = 50000.0;
        input.leadRecordId = [SELECT Id FROM Lead LIMIT 1].Id;
        
        Test.startTest();
        try {
            PdfCreateService.invokePdfCreateService(input);
        } catch(AuraHandledException e) {
            System.assert(e.getMessage().contains('The status code returned was not expected:'), 'Expected exception for unsuccessful HTTP response');
        }
        Test.stopTest();
    }

    // Test for Null Input
    @isTest static void testInvokePdfCreateService_NullInput() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        Boolean isSuccess = false;
        try {
            isSuccess = PdfCreateService.invokePdfCreateService(null);
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Argument cannot be null.'), 'Expected exception for null input');
        }
        Test.stopTest();
        
        System.assertEquals(false, isSuccess, 'Expected unsuccessful PDF service invocation');
    }
}
