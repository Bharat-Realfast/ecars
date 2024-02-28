
@isTest
private class PdfCreateService_1_Tests {

    @isTest
    static void testInvokePdfCreateService_Successful() {
        // Arrange
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Red';
        input.interiorColor = 'Black';
        input.range = '250 miles';
        input.price = 50000;
        
        // Mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', '{"result":"success"}'));

        // Act
        Boolean result = PdfCreateService.invokePdfCreateService(input);

        // Assert
        System.assertEquals(true, result, 'The method should return true for successful callout');
    }

    @isTest
    static void testInvokePdfCreateService_Failure() {
        // Arrange
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Blue';
        input.interiorColor = 'White';
        input.range = '300 miles';
        input.price = 60000;
        
        // Mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'Internal Server Error', '{"error":"Server failure"}'));

        // Act & Assert
        try {
            PdfCreateService.invokePdfCreateService(input);
            System.assert(false, 'An exception should have been thrown due to a failed callout');
        } catch (AuraHandledException e) {
            System.assertEquals('The status code returned was not expected: 500 Internal Server Error', e.getMessage(), 'The exception message should match expected error message');
        }
    }

    @isTest
    static void testInvokePdfCreateService_NullInput() {
        // Act & Assert
        try {
            PdfCreateService.invokePdfCreateService(null);
            System.assert(false, 'An exception should have been thrown when input is null');
        } catch (Exception e) {
            // Since we are not sure what kind of exception will be thrown, we just assert that an exception is caught
            System.assertNotEquals(null, e, 'An exception should be thrown when input is null');
        }
    }

    // Helper class to mock HTTP responses
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String status;
        private String responseBody;

        MockHttpResponseGenerator(Integer code, String status, String responseBody) {
            this.statusCode = code;
            this.status = status;
            this.responseBody = responseBody;
        }

        public HTTPResponse respond(HTTPRequest request) {
            HTTPResponse resp = new HTTPResponse();
            resp.setStatusCode(this.statusCode);
            resp.setStatus(this.status);
            resp.setBody(this.responseBody);
            return resp;
        }
    }
}
