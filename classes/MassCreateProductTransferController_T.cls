@isTest
private class MassCreateProductTransferController_T {
    @TestSetup
    static void makeData() {
        Account manufacturer = new Account(
            Name = 'Test Manufacturer'
        );
        insert manufacturer;

        Account account = new Account(
            Name = 'Test PR Account'
        );
        insert account;

        Account vendor = new Account(
            Name = 'Test Vendor Account'
        );
        insert vendor;

        Schema.Location sourceLocation = new Schema.Location(
            Name = 'Test Source Location',
            LocationType = 'Warehouse',
            IsInventoryLocation = true
        );
        insert sourceLocation;

        Schema.Location destinationLocation = new Schema.Location(
            Name = 'Test Destination Location',
            LocationType = 'Warehouse'
        );
        insert destinationLocation;
        
        ProductRequest productRequest = new ProductRequest(
            AccountId = account.Id,
            ShipToStreet = '123 Main Street',
            ShipToCity = 'Atlanta',
            ShipToState = 'Georgia',
            ShipToPostalCode = '30303',
            Ship_to_User__c = System.UserInfo.getUserId()
        );
        insert productRequest;

        Product2 product = new Product2(
            Name = 'Test Product',
            Manufacturer_Account__c = manufacturer.Id,
            Family = 'Solar Modules',
            Status__c = '1- Standard',
            AcctSeed__Inventory_Type__c = 'Purchased',
            AcctSeed__Inventory_Product__c = true,
            AcctSeed__Unit_Cost__c = 10.00
        );
        insert product;

        ProductItem productItem = new ProductItem(
            Product2Id = product.Id,
            LocationId = sourceLocation.Id,
            QuantityOnHand = 10
        );
        insert productItem;

        ProductRequestLineItem productRequestLineItem = new ProductRequestLineItem(
            ParentId = productRequest.Id,
            Product2Id = product.Id,
            QuantityRequested = 5
        );
        insert productRequestLineItem;

        AcctSeed__Billing_Format__c pdfFormat = new AcctSeed__Billing_Format__c(
            Name = 'Other',
            AcctSeed__Type__c = 'Billing',
            AcctSeed__Visualforce_PDF_Page__c = 'BillingProductPDF',
            AcctSeed__Default_Email_Template__c = 'Billing_Email_Template'
        );
        insert pdfFormat;

        AcctSeed__GL_Account__c glAccount = new AcctSeed__GL_Account__c(
            Name = 'Test GL Account',
            AcctSeed__Type__c = 'Expense',
            BalSheet_Type__c = '05Inventory',
            IncStmt_Type__c = '01Revenue, Net',
            AcctSeed__Bank__c = true
        );
        insert glAccount;

        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c(
            Name = 'Test Ledger',
            AcctSeed__Type__c = 'Transactional',
            AcctSeed__Billing_Activity_Statement_Format__c = pdfFormat.Id,
            AcctSeed__Billing_Outstanding_Statement_Format__c = pdfFormat.Id,
            AcctSeed__Default_Bank_Account__c = glAccount.Id,
            AcctSeed__Default_Billing_Format__c = pdfFormat.Id,
            AcctSeed__Default_Purchase_Order_Format__c = pdfFormat.Id,
            AcctSeed__Default_Packing_Slip_Format__c = pdfFormat.Id
        );
        insert ledger;

        AcctSeedERP__Purchase_Order__c purchaseOrder = new AcctSeedERP__Purchase_Order__c(
            AcctSeedERP__Vendor__c = vendor.Id,
            AcctSeedERP__Status__c = 'Open',
            AcctSeedERP__Order_Date__c = System.today(),
            AcctSeedERP__Type__c = 'Material',
            AcctSeedERP__Purchase_Order_Format__c = pdfFormat.Id,
            AcctSeedERP__Ledger__c = ledger.Id
        );
        insert purchaseOrder;

        AcctSeedERP__Purchase_Order_Line__c purchaseOrderLineItem = new AcctSeedERP__Purchase_Order_Line__c(
            AcctSeedERP__Purchase_Order__c = purchaseOrder.Id,
            AcctSeedERP__Product__c = product.Id,
            AcctSeedERP__Quantity__c = 1,
            AcctSeedERP__Unit_Price__c = 10.00
        );
        insert purchaseOrderLineItem;
    }
    
