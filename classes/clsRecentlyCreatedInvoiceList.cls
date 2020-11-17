public with sharing class clsRecentlyCreatedInvoiceList {

    public clsRecentlyCreatedInvoiceList(ApexPages.StandardSetController controller) {

    }


    public clsRecentlyCreatedInvoiceList(ApexPages.StandardController controller) {

    }


   


    public PageReference GoToRecentlyCreatedInvoiceList() {
       
        //PageReference PR=new PageReference('/a0D?fcf=00BV0000000PQPB'); //sandbox
        PageReference PR=new PageReference('/a0D?fcf=00B80000008FG0d');//production
        
        PR.setRedirect(True);
     
        return PR;
        
    }

}