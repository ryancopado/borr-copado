public class WOChecklistController {
    
    public List<Checklist__c> ChkLstWO {get;set;}

    public workorderlineitem WOChklist {get;set;} 

    public workorderlineitem WO {get;set;} 
    
    public List<ContentDocumentLink> files = new List<ContentDocumentLink>();
    
    public WOChecklistController(ApexPages.StandardController controller) { 
        
        WO = (workorderlineitem)controller.getRecord();
        
        
        WOChklist = [select id , Checklist__c from workorderlineitem where id =:WO.id ];
        
        ChkLstWO = [select id,Name,RecordType.Name,Owner.Name,Thermalinspectnoanomallies__c,Asset__c,Work_Order_Line_Item__c,File_Image_URL__c,Comments__c ,Docmanufacturerserial__c,Nodamageetctomodules__c,Nopaintcorrodamage__c,DCwiringisproperlyroutedandsecured__c,DCconnectgoodcondnodamage__c from Checklist__c where id= :WOChklist.Checklist__c];
        if(ChkLstWO.size()>0)
        {
        Checklist__c checklist=new Checklist__c ();
        checklist=ChkLstWO.get(0);
        system.debug('CheckList Id' +ChkLstWO);
    }
        
        
        

    }
    
 /*   public List<ContentDocumentLink> getFiles() {
    Checklist__c checklist=new Checklist__c ();
        checklist=ChkLstWO.get(0);
    
     files  = [select ContentDocumentID, LinkedEntityId,ContentDocument.title,ContentDocument.OwnerId,ContentDocument.CreatedDate from ContentDocumentLink where LinkedEntityId = :checklist.id];
     if(files.size()>0)
     { 
     return files;
     } 
     else
     {
     return null;
     }
     } */
     
     Public PageReference redirectToNewPage()
     {
     String hostname = ApexPages.currentPage().getHeaders().get('Host');
       //String  instance = URL.getSalesforceBaseUrl().getHost().substringBefore('.');
     // system.debug('look' +instance);
         system.debug('look here' +hostname);
         
    //  String URL2  ='https://'+hostname+'/'+'/00Q/e?nooverride=1';
       Checklist__c checklist=new Checklist__c ();
        checklist=ChkLstWO.get(0);


     //String URL2 = 'https://bssitraining--training.cs90.my.salesforce.com/'+checklist.id+'?isdtp=vw';
        String URL2='https://' +hostname +'/' +checklist.id+'?isdtp=vw';
      pagereference pageref = new pagereference(URL2);
      pageref.setredirect(true);
      return pageref;
     
        }
    
 
    
}