public class oppUpdates {
    public static void ownerUpdate(Map<Id, Opportunity> updatedOpps) {
        List<SFDC_Project__c> updatedProjects = new List<SFDC_Project__c>();
        for (SFDC_Project__c p : [SELECT EC__c, Opportunity__c FROM SFDC_Project__c WHERE Opportunity__c in :updatedOpps.keySet()]) {
            Opportunity parentOpportunity = updatedOpps.get(p.Opportunity__c);
            p.EC__c = parentOpportunity.OwnerId;       
            updatedProjects.add(p);
        }
        update updatedProjects;
    }
    
    public static void removeCommission(Map<Id, Opportunity> opps) {
        List<Commission__c> updatedComms = new List<Commission__c>();
        for (Commission__c comms : [select Percent__c from Commission__c where Opportunity__c in :opps.keySet()]) {            
            updatedComms.add(comms);
        }
        delete updatedComms;
    }
    
    public static void addCommission(Map<Id,Opportunity> opps) {
        Commission__c[] comm = new Commission__c[0];
        
        Map<Id, User> users = new Map<Id, User>([select Id, Name, ManagerId, Commission_Percentage__c from User]);
        
        Map<string,User> MapOfUser=new Map<string,User>();
        
        for (User CurrentUser:[select Id,Name,Commission_Percentage__c, ManagerId
                                     from User where Name = 'Matti Hirpa' or Name = 'Miles Hovis' or Name = 'Philip Hall']){
            MapOfUser.Put(CurrentUser.Name, CurrentUser);
        } 
        
        Map<ID,Opportunity> MapOfOpportunity=new Map<id,Opportunity>([Select id, Account.Branch__C from Opportunity
                                                                        Where id in :opps.KeySet()]);
        //User[] tandf = [select Id from User where Name = 'Matti Hirpa' or Name = 'Jon Sarno' or Name = 'Philip Hall'];
        //User[] tandf = [select Id from User where Name = 'Philip Hall'];
        Commission__c[] comms = [select User__c, Percent__c, Opportunity__c from Commission__c where Opportunity__c in :opps.keySet()];
        Map<Id, User> oppComms = new Map<Id, User>();   
        for (Opportunity o:opps.values()) {        
            oppComms.clear();
            id Userid=UserInfo.GetUserid();
            oppComms.put(o.Ownerid, users.get(o.Ownerid));
            //oppComms.put(users.get(tandf[0].Id).Id, users.get(tandf[0].Id));
            //oppComms.put(users.get(tandf[1].Id).Id, users.get(tandf[1].Id));
            //oppComms.put(users.get(tandf[2].Id).Id, users.get(tandf[2].Id));
            
            /*
            if(o.Account.Branch__c == 'XYZ' || o.Account.Branch__c == 'XYZ')
            Add Commision with define user and define commision
            */
            
            /*for (Integer m = 0; m < tandf.size(); m++) {
                oppComms.put(users.get(tandf[m].Id).Id, users.get(tandf[m].Id));
            }*/
            
            String Branch=MapOfOpportunity.Get(O.ID).Account.Branch__C;
            
            If(MapOfUser.ContainsKey('Philip Hall'))            
                oppComms.put(MapOfUser.Get('Philip Hall').Id, MapOfUser.Get('Philip Hall'));
            
            if(Branch == 'Boston' || Branch == 'Mid Atlantic'){
                If(MapOfUser.ContainsKey('Miles Hovis'))            
                    oppComms.put(MapOfUser.Get('Miles Hovis').Id, MapOfUser.Get('Miles Hovis'));
            }
            
            if(Branch == 'Berkeley' || Branch == 'San Diego' || Branch == 'Oakland' || Branch == 'Nor Cal' || Branch == 'So Cal'){
                If(MapOfUser.ContainsKey('Matti Hirpa'))            
                    oppComms.put(MapOfUser.Get('Matti Hirpa').Id, MapOfUser.Get('Matti Hirpa'));
            }
            
            if(users.containskey(Userid) && users.ContainsKey(users.get(Userid).ManagerId) && users.containsKey(users.get(users.get(Userid).ManagerId).Id)){
                oppComms.put(users.get(Userid).ManagerId, users.get(users.get(Userid).ManagerId));
            }
            if(users.containskey(Userid) && users.containsKey(users.get(Userid).ManagerId) && users.containsKey(users.get(users.get(Userid).ManagerId).ManagerId) && users.containsKey(users.get(users.get(users.get(Userid).ManagerId).ManagerId).Id)){
                oppComms.put(users.get(users.get(users.get(Userid).ManagerId).ManagerId).Id, users.get(users.get(users.get(Userid).ManagerId).ManagerId));
            }           
            if (comms.size() > 0) {
                for (Integer i = 0; i <comms.size(); i++) {
                    if (oppComms.containsKey(comms[i].User__c)) {
                        oppComms.remove(comms[i].User__c);                  
                    }
                }     
                List<User> result = new List<User>();
                result = oppComms.values();
                    
                for (Integer j = 0; j <result.size(); j++) {
                    if(result[j].Id==o.Ownerid && (result[j].Commission_Percentage__c==null || result[j].Commission_Percentage__c==0))
                        comm.add(new Commission__c(Opportunity__c = o.Id,
                        User__c = result[j].Id,
                        Automated__c = true,
                        Percent__c = 2));
                    else
                        comm.add(new Commission__c(Opportunity__c = o.Id,
                        User__c = result[j].Id,
                        Automated__c = true,
                        Percent__c = result[j].Commission_Percentage__c));
                }
            }
            if (comms.size() == 0) {
                List<User> result2 = new List<User>();
                result2 = oppComms.values();         
                for (Integer j = 0; j <result2.size(); j++) {
                    if(result2[j].Id==o.Ownerid  && (result2[j].Commission_Percentage__c==null || result2[j].Commission_Percentage__c==0))
                        comm.add(new Commission__c(Opportunity__c = o.Id,
                        User__c = result2[j].Id,
                        Automated__c = true,
                        Percent__c = 2));
                    else
                        comm.add(new Commission__c(Opportunity__c = o.Id,
                        User__c = result2[j].Id,
                        Automated__c = true,
                        Percent__c = result2[j].Commission_Percentage__c));
                }
            }
        }  
        insert comm;
    }
    
