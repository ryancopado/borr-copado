/**
 *	Test methods for po_Imbed.cls
 */
@isTest(SeeAllData=true)
private class Test_po_Imbed {
	
	static testMethod void testImbed() {
		PageReference pageRef = Page.po;
		Test.setCurrentPage(pageRef);
		
		AcctSeedERP__Purchase_Order__c po = new AcctSeedERP__Purchase_Order__c ();
		insert po;
		
		Con_Req__c co = new Con_Req__c(Purchase_Order2__c = po.Id, Status__c = 'Borrego Approved');
		insert co;
		
		Product2 pr = new Product2(Name = 'TestProduct', AcctSeed__Inventory_Type__c = 'Purchased', AcctSeed__Unit_Cost__c = 100);
		insert pr;
		
		AcctSeedERP__Purchase_Order_Line__c pol = new AcctSeedERP__Purchase_Order_Line__c(AcctSeedERP__Purchase_Order__c = po.Id, AcctSeedERP__Product__c = pr.Id, AcctSeedERP__Quantity__c = 1, Vendor_Description__c = ' This is the vendor description');
		insert pol;
		
		ApexPages.StandardController con = new ApexPages.StandardController(po);
		
		po_imbed ext = new po_imbed(con);
		ext.getPM();
		ext.getUser();
		ext.getpoClean();
		ext.getListOfPOs();
		ext.getListOfCOs();
	}
    
    static testMethod void testOMPrintPo() {
		PageReference pageRef = Page.OMVFtemplate;
		Test.setCurrentPage(pageRef);
		
		AcctSeedERP__Purchase_Order__c po = new AcctSeedERP__Purchase_Order__c ();
		insert po;
		
		Con_Req__c co = new Con_Req__c(Purchase_Order2__c = po.Id, Status__c = 'Borrego Approved');
		insert co;
		
		Product2 pr = new Product2(Name = 'TestProduct', AcctSeed__Inventory_Type__c = 'Purchased', AcctSeed__Unit_Cost__c = 100);
		insert pr;
		
		AcctSeedERP__Purchase_Order_Line__c pol = new AcctSeedERP__Purchase_Order_Line__c(AcctSeedERP__Purchase_Order__c = po.Id, AcctSeedERP__Product__c = pr.Id, AcctSeedERP__Quantity__c = 1, Vendor_Description__c = ' This is the vendor description');
		insert pol;
		
		ApexPages.StandardController con = new ApexPages.StandardController(po);
		
		OMPrintPO ext = new OMPrintPO(con);
		ext.getPM();
		ext.getUser();
		ext.getpoClean();
		ext.getListOfPOs();
		ext.getListOfCOs();
	}
}