public class prodUpdate {
    private Monthly_Production__c mPs;
    public prodUpdate(ApexPages.StandardController stdController) {
        this.mPs = (Monthly_Production__c)stdController.getRecord();
    }
    
    public List<Production_Update__c> puList;  // list of components to appear in the multi-line
    public PageReference reset() {
        puList = [select kWh_lifetime__c, Report_Date__c, Inverter__c, H_Total__c, Temperature__c, Irradiance__c from Production_Update__c
                           where Monthly_Production__c = :System.currentPageReference().getParameters().get('id')];
        return null;
    }             
    public List<Production_Update__c> getPUs() {
        if(puList == null) reset(); 
        return puList;
    }
    public void setComponents(List<Production_Update__c> PUs) {
        puList = PUs;
    }
    public PageReference add() {
        puList.add(New Production_Update__c(Monthly_Production__c = ApexPages.currentPage().getParameters().get('id')));
        return null;
    }
    public PageReference saves() {
        if (ApexPages.currentPage().getParameters().get('id') != null){
            Monthly_Production__c mp = [select Id from Monthly_Production__c where Id = :ApexPages.currentPage().getParameters().get('id')];
            update mp;         
            upsert puList;
        } else {
            insert mPs;
            for (Integer i = 0; i <puList.size(); i++) {
                puList[i].Monthly_Production__c = mPs.Id;
            }
            insert puList;
        }
        PageReference newcontact = new PageReference('/' + mPs.Id);
        newcontact.setRedirect(true);
        return newcontact;
    }
    public static testMethod void prodTest(){
    
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
    Contract c = new Contract(AccountId = acc.Id); insert c;
    Monthly_Production__c mp = new Monthly_Production__c(Month__c = 'January'); insert mp;
    
   List<Asset> LA = [select Id from Asset LIMIT 1];
    Asset a;
    
    IF(LA!=null && LA.Size()>0)
      a=LA[0];
    /*   
      Opportunity Opp=new Opportunity(Name = 'Test Opportunity',StageName='Contract Signed',CloseDate=System.today() ); Insert Opp;
    Product2 P=[SELECT ID FROM PRODUCT2 WHERE Family='Inverters' LIMIT 1];
    Asset a =new Asset();
    a.Account=acc;
    a.Name = 'Test Asset';
    a.Opportunity__c=Opp.ID;
    a.Product2=P ;
    Insert a; */
    
    List<Production_Update__c> PUs = new List<Production_Update__c>();
     IF (a!=null){
        Production_Update__c PU= new Production_Update__c( kWh_lifetime__c = 1000, Report_Date__c = System.today(), Monthly_Production__c = mp.Id);
   
        PU.Inverter__c = a.Id;
        PUs.add(PU);
        }

        
    PageReference pageRef = Page.contractReq;
        Test.setCurrentPage(pageRef);
        
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(new Monthly_Production__c());
        prodUpdate ext = new prodUpdate(con);
        
        ext = new prodUpdate(con);  
        //Call all methods on New page 
        ext.setComponents(PUs);
        ext.getPUs();
        PageReference result = ext.saves();
        PageReference result1 = ext.add();
        PageReference result2 = ext.reset();
        
        ApexPages.currentPage().getParameters().put('id', mp.Id);
        ext = new prodUpdate(con);  
        //Call all methods on New page 
        ext.setComponents(PUs);
        ext.getPUs();
        PageReference result4 = ext.add();
    //    PageReference result3 = ext.saves();     
        PageReference result5 = ext.reset(); 
    }
}