
@isTest
private class PdfCreateService_1_Tests {

    // Mock class to simulate HTTP callout response
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String status;
        private String body;
        
        MockHttpResponseGenerator(Integer statusCode, String status, String body) {
            this.statusCode = statusCode;
            this.status = status;
            this.body = body;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setStatus(status);
            res.setBody(body);
            return res;
        }
    }
    
    @isTest
    static void testInvokePdfCreateService_Successful() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', '{}'));
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        
        // Act
        Test.startTest();
        Boolean result = PdfCreateService.invokePdfCreateService(input);
        Test.stopTest();
        
        // Assert
        System.assertEquals(true, result, 'Method should return true for a successful callout.');
    }
    
    @isTest
    static void testInvokePdfCreateService_Unsuccessful() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'Server Error', '{}'));
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        
        // Act and Assert
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            PdfCreateService.invokePdfCreateService(input);
        } catch (AuraHandledException e) {
            exceptionThrown = true;
            System.assertEquals('The status code returned was not expected: 500 Server Error', e.getMessage(), 'Exception message should match the expected error.');
        }
        Test.stopTest();
        
        System.assertTrue(exceptionThrown, 'An AuraHandledException should have been thrown due to an unsuccessful callout.');
    }
    
    @isTest
    static void testInvokePdfCreateService_Exception() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMock() {
            public HTTPResponse respond(HTTPRequest req) {
                throw new CalloutException('Callout exception occurred');
            }
        });
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        
        // Act and Assert
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            PdfCreateService.invokePdfCreateService(input);
        } catch (Exception e) {
            exceptionThrown = true;
            System.assert(e instanceof CalloutException, 'The exception should be a CalloutException.');
        }
        Test.stopTest();
        
        System.assertTrue(exceptionThrown, 'An exception should have been thrown due to a callout error.');
    }
}
