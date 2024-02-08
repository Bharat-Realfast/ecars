
@isTest
private class InventoryController_1_Tests {
    
    private static String getValidPicklistValue(Schema.SObjectField field) {
        Schema.DescribeFieldResult fieldResult = field.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for(Schema.PicklistEntry f : ple) {
            if (f.isActive()) {
                return f.getValue();
            }
        }
        return null;
    }

    @testSetup
    static void setup() {
        String validExteriorColor = getValidPicklistValue(Vehicle__c.Exterior_Color__c);
        String validInteriorColor = getValidPicklistValue(Vehicle__c.Interior_Color__c);

        if(String.isEmpty(validExteriorColor) || String.isEmpty(validInteriorColor)) {
            System.assert(false, 'No active picklist values found for Exterior_Color__c or Interior_Color__c.');
            return;
        }

        List<Vehicle__c> vehiclesToInsert = new List<Vehicle__c>();
        for(Integer i = 0; i < 25; i++){
            vehiclesToInsert.add(new Vehicle__c(
                Exterior_Color__c = validExteriorColor,
                Interior_Color__c = validInteriorColor,
                Model__c = 'Model' + i,
                Status__c = 'Available',
                Year__c = String.valueOf(2020 + i),
                Package__c = 'Package' + i,
                VIN__c = 'VIN' + i
            ));
        }
        insert vehiclesToInsert;
    }

    @isTest
    static void testGetVehicles_ReturnsVehicles() {
        Test.startTest();
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();

        System.assertNotEquals(null, vehicles, 'The returned list should not be null.');
        System.assert(vehicles.size() <= 20, 'The returned list should contain at most 20 vehicles.');
    }

    @isTest
    static void testGetVehicles_ReturnsEmptyListWhenNoVehicles() {
        delete [SELECT Id FROM Vehicle__c];
        
        Test.startTest();
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();
        
        System.assertEquals(0, vehicles.size(), 'The returned list should be empty.');
    }
}
