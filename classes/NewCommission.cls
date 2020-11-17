public with sharing class NewCommission {
/*
    Commission__C Commission;
    RecordType RecType;

    public NewCommission(ApexPages.StandardController controller) {
    
        Commission=new Commission__C ();
        
       
    }

    public PageReference CreateNewCommission(){
    
        PageReference pageRef ;
        pageRef = new PageReference('/APEX/Commission_New');
        pageRef.setRedirect(true);
        return pageRef ;
    }
    
     public PageReference CreateNewAffiliate(){
    
        PageReference pageRef ;
        
       
             RecType=[Select id,Name from RecordType where Name= 'Affiliates' ];
             pageRef = new PageReference('/APEX/CommissionAffiliateNew');
             pageRef.setRedirect(true);
             Commission.recordtypeid=RecType.id;
        
        return pageRef ;
    }*/
    
    /* Commission__C Commission;
    RecordType RecType;
    ID Opp;
    public NewCommission (ApexPages.StandardController controller) {
        List<RecordType> ListOfRecordType=new List<RecordType>();
        
        Commission=(Commission__C )controller.getRecord();
        ListOfRecordType =[Select id,Name from RecordType where id =:Commission.RecordTypeId ];
        Opp=Commission.Opportunity__C;
        
        if (ListOfRecordType.size()>0)
            RecType=ListOfRecordType[0];
    }

    public PageReference CheckCommissionRecordType(){
    
        PageReference pageRef ;
        
        if (RecType!=NULL && RecType.Name=='Affiliates'){
             pageRef = new PageReference('/APEX/CommissionAffiliateNew?RecordType='+RecType.Id+'&'+'oid='+ Opp );
              pageRef.setRedirect(true);
        }
        Else{
            IF(RecType !=null)
                pageRef = new PageReference('/APEX/Commission_New?RecordType='+RecType.Id+'&'+'oid='+ Opp );
            else
                pageRef = new PageReference('/APEX/Commission_New?oid='+ Opp );            
              
              pageRef.setRedirect(true);
        }
        return pageRef ;
    }*/
    
}