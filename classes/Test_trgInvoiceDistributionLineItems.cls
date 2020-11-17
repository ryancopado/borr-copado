/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_trgInvoiceDistributionLineItems {

    static testMethod void TestDMLOperationOnInvoiceDistributionLineItems() {
        
        PO_Invoice__C POInvoice=[select id from PO_Invoice__C limit 1];
        Tax_Group__C TaxGroup =[Select id from Tax_Group__c limit 1];
        Con_po__c ConstructionPO=[Select id from Con_po__c limit 1] ;
        
        Invoice_Distribution_Line__C InvoiceDistributionLine=new Invoice_Distribution_Line__C();
        
        InvoiceDistributionLine.Construction_Purchase_Order1__c=ConstructionPO.id;
        InvoiceDistributionLine.POInvoice__c=POInvoice.id;
        InvoiceDistributionLine.Tax_Group__c=TaxGroup.id;
        InvoiceDistributionLine.Amount__c=3;
        InvoiceDistributionLine.Retention__c=5;
        InvoiceDistributionLine.Tax__c=6;
        InvoiceDistributionLine.Tax_Liability__c=5;
        
        insert InvoiceDistributionLine;
        
         Invoice_Distribution_Line__C InvoiceDistributionLine2=new Invoice_Distribution_Line__C();
        
        InvoiceDistributionLine2.Construction_Purchase_Order1__c=ConstructionPO.id;
        InvoiceDistributionLine2.POInvoice__c=POInvoice.id;
        InvoiceDistributionLine2.Tax_Group__c=TaxGroup.id;
        InvoiceDistributionLine2.Amount__c=3;
        InvoiceDistributionLine2.Retention__c=5;
        InvoiceDistributionLine2.Tax__c=6;
        InvoiceDistributionLine2.Tax_Liability__c=5;
        
        insert InvoiceDistributionLine2;
        
    }
}