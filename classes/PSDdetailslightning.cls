public with sharing class PSDdetailslightning {
    
    @AuraEnabled public List <PSD__c> presaledesign;
    @AuraEnabled public List <PSD_Revision__c> presaledesignrevision;    
    @AuraEnabled
    public static  List<PSD_Revision__c> Oppdisplay(Id OppId) 
    {
        List <PSD__c> presaledesign=new List<PSD__c>();
        List <PSD__c> PSDName=new List<PSD__c>();
        List <PSD_Revision__c> ListPSDrevision=new List<PSD_Revision__c>();
        List <PSD_Revision__c> presaledesignrevision=new List <PSD_Revision__c>() ;
        List <PSD_Revision__c> presalerevision1=new List<PSD_Revision__c>();
        presaledesign=[select id,Name from PSD__c where Opportunity__c=:OppId ORDER BY Name desc];
        PSD__c PSD =new PSD__c();
        PSD_Revision__c PSDrevison =new PSD_Revision__c();
        for(integer i=0;i<presaledesign.size();i++)
        {
            PSD=presaledesign.get(i);
            string psdname1 ='';
            string psdname2='';
            psdname1 = PSD.Name;
            system.debug('PSD List' +PSD.id);
            presaledesignrevision=[select id,Pre_Sales_Design__r.Name,Pre_Sales_Design__r.Site_Address2__c,Name,Revision_Status__c,Revision_Number__c,CreatedBy.Name,Completed_Design_Link__c,PSD_Apps_Engineer__c from PSD_Revision__c where Pre_Sales_Design__c=:PSD.id ORDER BY Pre_Sales_Design__r.Name];
            for(integer j=0;j<presaledesignrevision.size();j++)
            { 
                PSDrevison =presaledesignrevision.get(j);
                if(psdname1 ==psdrevison.Pre_Sales_Design__r.name && psdname2=='')
                {
                    psdrevison.Lightning_Text__c=psdrevison.Pre_Sales_Design__r.name +('-') + psdrevison.Pre_Sales_Design__r.Site_Address2__c ;
                    psdname2=psdrevison.Pre_Sales_Design__r.name +('-') + psdrevison.Pre_Sales_Design__r.Site_Address2__c;
                }
                system.debug('PSD Revision' +PSDrevison.id);
                presalerevision1.add(PSDrevison);
            }
        }
        system.debug('first loop size-->'  +presaledesign.size());
        system.debug('Inner loop size--->' +presalerevision1.size());
        for( integer k=0;k<presalerevision1.size();k++)
        {
            system.debug('look here List-->'  +presalerevision1.get(k));
        }
        return presalerevision1;
    }
}