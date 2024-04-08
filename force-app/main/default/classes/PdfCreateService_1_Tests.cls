
@isTest
private class PdfCreateService_1_Tests {
    
    @testSetup
    static void setup() {
        // Setup method to create test data if necessary
        // In this case, it is not needed as we're mocking the service response.
    }

    @isTest
    static void testInvokePdfCreateService_Success() {
        // Mock the HTTP callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200));
        
        // Prepare the input data
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Blue';
        input.interiorColor = 'Black';
        input.range = '300';
        input.price = 49999.99;
        input.leadRecordId = null; // Assuming we do not need an actual ID for the test
        
        // Make the call and assert
        Boolean isSuccess = PdfCreateService.invokePdfCreateService(input);
        System.assertEquals(true, isSuccess, 'The service should return true for a successful call.');
    }

    @isTest
    static void testInvokePdfCreateService_HttpFailure() {
        // Mock the HTTP callout response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(400));
        
        // Prepare the input data
        PdfCreateService.ServiceInput input = new PdfCreateService.ServiceInput();
        input.exteriorColor = 'Red';
        input.interiorColor = 'Grey';
        input.range = '400';
        input.price = 59999.99;
        input.leadRecordId = null;
        
        // Try-catch to assert exception
        try {
            PdfCreateService.invokePdfCreateService(input);
            System.assert(false, 'An exception should have been thrown due to a non-200 response.');
        } catch (AuraHandledException ex) {
            System.assertEquals(
                'The status code returned was not expected: 400 Bad Request', 
                ex.getMessage(),
                'The error message should match the expected one.'
            );
        }
    }

    // A mock class to simulate HTTP response
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        Integer statusCode;
        
        MockHttpResponseGenerator(Integer statusCode) {
            this.statusCode = statusCode;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setStatus(statusCode == 200 ? 'OK' : 'Bad Request');
            return res;
        }
    }
}
