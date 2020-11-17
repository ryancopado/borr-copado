public with sharing class MassCreateProductTransferController {
    @AuraEnabled (cacheable=true)
    public static String getProductTransferRecordTypes() {
        List<Schema.RecordTypeInfo> recordTypes = Schema.SObjectType.ProductTransfer.getRecordTypeInfos();
        List<Map<String, String>> recordTypeOptions = new List<Map<String, String>>();

        for (Schema.RecordTypeInfo recordType : recordTypes) {
            if (!recordType.isMaster()) {
                recordTypeOptions.add(new Map<String, String> {
                    'label' => recordType.getName(),
                    'value' => recordType.getRecordTypeId()
                });
            }
        }

        return JSON.serialize(recordTypeOptions);
    }

    @AuraEnabled(Cacheable=true)
    public static ProductRequest getProductRequest(String productRequestId) {
        return [SELECT Id, SourceLocationId, SourceLocation.Name, DestinationLocationId, DestinationLocation.Name, Vendor__c, Vendor__r.Name, ShipToStreet, ShipToCity, ShipToState, ShipToPostalCode FROM ProductRequest WHERE Id = :productRequestId];
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getLocations(String searchTerm, List<String> selectedIds) {
        searchTerm = '%' + searchTerm + '%';

        List<Schema.Location> locations = [SELECT Id, Name FROM Location WHERE Name LIKE :searchTerm LIMIT 5];

        List<LookupSearchResult> results = new List<LookupSearchResult>();

        String locationIcon = 'standard:location';
        for (Schema.Location location : locations) {
            results.add(
                new LookupSearchResult(
                    location.Id,
                    'Location',
                    locationIcon,
                    location.Name,
                    ''
                )
            );
        }

        return results;
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getVendors(String searchTerm, List<String> selectedIds) {
        searchTerm = '%' + searchTerm + '%';

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :searchTerm LIMIT 5];

        List<LookupSearchResult> results = new List<LookupSearchResult>();

        String accountIcon = 'standard:account';
        for (Account account : accounts) {
            results.add(
                new LookupSearchResult(
                    account.Id,
                    'Account',
                    accountIcon,
                    account.Name,
                    ''
                )
            );
        }

        return results;
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getSourceProductItem(String searchTerm, List<String> selectedIds, String locationId) {
        searchTerm = '%' + searchTerm + '%';

        List<ProductItem> productItems = [SELECT Id, Product2Id, Product2.Name FROM ProductItem WHERE Product2.Name LIKE :searchTerm AND LocationId = :locationId LIMIT 5];

        List<LookupSearchResult> results = new List<LookupSearchResult>();

        String productItemIcon = 'standard:product_item';

        for (ProductItem productItem : productItems) {
            results.add(
                new LookupSearchResult(
                    productItem.Id,
                    'ProductItem',
                    productItemIcon,
                    productItem.Product2.Name,
                    productItem.Product2.Id
                )
            );
        }

        return results;
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getVendorPOLineItems(String searchTerm, List<String> selectedIds, String locationId) {
        searchTerm = '%' + searchTerm + '%';

        List<AcctSeedERP__Purchase_Order_Line__c> purchaseOrderLineItems = [SELECT Id, AcctSeedERP__Product__c, AcctSeedERP__Product__r.Name FROM AcctSeedERP__Purchase_Order_Line__c WHERE AcctSeedERP__Product__r.Name LIKE :searchTerm AND PO_Line_Status__c != 'Closed' AND AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__c = :locationId LIMIT 5];

        List<LookupSearchResult> results = new List<LookupSearchResult>();

        String purchaseOrderLineItemIcon = 'standard:product';

        for (AcctSeedERP__Purchase_Order_Line__c purchaseOrderLineItem : purchaseOrderLineItems) {
            results.add(
                new LookupSearchResult(
                    purchaseOrderLineItem.Id,
                    'ProductItem',
                    purchaseOrderLineItemIcon,
                    purchaseOrderLineItem.AcctSeedERP__Product__r.Name,
                    purchaseOrderLineItem.AcctSeedERP__Product__c
                )
            );
        }

        return results;
    }

    @AuraEnabled
    public static ProductItem getDefaultProductItem(String productId, String locationId) {
        return [SELECT Id, Product2Id, Product2.Name FROM ProductItem WHERE Product2Id = :productId AND LocationId = :locationId LIMIT 1];
    }

    @AuraEnabled
    public static AcctSeedERP__Purchase_Order_Line__c getDefaultVendorPOLineItem(String productId, String vendorId) {
        return [SELECT Id, AcctSeedERP__Product__c, AcctSeedERP__Product__r.Name FROM AcctSeedERP__Purchase_Order_Line__c WHERE AcctSeedERP__Product__c =: productId AND AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__c = :vendorId AND PO_Line_Status__c != 'Closed' LIMIT 1];
    }

    @AuraEnabled(Cacheable=true)
    public static List<ProductRequestLineItem> getProductRequestLineItems(String productRequestId) {
        return [SELECT Id, QuantityRequested, Product2Id, Product2.Name FROM ProductRequestLineItem WHERE ParentId = :productRequestId AND Status != 'Fulfilled'];
        // return [SELECT Id, QuantityRequested, Product2Id, Product2.Name FROM ProductRequestLineItem WHERE ParentId = :productRequestId];
    }

    @AuraEnabled
    public static void createProductTransfers(String productRequestId, String productTransfersString) {
        List<ProductTransferWrapper> productTransferWrappers = (List<ProductTransferWrapper>) JSON.deserialize(productTransfersString.replaceAll('__c', '').replaceAll('__r', 'rrr').replace('AcctSeedERP__Productrrr', 'Product2'), List<ProductTransferWrapper>.class);
        List<ProductTransfer> productTransfers = new List<ProductTransfer>();
        for (ProductTransferWrapper tempProductTransferWrapper : productTransferWrappers) {
            productTransfers.add(tempProductTransferWrapper.createProductTransfer());
        }
        insert productTransfers;

        ProductRequest productRequest = [SELECT Id, Mass_Transfer_Alert__c FROM ProductRequest WHERE Id = :productRequestId];
        productRequest.Mass_Transfer_Alert__c = true;
        update productRequest;
    }

    public class ProductTransferWrapper {
        public String Id {get; set;}
        public Decimal QuantityRequested {get; set;}
        public String Product2Id {get; set;}
        public String DestinationLocationId {get; set;}
        public String RecordTypeId {get; set;}
        public String SourceLocationId {get; set;}
        public String Shipping_Company {get; set;}
        public String Tracking_Number {get; set;}
        public String Tracking_URL {get; set;}
        public Date ExpectedPickupDate {get; set;}
        public String ShipToStreet {get; set;}
        public String ShipToCity {get; set;}
        public String ShipToState {get; set;}
        public String ShipToPostalCode {get; set;}
        public String SourceProductItemId {get; set;}
        public SourceProductItemWrapper SourceProductItem {get; set;}
        public String Vendor_PO_Line {get; set;}
        public VendorPOLineWrapper Vendor_PO_Linerrr {get; set;}

        public ProductTransfer createProductTransfer() {
            if (this.SourceProductItemId != null) {
                return new ProductTransfer(
                    ProductRequestLineItemId = this.Id,
                    RecordTypeId = this.RecordTypeId,
                    QuantitySent = this.QuantityRequested,
                    Product2Id = this.SourceProductItem.Product2.Id,
                    SourceProductItemId = this.SourceProductItemId,
                    DestinationLocationId = this.DestinationLocationId,
                    SourceLocationId = this.SourceLocationId,
                    Shipping_Company__c = this.Shipping_Company,
                    Tracking_Number__c = this.Tracking_Number,
                    Tracking_URL__c = this.Tracking_URL,
                    ExpectedPickupDate = this.ExpectedPickupDate,
                    Ship_To_Street__c = this.ShipToStreet,
                    Ship_To_City__c = this.ShipToCity,
                    Ship_To_State__c = this.ShipToState,
                    Ship_To_Zip__c = this.ShipToPostalCode
                );
            } else if (this.Vendor_PO_Line != null) {
                return new ProductTransfer(
                    ProductRequestLineItemId = this.Id,
                    RecordTypeId = this.RecordTypeId,
                    QuantitySent = this.QuantityRequested,
                    Product2Id = this.Vendor_PO_Linerrr.Product2.Id,
                    Vendor_PO_Line__c = this.Vendor_PO_Line,
                    DestinationLocationId = this.DestinationLocationId,
                    SourceLocationId = this.SourceLocationId,
                    Shipping_Company__c = this.Shipping_Company,
                    Tracking_Number__c = this.Tracking_Number,
                    Tracking_URL__c = this.Tracking_URL,
                    ExpectedPickupDate = this.ExpectedPickupDate,
                    Ship_To_Street__c = this.ShipToStreet,
                    Ship_To_City__c = this.ShipToCity,
                    Ship_To_State__c = this.ShipToState,
                    Ship_To_Zip__c = this.ShipToPostalCode
                );
            } else {
                return new ProductTransfer(
                    ProductRequestLineItemId = this.Id,
                    RecordTypeId = this.RecordTypeId,
                    QuantitySent = this.QuantityRequested,
                    Product2Id = this.Product2Id,
                    DestinationLocationId = this.DestinationLocationId,
                    SourceLocationId = this.SourceLocationId,
                    Shipping_Company__c = this.Shipping_Company,
                    Tracking_Number__c = this.Tracking_Number,
                    Tracking_URL__c = this.Tracking_URL,
                    ExpectedPickupDate = this.ExpectedPickupDate,
                    Ship_To_Street__c = this.ShipToStreet,
                    Ship_To_City__c = this.ShipToCity,
                    Ship_To_State__c = this.ShipToState,
                    Ship_To_Zip__c = this.ShipToPostalCode
                );
            }
        }
    }

    public class SourceProductItemWrapper {
        public Product2Wrapper Product2 {get; set;}
    }

    public class VendorPOLineWrapper {
        public Product2Wrapper Product2 {get; set;}
    }

    public class Product2Wrapper {
        public String Id {get; set;}
        public String Name {get; set;}
    }
}