    public static void taxRateUpdate(Map<Id, Opportunity> oMap) {
        //The Tax Exemption Status field of the Opportunity record has just changed,
        //update the Tax Rate field on the associated Construction Requisitions
        
        //Get the associated Project, Construction Requisition, Account and Tax Rate records
        SFDC_Project__c[] proj = [select Id, Opportunity__c from SFDC_Project__c where Opportunity__c in:oMap.keySet()];
        Map<Id, SFDC_Project__c> pMap = new Map<Id, SFDC_Project__c>();
        for (Integer i=0; i<proj.size(); i++) {
            pMap.put(proj[i].Id, proj[i]);
        }
        if (proj.size() > 0) {
            Con_Req__c[] conreq = [select Id, Status__c, Tax_Rate__c, Project__c from Con_Req__c where Project__c in:pMap.keySet()];
            Map<Id, Con_Req__c> crMap = new Map<Id, Con_Req__c>();
            for (Integer j=0; j<conreq.size(); j++) {
                crMap.put(conreq[j].Id, conreq[j]);
            }
            if (conreq.size() > 0) {
                List<Id> aId = new List<Id>();
                for (Integer k=0; k<conreq.size(); k++) {
                    aId.add(oMap.get(pMap.get(conreq[k].Project__c).Opportunity__c).AccountId);
                }
                Account[] acc = [select Id, ShippingCity from Account where Id in:aId];
                Map<Id, Account> aMap = new Map<Id, Account>();
                List<String> sCity = new List<String>();
                for (Integer k=0; k<acc.size(); k++) {
                    aMap.put(acc[k].Id, acc[k]);
                    sCity.add(acc[k].ShippingCity);
                }
                Tax_Rate__c[] tr = [select Id, Tax_Rate__c, City__c from Tax_Rate__c where City__c in:sCity];
                Map<String, Tax_Rate__c> trMap = new Map<String, Tax_Rate__c>();
                for (Integer k=0; k<tr.size(); k++) {
                    trMap.put(tr[k].City__c, tr[k]);
                }
                List<Con_Req__c> conreqUp = new List<Con_Req__c>();
                for (Integer k=0; k<conreq.size(); k++) {
                    if (conreq[k].Status__c == 'New') {
                        if (oMap.get(pMap.get(conreq[k].Project__c).Opportunity__c).Tax_Exemption__c == 'Exempt') {
                            conreq[k].Tax_Rate__c = 0;
                        } else {
                            try {
                                conreq[k].Tax_Rate__c = trMap.get(aMap.get(oMap.get(pMap.get(conreq[k].Project__c).Opportunity__c).AccountId).ShippingCity).Tax_Rate__c;
                            } catch (Exception e) {
                                conreq[k].Tax_Rate__c = null;
                            }
                        }
                        conreqUp.add(conreq[k]);
                    }
                }
                if (conreqUp.size() > 0) {
                    update conreqUp;
                }
            }
        }
    }
    
	// Prevent recursive Opportunity trigger
	private static Boolean run = true;
	
	public static Boolean runOnce() {
		if (run) {
			run=false;
			return true;
		} else {
			return run;
		}
	}
    
    public static testMethod void NetAmountTest(){
        User owner = [select Id from User where Name = 'System User'];
        User other = [select Id from User where Name = 'Michael Hall']; 
        Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                         Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;
        Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System', System_Owner_Account__c = AccMake.Id, 
                                                CloseDate = System.today(),StageName = 'Prospecting', Financing__c = 'Cash'); insert OppMake;
        
        SFDC_Project__c[] project = new SFDC_Project__c[0];
        project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert project;
        
        OppMake.StageName = 'Contract Signed';
        update OppMake;
        
        Commission__c comm = [select Id from Commission__c where Opportunity__c = :OppMake.Id LIMIT 1];
        delete comm;
        
        OppMake.StageName = 'Prospecting';
        update OppMake;
        OppMake.StageName = 'Closed Lost';
        OppMake.Loss_Reason__c='Lost To Competition- Price';
        OppMake.Won_Loss_Explanation__c = 'Competition low-balled us';
        OppMake.Loss_Category__c = 'Other';
        update OppMake;
        //OppMake.OwnerId = other.Id;
        //update OppMake;
    }
}