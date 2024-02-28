
@isTest
private class WebPushService_1_Tests {

    // Helper method to create a mock HTTP response
    private class MockHttpResponse implements HttpCalloutMock {
        private Integer statusCode;
        private String status;
        private String body;

        public MockHttpResponse(Integer statusCode, String status, String body) {
            this.statusCode = statusCode;
            this.status = status;
            this.body = body;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(statusCode);
            response.setStatus(status);
            response.setBody(body);
            return response;
        }
    }

    @isTest
    static void testInvokeWebPushService_Success() {
        // Arrange
        WebPushService.ServiceInput input = new WebPushService.ServiceInput();
        input.recordId = 'someRecordId';
        input.message = 'Test Message';
        input.setSubscription = true;

        // Mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(200, 'OK', '{}'));

        // Act
        Test.startTest();
        Boolean result = WebPushService.invokeWebPushService(input);
        Test.stopTest();

        // Assert
        System.assertEquals(true, result, 'The method should return true for a successful response');
    }

    @isTest
    static void testInvokeWebPushService_Failure() {
        // Arrange
        WebPushService.ServiceInput input = new WebPushService.ServiceInput();
        input.recordId = 'someRecordId';
        input.message = 'Test Message';
        input.setSubscription = true;

        // Mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(400, 'Bad Request', '{}'));

        // Act & Assert
        Test.startTest();
        try {
            WebPushService.invokeWebPushService(input);
            System.assert(false, 'The method should have thrown an AuraHandledException');
        } catch (AuraHandledException e) {
            System.assertEquals('The status code returned was not expected: 400 Bad Request', e.getMessage(), 'The exception message should match the expected error');
        }
        Test.stopTest();
    }

    @isTest
    static void testInvokeWebPushService_NullInput() {
        // Act & Assert
        Test.startTest();
        try {
            WebPushService.invokeWebPushService(null);
            System.assert(false, 'The method should have thrown a NullPointerException');
        } catch (Exception e) {
            System.assert(e instanceof NullPointerException, 'The exception should be a NullPointerException');
        }
        Test.stopTest();
    }
}
