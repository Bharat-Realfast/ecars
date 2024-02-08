
@isTest
private class WebPushService_1_Tests {
    
    // Test Setup to create necessary test data
    @testSetup
    static void setup() {
        // Normally, setup test data here, but since WebPushService does not rely on SObjects, we don't need to set up any data.
    }

    // Test for successful HTTP callout
    @isTest
    static void testSuccessfulCallout() {
        // Bypass triggers as per project details
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', '{"success":true}', null));
        
        // Create a ServiceInput
        WebPushService.ServiceInput input = new WebPushService.ServiceInput();
        input.recordId = 'dummyId';
        input.message = 'dummyMessage';
        
        // Invoke method and assert
        Test.startTest();
        Boolean result = WebPushService.invokeWebPushService(input);
        Test.stopTest();

        System.assertEquals(true, result, 'The callout should be successful and return true.');
    }
    
    // Test for unsuccessful HTTP callout
    @isTest
    static void testUnsuccessfulCallout() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Mock callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'Internal Server Error', '{"success":false}', null));
        
        // Create a ServiceInput
        WebPushService.ServiceInput input = new WebPushService.ServiceInput();
        input.recordId = 'dummyId';
        input.message = 'dummyMessage';
        
        // Invoke method and assert
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            Boolean result = WebPushService.invokeWebPushService(input);
        } catch (AuraHandledException e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'An AuraHandledException should be thrown due to unsuccessful callout.');
    }
    
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private final Integer statusCode;
        private final String status;
        private final String responseBody;
        private final Map<String, String> responseHeaders;
        
        public MockHttpResponseGenerator(Integer statusCode, String status, String responseBody, Map<String, String> responseHeaders) {
            this.statusCode = statusCode;
            this.status = status;
            this.responseBody = responseBody;
            this.responseHeaders = responseHeaders;
        }
        
        public HTTPResponse respond(HTTPRequest request) {
            HTTPResponse response = new HTTPResponse();
            response.setStatusCode(statusCode);
            response.setStatus(status);
            response.setBody(responseBody);
            response.setHeader('Content-Type', 'application/json');
            if (responseHeaders != null) {
                for (String headerKey : responseHeaders.keySet()) {
                    response.setHeader(headerKey, responseHeaders.get(headerKey));
                }
            }
            return response;
        }
    }
}