    @isTest
    static void getProductTransferRecordTypes() {
        Test.startTest();
        String jsonString = MassCreateProductTransferController.getProductTransferRecordTypes();
        Test.stopTest();

        System.assert(jsonString.contains('Internal Transfer'));
    }

    @isTest
    static void getProductRequest() {
        Test.startTest();
        ProductRequest productRequest = MassCreateProductTransferController.getProductRequest([SELECT Id FROM ProductRequest LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals('Atlanta', productRequest.ShipToCity);
    }

    @isTest
    static void getLocations() {
        Test.startTest();
        List<LookupSearchResult> results = MassCreateProductTransferController.getLocations('Test Destination', null);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM Location WHERE Name = 'Test Destination Location' LIMIT 1].Id, results[0].getId());
    }

    @isTest
    static void getVendors() {
        Test.startTest();
        List<LookupSearchResult> results = MassCreateProductTransferController.getVendors('Manufacturer', null);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM Account WHERE Name = 'Test Manufacturer' LIMIT 1].Id, results[0].getId());
    }

    @isTest
    static void getSourceProductItem() {
        Test.startTest();
        List<LookupSearchResult> results = MassCreateProductTransferController.getSourceProductItem('Test', null, [SELECT Id FROM Location WHERE Name = 'Test Source Location' LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM ProductItem LIMIT 1].Id, results[0].getId());
    }

    @isTest
    static void getvendorPOLineItems() {
        Test.startTest();
        List<LookupSearchResult> results = MassCreateProductTransferController.getVendorPOLineItems('Test Product', null, [SELECT Id FROM Account WHERE Name = 'Test Vendor Account' LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1].Id, results[0].getId());
    }

    @isTest
    static void getDefaultProductItem() {
        Schema.Location location = [SELECT Id FROM Location WHERE Name = 'Test Source Location' LIMIT 1];
        Product2 product = [SELECT Id FROM Product2 LIMIT 1];

        Test.startTest();
        ProductItem productItem = MassCreateProductTransferController.getDefaultProductItem(product.Id, location.Id);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM ProductItem LIMIT 1].Id, productItem.Id);
    }

    @isTest
    static void getDefaultVendorPOLineItem() {
        Account vendor = [SELECT Id FROM Account WHERE Name = 'Test Vendor Account' LIMIT 1];
        Product2 product = [SELECT Id FROM Product2 LIMIT 1];

        Test.startTest();
        AcctSeedERP__Purchase_Order_Line__c poLineItem = MassCreateProductTransferController.getDefaultVendorPOLineItem(product.Id, vendor.Id);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1].Id, poLineItem.Id);
    }

    @isTest
    static void getProductRequestLineItems() {
        Test.startTest();
        List<ProductRequestLineItem> lineItems = MassCreateProductTransferController.getProductRequestLineItems([SELECT Id FROM ProductRequest LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals([SELECT Id FROM ProductRequestLineItem LIMIT 1].Id, lineItems[0].Id);
    }

    @isTest
    static void createProductTransfers() {
        Id productRequestId = [SELECT Id FROM ProductRequest LIMIT 1].Id;
        Id productRequestLineItemId = [SELECT Id FROM ProductRequestLineItem LIMIT 1].Id;
        Map<String, Object> productRequestMap = new Map<String, Object> {
            'Id' => productRequestLineItemId,
            'RecordTypeId' => Schema.SObjectType.ProductTransfer.getRecordTypeInfosByName().get('Internal Transfer').getRecordTypeId(),
            'QuantityRequested' => 5,
            'Product2Id' => [SELECT Id FROM Product2 LIMIT 1].Id,
            'DestinationLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Destination Location' LIMIT 1].Id,
            'SourceLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Source Location' LIMIT 1].Id,
            'Shipping_Company__c' => 'Test Company',
            'Tracking_Number__c' => '123456789',
            'Tracking_URL__c' => 'www.google.com',
            'ExpectedPickupDate' => System.today(),
            'ShipToStreet' => '123 Main Street',
            'ShipToCity' => 'Atlanta',
            'ShipToState' => 'Georgia',
            'ShipToPostalCode' => '30303'
        };
        String productTransfersString = '['+JSON.serialize(productRequestMap)+']';

        Test.startTest();
        MassCreateProductTransferController.createProductTransfers(productRequestId, productTransfersString);
        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM ProductTransfer].size());
    }

    @isTest
    static void createProductTransfers_sourceProductItem() {
        Id productRequestId = [SELECT Id FROM ProductRequest LIMIT 1].Id;
        Id productRequestLineItemId = [SELECT Id FROM ProductRequestLineItem LIMIT 1].Id;
        Map<String, Object> productRequestMap = new Map<String, Object> {
            'Id' => productRequestLineItemId,
            'RecordTypeId' => Schema.SObjectType.ProductTransfer.getRecordTypeInfosByName().get('Internal Transfer').getRecordTypeId(),
            'QuantityRequested' => 5,
            'Product2Id' => [SELECT Id FROM Product2 LIMIT 1].Id,
            'SourceProductItemId' => [SELECT Id FROM ProductItem LIMIT 1].Id,
            'SourceProductItem' => new Map<String, Object> {
                'Product2' => new Map<String, Object> {
                    'Id' => [SELECT Product2Id FROM ProductItem LIMIT 1].Product2Id,
                    'Name' => [SELECT Product2.Name FROM ProductItem LIMIT 1].Product2.Name
                }
            },
            'DestinationLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Destination Location' LIMIT 1].Id,
            'SourceLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Source Location' LIMIT 1].Id,
            'Shipping_Company__c' => 'Test Company',
            'Tracking_Number__c' => '123456789',
            'Tracking_URL__c' => 'www.google.com',
            'ExpectedPickupDate' => System.today(),
            'ShipToStreet' => '123 Main Street',
            'ShipToCity' => 'Atlanta',
            'ShipToState' => 'Georgia',
            'ShipToPostalCode' => '30303'
        };
        String productTransfersString = '['+JSON.serialize(productRequestMap)+']';

        Test.startTest();
        MassCreateProductTransferController.createProductTransfers(productRequestId, productTransfersString);
        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM ProductTransfer].size());
    }

    @isTest
    static void createProductTransfers_vendorPOLine() {
        Id productRequestId = [SELECT Id FROM ProductRequest LIMIT 1].Id;
        Id productRequestLineItemId = [SELECT Id FROM ProductRequestLineItem LIMIT 1].Id;
        Map<String, Object> productRequestMap = new Map<String, Object> {
            'Id' => productRequestLineItemId,
            'RecordTypeId' => Schema.SObjectType.ProductTransfer.getRecordTypeInfosByName().get('Internal Transfer').getRecordTypeId(),
            'QuantityRequested' => 5,
            'Product2Id' => [SELECT Id FROM Product2 LIMIT 1].Id,
            'Vendor_PO_Line__c' => [SELECT Id FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1].Id,
            'Vendor_PO_Line__r' => new Map<String, Object> {
                'Product2' => new Map<String, Object> {
                    'Id' => [SELECT AcctSeedERP__Product__c FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1].AcctSeedERP__Product__c,
                    'Name' => [SELECT AcctSeedERP__Product__r.Name FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1].AcctSeedERP__Product__r.Name
                }
            },
            'DestinationLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Destination Location' LIMIT 1].Id,
            'SourceLocationId' => [SELECT Id FROM Location WHERE Name = 'Test Source Location' LIMIT 1].Id,
            'Shipping_Company__c' => 'Test Company',
            'Tracking_Number__c' => '123456789',
            'Tracking_URL__c' => 'www.google.com',
            'ExpectedPickupDate' => System.today(),
            'ShipToStreet' => '123 Main Street',
            'ShipToCity' => 'Atlanta',
            'ShipToState' => 'Georgia',
            'ShipToPostalCode' => '30303'
        };
        String productTransfersString = '['+JSON.serialize(productRequestMap)+']';

        Test.startTest();
        MassCreateProductTransferController.createProductTransfers(productRequestId, productTransfersString);
        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM ProductTransfer].size());
    }
}