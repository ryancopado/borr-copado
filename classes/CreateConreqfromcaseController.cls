public class CreateConreqfromcaseController {
    
    @Auraenabled
    public static List<Con_Req_Group__c> createconreq(Id caseid){
        List<Con_Req_Group__c>  newlist = new Con_Req_Group__c[]{};
        Con_Req_Group__c finallist = new  Con_Req_Group__c();    
        
        RecordType getrectypeid =[SELECT Id, Name FROM RecordType where Name ='Service Visit' AND SobjectType = 'Con_Req_Group__c'] ;
        string rectype = getrectypeid.id;
        
        case getcasefldvalues = [select id,CaseNumber,Project__c from case where id=:caseid];
        list<AcctSeedERP__Sales_Order__c> listsovalue = new list<AcctSeedERP__Sales_Order__c>();
        listsovalue =   [SELECT Id, Name, Project__c FROM AcctSeedERP__Sales_Order__c where Project__c = :getcasefldvalues.Project__c limit 1];
        if (listsovalue.size()>0){
            
            AcctSeedERP__Sales_Order__c  getsovalues  = new AcctSeedERP__Sales_Order__c();
            getsovalues = listsovalue.get(0); 
            string salesordername = getsovalues.id;
            
            AcctSeed__Project__c getprojectvalues =    [SELECT Id, Name, Owner.Name FROM AcctSeed__Project__c where Id =:getcasefldvalues.Project__c limit 1];
            string ownername = getprojectvalues.Owner.Name;
            
            
            
            finallist.Project__c = getcasefldvalues.Project__c;
            finallist.RecordTypeId = rectype;
            finallist.Sales_Order__c = salesordername;
          //  newlist.Ownerid = ownername;
            
            newlist.add(finallist);
            
            
        }
        system.debug('this is list-->' +newlist);
        return newlist;
        
    }
    
}