
@isTest
public class TriggerHandler_1_Tests {
    @testSetup
    static void setupTestData() {
        // Create necessary test data
    }

    @isTest
    static void testRunBeforeInsert() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('before insert', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunBeforeUpdate() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('before update', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunBeforeDelete() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('before delete', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunAfterInsert() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after insert', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunAfterUpdate() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after update', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunAfterDelete() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after delete', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunAfterUndelete() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('after undelete', true);
        Exception e = null;
        try {
            handler.run();
        } catch(Exception ex) {
            e = ex;
        }
        Test.stopTest();
        System.assert(e == null, 'Exception was thrown');
    }

    @isTest
    static void testRunWithInvalidTrigger() {
        Test.startTest();
        TriggerHandler handler = new TriggerHandler();
        handler.setTriggerContext('invalid trigger', true);
        Exception expectedException;
        try {
            handler.run();
        } catch (Exception ex) {
            expectedException = ex;
        }
        Test.stopTest();
        // Verify the results
        System.assertNotEquals(null, expectedException, 'Expected an exception but did not get one');
    }
}
