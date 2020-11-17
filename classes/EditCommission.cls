public with sharing class EditCommission {

    /*Commission__C Commission;
    RecordType RecType;

    public EditCommission (ApexPages.StandardController controller) {
        List<RecordType> ListOfRecordType=new List<RecordType>();
        
        Commission=[Select id,RecordTypeId from Commission__C where id =: controller.getRecord().id];
        ListOfRecordType =[Select id,Name from RecordType where id =:Commission.RecordTypeId ];
        
        if (ListOfRecordType.size()>0)
            RecType=ListOfRecordType[0];
    }

    public PageReference CheckCommissionRecordType(){
    
        PageReference pageRef ;
        
        if (RecType!=NULL && RecType.Name=='Affiliates'){
             pageRef = new PageReference('/APEX/CommissionAffiliateEdit?id='+Commission.ID + '&RecordType='+ RecType.id );
              pageRef.setRedirect(true);
        }
         Else if (RecType!=NULL && RecType.Name!='Affiliates'){
            pageRef = new PageReference('/APEX/Commission_Edit?id='+Commission.ID+ '&RecordType='+ RecType.id );
              pageRef.setRedirect(true);
        }
        Else{
            pageRef = new PageReference('/APEX/Commission_Edit?id='+Commission.ID);
              pageRef.setRedirect(true);
        }
        return pageRef ;
    }*/
}