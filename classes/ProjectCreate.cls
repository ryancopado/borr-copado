public class ProjectCreate {
    
    // START : Added By Madan - Dec 1, 2017(only change Job Number if only Sales Segment changed FROM/TO ESD)
    public static Boolean isUpdate {get;set;}
    public static map<Id,AcctSeed__Project__c> oldMap {get;set;}
    
    
    private static Map<Id,AcctSeed__Accounting_Variable__c> mapSalesSegement {
        get {
            if(mapSalesSegement == null) {
                mapSalesSegement = new Map<Id,AcctSeed__Accounting_Variable__c>();
                mapSalesSegement = setSalesSegement();
                system.debug('this is mapsalesseg-->' +mapSalesSegement );
            }
            return mapSalesSegement;
        }
        set;
    }
    
   /* private static Map<Id,AcctSeed__Accounting_Variable__c> mapTeam {
        get {
            if(mapTeam == null) {
                mapTeam = new Map<Id,AcctSeed__Accounting_Variable__c>();
                mapTeam = setmapTeam();
                system.debug('this is mapT-->' +mapTeam );
            }
            return mapTeam;
        }
        set;
    }*/
    // END : Added By Madan - Dec 1, 2017(only change Job Number if only Sales Segment changed FROM/TO ESD)
    // ---------------------------------------------
    
    
    public static void createProjects(SFDC_Project__c[] projects){
        
    }
    
    public static void createProjects(AcctSeed__Project__c[] projects){
        Map<String,Branch__c> branch = setBranch();
        Set<Id> optIds = new Set<Id>();
        Set<Id> acctIds = new Set<Id>();
        Map<Id, Opportunity> oppmap = new Map<Id,Opportunity>();
        for (AcctSeed__Project__c p:projects) {
            optIds.add(p.AcctSeed__Opportunity__c);
        }
        Opportunity[] opp  = [select Id, OwnerId, Approximate_Install_Date__c,Utility_Company__c, 
                                Name, AccountId, Rebate_Assigned_To__c, Expected_Rebate__c, 
                                Type, StageName,Team__c,Record_Type_Name__c,Branch__r.Name from Opportunity where Id in :optIds];
                                //Type, StageName, Picasa_Album__c from Opportunity where Id in :optIds];
                                
        Opportunity oppvalues= new Opportunity();
        oppvalues=opp.get(0);
        string Team=oppvalues.Team__c;
        String recordtype=oppvalues.Record_Type_Name__c;
        system.debug('this is team' +team);
        system.debug('this is recordtype' +recordtype);
        for (Integer i = 0; i <opp.size(); i++) {
            oppmap.put(opp[i].Id, opp[i]);
            acctIds.add(opp[i].AccountId);
        }
        Map<Id, Account> acctmap = new Map<Id,Account>([SELECT Id, ShippingStreet,ShippingCity,ShippingState, Branch__c,
                                                                    ShippingPostalCode from Account where Id in :acctIds]);
        
        List<AcctSeed__Accounting_Variable__c> avList = new List<AcctSeed__Accounting_Variable__c>();
        avList = [select Id, Name, AcctSeed__Type__c, AcctSeed__Active__c from AcctSeed__Accounting_Variable__c 
                where AcctSeed__Type__c = 'GL Account Variable 3' and AcctSeed__Active__c = true];
        Map<String, AcctSeed__Accounting_Variable__c> avMap = new Map<String, AcctSeed__Accounting_Variable__c>();
        for (AcctSeed__Accounting_Variable__c av :avList) {
            avMap.put(av.Name, av);
        }
        Map<String, BranchToOpsDivision__c> btoMap = BranchToOpsDivision__c.getAll();
        Map<String, ROD__mdt> rodMap = new Map<String, ROD__mdt>();
        List<ROD__mdt> rodList = [select Id, Branch__c, UserId__c from ROD__mdt];
        for (ROD__mdt r :rodList) {
            rodMap.put(r.Branch__c, r);
        }
        
        Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        
        Map<Id,AcctSeed__Accounting_Variable__c> mapSalesSegement = setSalesSegement();
         //Map<Id,AcctSeed__Accounting_Variable__c> mapTeam = setmapTeam();
        //RecordType comm = [select Id from RecordType where Name = 'AS Commercial Project'];
        //RecordType pv = [select Id from RecordType where Name = 'AS PV Direct'];
        for (AcctSeed__Project__c p:projects) {
            if(oppmap.containsKey(p.AcctSeed__Opportunity__c)){
                if(oppmap.get(p.AcctSeed__Opportunity__c).StageName == 'Contract Signed'){
                    p.Overall_Project_Status__c = 'New';
                    if(oppmap.get(p.AcctSeed__Opportunity__c).Type != 'Consulting Services') {
                     //   p.Utility_Company__c = oppmap.get(p.AcctSeed__Opportunity__c).Utility_Company__c;
                        p.Rebate_Assigned_To__c = oppmap.get(p.AcctSeed__Opportunity__c).Rebate_Assigned_To__c;
                        p.Reserved__c = oppmap.get(p.AcctSeed__Opportunity__c).Expected_Rebate__c;
                        p.Name = oppmap.get(p.AcctSeed__Opportunity__c).Name;
                        p.SFDC_Project_Start_Date__c = oppmap.get(p.AcctSeed__Opportunity__c).Approximate_Install_Date__c;
    /*                    
                        p.Site_Street_Address__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingStreet;
                        p.Site_City__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingCity;
                        p.Site_State__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingState;
                        p.Site_Zip_Code__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingPostalCode;
    */
                        p.EC__c = oppmap.get(p.AcctSeed__Opportunity__c).OwnerId;
                        p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                        p.AcctSeed__Account__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Id;
                        //p.Branch__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Branch__c;
                        p.Branch__c =oppmap.get(p.AcctSeed__Opportunity__c).Branch__r.Name;
                        p.Ops_Division__c=Team;
                      //  p.Sales_Segment__c=oppvalues.Business_Unit__c;
                        system.debug('this is sales_seg1-->' +p.Sales_Segment__c);
                        // Added By Madan - July 27, 2017
                        String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
                        //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;
                        
                        //p.Job_Number__c = countP(p, branch.get(p.Branch__c),salesSegmentName);
                        p.Job_Number__c=countP1(p,Team,salesSegmentName);
                        //p.RecordTypeId = comm.Id;
                        //p.Picasa_Album__c = oppmap.get(p.AcctSeed__Opportunity__c).Picasa_Album__c;
                    }
                    if(oppmap.get(p.AcctSeed__Opportunity__c).Type == 'Consulting Services') {           
                        //p.Branch__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Branch__c;
                        p.Branch__c =oppmap.get(p.AcctSeed__Opportunity__c).Branch__r.Name;
                        p.AcctSeed__Account__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Id;
                        p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                        
                        // Added By Madan - July 27, 2017
                        String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
                        //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;
                        
                        //p.Job_Number__c = countP(p, branch.get(p.Branch__c),salesSegmentName);
                        p.Job_Number__c=countP1(p,Team,salesSegmentName);
                        p.Name = oppmap.get(p.AcctSeed__Opportunity__c).Name;
                        p.OwnerId = oppmap.get(p.AcctSeed__Opportunity__c).OwnerId;
                        p.Ops_Division__c=Team;
                         system.debug('this is sales_seg2-->' +p.Sales_Segment__c);
                      //  p.Sales_Segment__c=oppvalues.Business_Unit__c;
                        //p.RecordTypeId = pv.Id;
                    }
                    //update branch.values();
                    
                   system.debug('Branch update' +branch.values());
                }
                if(oppmap.get(p.AcctSeed__Opportunity__c).StageName != 'Contract Signed'){
                    if(oppmap.get(p.AcctSeed__Opportunity__c).Type == 'Consulting Services') {           
                        //p.Branch__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Branch__c;
                        p.Branch__c =oppmap.get(p.AcctSeed__Opportunity__c).Branch__r.Name;
                        p.AcctSeed__Account__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Id;
                        p.Name = oppmap.get(p.AcctSeed__Opportunity__c).Name;
                        p.OwnerId = oppmap.get(p.AcctSeed__Opportunity__c).OwnerId;
                        p.Ops_Division__c=Team;
                         system.debug('this is sales_seg3-->' +p.Sales_Segment__c);
                    //    p.Sales_Segment__c=oppvalues.Business_Unit__c;
    /*
                        p.Job_Number__c = countPC(p);
                        p.PC_Code__c = setPCS()+1;
    */
                        p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                        
                        // Added By Madan - July 27, 2017
                        String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
                        //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;
                        
                       // p.Job_Number__c = countP(p, branch.get(p.Branch__c),salesSegmentName);
                         p.Job_Number__c=countP1(p,Team,salesSegmentName);
                        //p.RecordTypeId = pv.Id;
                    }
                    if(oppmap.get(p.AcctSeed__Opportunity__c).Type != 'Consulting Services'){
    //                    p.Utility_Company__c = oppmap.get(p.AcctSeed__Opportunity__c).Utility_Company__c;
                        p.Rebate_Assigned_To__c = oppmap.get(p.AcctSeed__Opportunity__c).Rebate_Assigned_To__c;
                        p.Reserved__c = oppmap.get(p.AcctSeed__Opportunity__c).Expected_Rebate__c;
                        p.Name = oppmap.get(p.AcctSeed__Opportunity__c).Name;
                        p.SFDC_Project_Start_Date__c = oppmap.get(p.AcctSeed__Opportunity__c).Approximate_Install_Date__c;
    /*
                        p.Site_Street_Address__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingStreet;
                        p.Site_City__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingCity;
                        p.Site_State__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingState;
                        p.Site_Zip_Code__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).ShippingPostalCode;
    */
                        p.EC__c = oppmap.get(p.AcctSeed__Opportunity__c).OwnerId;
                        p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                        p.AcctSeed__Account__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Id;
                       // p.Branch__c = acctmap.get(oppmap.get(p.AcctSeed__Opportunity__c).AccountId).Branch__c;
                        p.Branch__c =oppmap.get(p.AcctSeed__Opportunity__c).Branch__r.Name;
                        p.Ops_Division__c=Team;
                         system.debug('this is sales_seg4-->' +p.Sales_Segment__c);
                         system.debug('this is ops' +p.Ops_Division__c);
                      //  p.Sales_Segment__c=oppvalues.Business_Unit__c;
    /*
                        p.Job_Number__c = countPC(p);
                        p.PC_Code__c = setPCS()+1;
    */
                        // Added By Madan - July 27, 2017
                        String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
                        //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;

                        //p.Job_Number__c = countP(p, branch.get(p.Branch__c),salesSegmentName);
                         p.Job_Number__c=countP1(p,Team,salesSegmentName);
                        //p.RecordTypeId = comm.Id;
                        //p.Picasa_Album__c = oppmap.get(p.AcctSeed__Opportunity__c).Picasa_Album__c;     
                    }
                 //update branch.values();
                 system.debug('Branch update' +branch.values());
                }
            }
            
            // Set the Ops Division and ROD fields based upon Branch
            if (String.isNotBlank(p.Branch__c)) {
                if (btoMap.containsKey(p.Branch__c)) {
              /*      if (avMap.containsKey(btoMap.get(p.Branch__c).Ops_Division__c)) {
                        if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() != 'AS Commercial Project') {
                          //  p.Ops_Division__c = avMap.get(btoMap.get(p.Branch__c).Ops_Division__c).Id;
                        }
                    }*/
                }
                
                if (rodMap.containsKey(p.Branch__c)) {
                    p.ROD__c = rodMap.get(p.Branch__c).UserId__c;
                }
            }
        }
    }
 
    public static void updatePType(Opportunity[] o) {
        
        //Opportunity records Job Type and/or Type fields have just been changed, update
        //the associated Project records Project Type field
        List<Id> oId = new List<Id>();
        Map<Id, Opportunity> oppmap = new Map<Id, Opportunity>();
        for (Integer i=0; i<o.size(); i++) {
            oId.add(o[i].Id);
            oppmap.put(o[i].Id, o[i]);
        }
        AcctSeed__Project__c[] pro = [select Id, Racking_Type__c, AcctSeed__Opportunity__c, RecordTypeId
                                from AcctSeed__Project__c where AcctSeed__Opportunity__c in :oId];
        //RecordType comm = [select Id from RecordType where Name = 'AS Commercial Project'];
        //RecordType pv = [select Id from RecordType where Name = 'AS PV Direct'];
        List<AcctSeed__Project__c> upP = new List<AcctSeed__Project__c>();
        for (AcctSeed__Project__c p:pro) {
            if(oppmap.get(p.AcctSeed__Opportunity__c).Type != 'Consulting Services') {
                p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                //p.RecordTypeId = comm.Id;
            } else {            
                p.Racking_Type__c = oppmap.get(p.AcctSeed__Opportunity__c).Type;
                //p.RecordTypeId = pv.Id;
            }
            upP.add(p);
        }
        if (upP.size() > 0) {
            update(upP);
        }
    }   
     
    public static void contractSigned(Id[] o) {
        
        //Change Project records from Pre Contract status to Contract Signed status.  Also change all
        //Project Job Numbers to non Pre Contract numbers
        AcctSeed__Project__c[] pro = [select Id, Pre_Contract__c, Overall_Project_Status__c, Job_Number__c, 
                                    Racking_Type__c,Branch__c, Number__c from AcctSeed__Project__c 
                                    where AcctSeed__Opportunity__c in :o];
        for (Integer i=0; i<pro.size(); i++) {
            pro[i].Pre_Contract__c = false;
            pro[i].Overall_Project_Status__c = 'New';
        }
        ConvertToNewJobNum(pro);
        update(pro);
    }
   
   public static void convertToNewJobNum(SFDC_Project__c[] projects) {
    
   }
   
    public static void convertToNewJobNum(AcctSeed__Project__c[] projects) {
    system.debug('Entering update');
        
        //Convert old (obsolete) pre-contract job numbers to non pre-contract job numbers
        List<AcctSeed__Project__c> pJN = new List<AcctSeed__Project__c>();
        Map<String,Branch__c> branch = setBranch();
        
        // Added By Madan - July 27, 2017
        Map<Id,AcctSeed__Accounting_Variable__c> mapSalesSegement = setSalesSegement();

        for (Integer i=0; i<projects.size(); i++) {
        system.debug('Entering for loop');
            if (projects[i].Branch__c != null) {
                // Added By Madan - July 27, 2017
                String salesSegmentName = (projects[i].Sales_Segment__c!=null)?mapSalesSegement.get(projects[i].Sales_Segment__c).Name:null;

                if (projects[i].Job_Number__c != null) {
                    if (projects[i].Job_Number__c.startsWith('950')) {
                       projects[i].Job_Number__c = countP(projects[i], branch.get(projects[i].Branch__c),salesSegmentName);
                        pJN.add(projects[i]);
                    }
                } else {
                  projects[i].Job_Number__c = countP(projects[i], branch.get(projects[i].Branch__c),salesSegmentName);
                  pJN.add(projects[i]);
                }
            }
          
        
        if (pJN.size() > 0) {
            //update branch.values();
            updateJobNum(pJN);
        }
    }
    }
    
    public static void updateJobNum(SFDC_Project__c[] pJN) {
        
    }
    
    public static void updateJobNum(AcctSeed__Project__c[] pJN) {
            
        //Change the Job Number of the Project record associated Construction
        //Requisitions and Purchase Orders
        List<Con_Req__c> upCR = new List<Con_Req__c>();
        List<Con_PO__c> upCPO = new List<Con_PO__c>();
        if (pJN.size() > 0) {
            //Get all the Construction Requisition records associated with the Project records
            List<Id> pId = new List<Id>();
            for(Integer i = 0; i<pJN.size(); i++) {
                pId.add(pJN[i].Id);
            }
            Con_Req__c[] con_req = [select Id, ASProject__c, Purchase_Order__c from Con_Req__c where ASProject__c in :pId];
        
            //Get all the Construction Purchase Order records associated with the Construction Requisition records
            List<Id> cpoId = new List<Id>();
            for(Integer i = 0; i<con_req.size(); i++) {
                cpoId.add(con_req[i].Purchase_Order__c);
            }
            Con_PO__c[] con_po = [select Id, Requisition_Number__c from Con_PO__c where Id in :cpoId];
            Map<Id, Con_PO__c> cpo = new Map<Id, Con_PO__c>();
            for (Integer i=0; i<con_po.size(); i++) {
                cpo.put(con_po[i].Id, con_po[i]);
            }
                                                                                                    
            for (AcctSeed__Project__c p:pJN) {
            
                //Set the Construction Requisition Job Number to the new Project Job Number.
                //Set the Construction Purchase Order Job Number (Requisition_Number__c) to the new Project Job Number
                //(note that some Construction POs are associated with multiple Construction Requisitions)
                for (Integer i=0; i<con_req.size(); i++) {
                    if (con_req[i].ASProject__c == p.Id) {
                        con_req[i].Job_Number__c = p.Job_Number__c;
                        upCR.add(con_req[i]);
                        if (con_req[i].Purchase_Order__c != null) {
                            if (cpo.get(con_req[i].Purchase_Order__c).Requisition_Number__c != p.Job_Number__c) {
                                cpo.get(con_req[i].Purchase_Order__c).Requisition_Number__c = p.Job_Number__c;
                                upCPO.add(cpo.get(con_req[i].Purchase_Order__c));
                            }
                        }
                    }
                }
            }
        }
        
        if (upCR.size() > 0) {
           update upCR;
        }
        if (upCPO.size() > 0) {
            update upCPO;
        }
    }
    
    public static void upNum(SFDC_Project__c[] project){
        
    }
    
    public static void upNum(AcctSeed__Project__c[] project){
        Map<String, Branch__c> branch = setBranch();
        Map<Id,AcctSeed__Accounting_Variable__c> mapSalesSegement = setSalesSegement();
         //Map<Id,AcctSeed__Accounting_Variable__c> mapTeam = setmapTeam();
        system.debug('this is project-->' +project);
        for(AcctSeed__Project__c p:project){
            // Added By Madan - July 27, 2017
            String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
            //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;
            system.debug('this is salesseg -->' +salesSegmentName);
            
            string team = p.Ops_Division__c;
            system.debug('look here for map value-->' +team);
            //p.Job_Number__c = countP(p, branch.get(p.Branch__c), salesSegmentName);
          // p.Job_Number__c=countP1(p,team,salesSegmentName);
        }
       // update branch.values();
        updateJobNum(project); 
    }
    
    public static void upJNum(SFDC_Project__c[] project){
        
    }
    
    public static void upJNum(AcctSeed__Project__c[] project){
        for(AcctSeed__Project__c p:project){
        String salesSegmentName = (p.Sales_Segment__c!=null)?mapSalesSegement.get(p.Sales_Segment__c).Name:null;
        //String TeamName = (p.Ops_Division__c !=null)?mapTeam.get(p.Ops_Division__c ).Name:null;
         string team = p.Ops_Division__c;
            system.debug('look here for map value-->' +team);
          //  p.Job_Number__c = countP1(p,branch.get(p.Branch__c),salesSegmentName); remember to uncomment seeing prod. data
         p.Job_Number__c = countP1(p,team,salesSegmentName); 
        }
        updateJobNum(project); 
    }
    
    private static Map<String, Branch__c> setBranch() {
    system.debug('this is called branch-->');
        Branch__c[] branches = [select Name, Number__c, PV_Number__c, DS_Number__c, DO_Number__c, SV_Number__c 
                                 from Branch__c];
        Map<String, Branch__c> nameBranch = new Map<String, Branch__c>();
        for(Branch__c b:branches){
            nameBranch.put(b.Name, b);
            if (b.SV_Number__c == null) {
                b.SV_Number__c = 0;
            }
        }
        system.debug('set branch' +nameBranch);
        return nameBranch;
    }
    
    //Added By Madan - July 27, 2017(To create Map of All Sales Segment)
    private static Map<Id,AcctSeed__Accounting_Variable__c> setSalesSegement() {
    system.debug('this is returning the salesseg query');
  //  system.debug('Mapping--->' +setSalesSegement());
        return new Map<Id,AcctSeed__Accounting_Variable__c>([Select Id, Name From AcctSeed__Accounting_Variable__c 
                                                                Where AcctSeed__Type__c='GL Account Variable 2']);
  // system.debug('After Mapping--->' +setSalesSegement());
    }
    
     /*private static Map<Id,AcctSeed__Accounting_Variable__c>  setmapTeam() {
    system.debug('this is returning the team query');
  //  system.debug('Mapping--->' +setSalesSegement());
        return new Map<Id,AcctSeed__Accounting_Variable__c>([Select Id, Name From AcctSeed__Accounting_Variable__c 
                                                                Where AcctSeed__Type__c='GL Account Variable 3']);
  // system.debug('After Mapping--->' +setSalesSegement());
    }*/
    
    private static Integer setPCS(){

        Double pcs = [select Id, PC_Code__c from AcctSeed__Project__c 
                        where PC_Code__c != null ORDER BY PC_Code__c DESC LIMIT 1].PC_Code__c;
        if(pcs != null){
            return pcs.IntValue();
        } else {
            return 0;                       
        }
    }
    private static String countPC(AcctSeed__Project__c p){
        Integer code;
        if(p.PC_Code__c != null){
            code = p.PC_Code__c.IntValue();
        } else {
            code = setPCS()+1;
        }
        String finalCode;
        String jobNumber;
   /*     if(code < 10){
            finalCode = '000'+code;
        } else if (code >= 10 && code < 100) {
            finalCode = '00'+code;
        } else if (code >= 100 && code < 1000) {
            finalCode = '0'+code;
        } else {
            finalCode = code+'';
        } 
        if(p.Branch__c == 'Berkeley'){
            jobNumber = '950-0028-'+finalCode;
        }
        if(p.Branch__c == 'Boston' || p.Branch__c == 'New England'){
            jobNumber = '950-0058-'+finalCode;
        }
        if(p.Branch__c == 'San Diego'){
            jobNumber = '950-0018-'+finalCode;
        }
        if(p.Branch__c == 'Mid Atlantic'){
            jobNumber = '950-0088-'+finalCode;
        }
        if(p.Branch__c == 'null'){
            jobNumber = 'Please enter the branch';
        }*/
        return jobNumber;
    }

    private static String countP(AcctSeed__Project__c p, Branch__c b, String salesSegmentName){
        string dummymethod;
        return dummymethod;    
    }
    
    
    ////adding new logic for Job number to look into the Accounting Variable 2 and 3,Team from opportuinity
    
    private static String countP1(AcctSeed__Project__c p,  String Team,  String salesSegmentName){
     
     String Jobnumber;
     String newprefix;
     String newjn;
      String oldTeamName;
      String TeamName ;
      Integer jobnum1;
     
     system.debug('this is new job number method recordtype-->' +salesSegmentName);
     system.debug('this is new job number method team-->' +team);
     List<AcctSeed__Accounting_Variable__c > acv1  = new list<AcctSeed__Accounting_Variable__c >();
     AcctSeed__Accounting_Variable__c accountvariable=new AcctSeed__Accounting_Variable__c();
   
      AcctSeed__Project__c projectjobnumber=new AcctSeed__Project__c();
      AcctSeed__Project__c projectjobnumber1=new AcctSeed__Project__c();
   List<AcctSeed__Project__c> jobnumberquery =new List<AcctSeed__Project__c>();
   List<AcctSeed__Project__c> jobnumberquery1 =new List<AcctSeed__Project__c>();
   
   acv1  = [select Name from AcctSeed__Accounting_Variable__c  where id=:Team];
   
   if (acv1.size()>0){
   accountvariable =acv1.get(0);
   }
    
      Map<Id,AcctSeed__Accounting_Variable__c> mapSalesSegement = setSalesSegement();
    
      
        Boolean isChangeJobNo = false;
        Boolean isChangeJobNo1 = false;
        
        system.debug('this is status-->' +isUpdate );
        //this is to set the update status when an ops_division or sales_segement is changes////
        //commented out based on the story not to change the job number when team or business unit changes//
       /* if(isUpdate == true) {
            AcctSeed__Project__c oldProj = oldMap.get(p.Id);
            system.debug('Old salessegment' +oldProj.Sales_Segment__c);
            system.debug('New salessegment' +p.Sales_Segment__c);
            system.debug('Old Team' +oldProj.Ops_Division__c);
            system.debug('New Team' +p.Ops_Division__c);
           
            if(oldProj.Ops_Division__c==null || oldProj.Ops_Division__c=='a1O80000008AeJsEAK')
            {
            oldTeamName=accountvariable.Name;
            TeamName =accountvariable.Name;
            }
            else
            {
             List<AcctSeed__Accounting_Variable__c > oldopsname  = new list<AcctSeed__Accounting_Variable__c >();
            oldopsname=[select Name from AcctSeed__Accounting_Variable__c  where id=:oldProj.Ops_Division__c];
            if(oldopsname.size()>0)
            {
          AcctSeed__Accounting_Variable__c oldopdivisionname=new AcctSeed__Accounting_Variable__c ();
            oldopdivisionname=oldopsname.get(0);
             oldTeamName=oldopdivisionname.Name;
             TeamName=accountvariable.Name;
            }
            }
            String oldSalesSegmentName = (p.Sales_Segment__c!=null && oldProj.Sales_Segment__c!=null)?mapSalesSegement.get(oldProj.Sales_Segment__c).Name:null;
            system.debug('this is oldsseg-->' +oldSalesSegmentName );
            system.debug('this is newsseg-->' +salesSegmentName );
                      
            if(TeamName !=oldTeamName)
            {
            isChangeJobNo1 = true;
            //String teamjobnumber=oldProj.job_number__c;
            jobnumberquery1=[select job_number__c, Ops_Division__c  from AcctSeed__Project__c where id=:oldProj.Id];
            
            }
            
            system.debug('old job number' +jobnumberquery1);
            system.debug('ischange' +  isChangeJobNo);
       
            if(salesSegmentName != oldSalesSegmentName)
            
            {
            
             isChangeJobNo = true;
            jobnumberquery=[select job_number__c, Ops_Division__c  from AcctSeed__Project__c where id=:oldProj.Id];
         
           system.debug('this is query-->' +jobnumberquery);
            
            }
           }*/
          //update status completes// 
           //if team changes//
            /*if(isChangeJobNo1 == true)
            {
            if(jobnumberquery1.size()>0)
          {
          projectjobnumber1=jobnumberquery1.get(0);
            String strJNteam;
            String finalteamJN;
            string teamjob=projectjobnumber1.job_number__c;
             strJNteam= teamjob.substringAfter('-'); 
            if(TeamName =='Dev - New England')
            {
            system.debug('Entering Dev');
            finalteamJN='105' +'-' +strJNteam;
            
            }
             if(TeamName =='Dev - Emerging')
            {
            finalteamJN='111' +'-' +strJNteam;
            
            }
            if(TeamName =='Dev - New York')
            {
            system.debug('Entering');
            finalteamJN='108' +'-' +strJNteam;
            
            }
             if(TeamName =='Dev- Overhead')
            {
            finalteamJN='100' +'-' +strJNteam;
            
            }
            /////////////EPC-START OPS DIVISION//////////
             if(TeamName =='EPC - Mid Atlantic')
            {
            finalteamJN='208' +'-' +strJNteam;
            
            }
            if(TeamName =='EPC - Midwest')
            {
            finalteamJN='207' +'-' +strJNteam;
            
            }
             if(TeamName =='EPC - New England')
            {
            finalteamJN='205' +'-' +strJNteam;
            
            }
            if(TeamName =='EPC - Overhead')
            {
            finalteamJN='200' +'-' +strJNteam;
            
            }
            if(TeamName =='EPC - West')
            {
            finalteamJN='201' +'-' +strJNteam;
            
            }
           ///////////////O&M-START OPS DIVISION//////////// 
            if(TeamName =='O&M - Mid Atlantic')
            {
            finalteamJN='808' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - Midwest')
            {
            finalteamJN='807' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - New England')
            {
            finalteamJN='805' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - Overhead')
            {
            finalteamJN='800' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - Southeast')
            {
            finalteamJN='810' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - Special Projects')
            {
            finalteamJN='803' +'-' +strJNteam;
            
            }
             if(TeamName =='O&M - West')
            {
            finalteamJN='801' +'-' +strJNteam;
            
            }
            
            
            
            Jobnumber=finalteamJN;
            }
            }*/
        // team change code complete//
            system.debug('final JN' +Jobnumber);
           system.debug('this is status2-->' +ischangejobno);
           // code when sales segment is update or changed//
          /*if(isChangeJobNo == true) {
           String strJN1;
           String strJN;
          if(jobnumberquery.size()>0)
          {
          projectjobnumber=jobnumberquery.get(0);
        //  strJN = projectjobnumber.job_number__c.substringAfter('-');
         string getjbno=projectjobnumber.job_number__c;
          //String strJN1 = projectjobnumber.job_number__c.substringbefore('-');
          if(salesSegmentName=='O&M')
          {

              strJN1 = '8' + getjbno.substring(1, 8);
          
             system.debug('this is the REPLACE NO-->' +strJN1);
           }
          if(salesSegmentName=='EPC')
          {
              strJN1 ='2' + getjbno.substring(1, 8);
              system.debug('this is the REPLACE NO-->' +strJN1);
          }
           if(salesSegmentName=='Development')
          {
              
              strJN1 = '1' + getjbno.substring(1, 8);
            system.debug('this is the REPLACE NO-->' +strJN1);
          }
          
          
          
         
          }
              Jobnumber=strJN1 ;
             
          }*/
        // returns the job number where the project is created ///
          //else if(isChangeJobNo == false && isChangeJobNo1==false)
         //{
          branch__c[] getjbnomax =[select id, number__c from branch__c  where number__c!=null order by number__c desc limit 1];
         Branch__c branchvalues = new Branch__c();
     
             if (getjbnomax .size() > 0){
             branchvalues=getjbnomax.get(0);
                }
          Double projectjobnumber12=branchvalues.number__c;
             if (Test.isRunningTest()) {
                projectjobnumber12 =0001;
                 }
        system.debug('pro num-->' +projectjobnumber12);
      jobnum1=Integer.ValueOf(projectjobnumber12)+1;
     system.debug('updated value' +jobnum1);
     if (!Test.isRunningTest()) {
      branch__c updatebranchvalue= [select id, number__c from branch__c  where name ='Bunit'  limit 1];
     
      updatebranchvalue.number__c=jobnum1;
      update updatebranchvalue;
      system.debug('update' +updatebranchvalue);
   
   }
      
         if(accountvariable.Name=='Dev - New England')
     {
     system.debug('dev newengland');
      newjn='105-' + jobnum1;
     }
     
     if(accountvariable.Name=='Dev - New York')
     {
     system.debug('dev newengland');
      newjn='108-' + jobnum1;
     }
     
     
     if(accountvariable.Name=='Dev - Emerging')
     {
      newjn='111-' + jobnum1;
      }
      if(accountvariable.Name=='Dev- Overhead')
     {
      newjn='100-' + jobnum1;
     }
     
     ///////////////EPC START //////////////////////
     
     
     if(accountvariable.Name=='EPC - Mid Atlantic')
     {
      newjn='208-' + jobnum1;
     }
     
     if(accountvariable.Name=='EPC - Midwest')
     {
      newjn='207-' + jobnum1;
     }
     
      if(accountvariable.Name=='EPC - New England')
     {
      newjn='205-' + jobnum1;
     }
     
      if(accountvariable.Name=='EPC - West')
     {
      newjn='201-' + jobnum1;
     }
     
     if(accountvariable.Name=='EPC - Overhead')
     {
      newjn='200-' + jobnum1;
     }
     ///////////////O&M LOGIC START //////////////////////
     
     
      if(accountvariable.Name=='O&M - Mid Atlantic')
     {
      newjn='808-' + jobnum1;
     }
     
      if(accountvariable.Name=='O&M - Midwest')
     {
      newjn='807-' + jobnum1;
     }
     
      if(accountvariable.Name=='O&M - New England')
     {
      newjn='805-' + jobnum1;
      }
      
       if(accountvariable.Name=='O&M - Overhead')
     {
      newjn='800-' + jobnum1;
     }
     
     if(accountvariable.Name=='O&M - Southeast')
     {
      newjn='810-' + jobnum1;
     }
      if(accountvariable.Name=='O&M - Special Projects')
     {
      newjn='803-' + jobnum1;
     }
      if(accountvariable.Name=='O&M - West')
     {
      newjn='801-' +  jobnum1;
     }
     Jobnumber=newjn;
     return Jobnumber;
     
        
        system.debug('this is the new jobnumber-->' + newjn);
        
     List<AcctSeed__Project__c> checkjobnumber=new List<AcctSeed__Project__c>();
      checkjobnumber=[select id from AcctSeed__Project__c where job_number__c=:newjn];
      system.debug('repeat1-->' +checkjobnumber.size());
      if(checkjobnumber.size()>0)
      {
       if(Test.isRunningTest()){
       newjn ='001-0001';
       }
       system.debug('repeat2 entering the if');
       String strJN = newjn.substringAfter('-');
       String strJN1 = newjn.substringbefore('-');
       Integer jobnum=Integer.ValueOf(strJN)+1; 
       Jobnumber=strJN1+'-'+jobnum;
        
      }
      else 
      {
      Jobnumber=newjn;
      }
      //} 
      
      system.debug('this is final-->' +Jobnumber);
      
      return Jobnumber;
      
     }
     
     ///////////Logic for Team/////////////////////
     
     
     
     
     
    
   public static void updateOpportunityChangeOrder(Map<Id, Opportunity> oppMap) {
        
        // Set Project field "Opportunity Change Orders" to the Change Orders field of the related Opportunity
        List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
        pList = [select Id, AcctSeed__Opportunity__c, Opportunity_Change_Orders__c from AcctSeed__Project__c where AcctSeed__Opportunity__c in :oppMap.keySet()];
        if (!pList.isEmpty()) {
            for (AcctSeed__Project__c p :pList) {
                if (oppMap.containsKey(p.AcctSeed__Opportunity__c)) {
                    p.Opportunity_Change_Orders__c = oppMap.get(p.AcctSeed__Opportunity__c).Change_Orders__c;
                }
            }
            update pList; 
        }
    }
    
    @isTest static void pCreateTest(){
     //   Branch__c[] b = [select Name, Number, PV_Number__c, DO_Number__c, DS_Number__c]
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
        insert a;
        
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),System_Owner_Account__c = a[0].Id,
                                        StageName = 'Prospecting', Amount = 500000, Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB', 
                                        Type = 'Turnkey System', RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
/*
'a1O5500000CTyCj',
'Contract Signed'
          get('Standard Opportunity')
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),
                                        Type = 'Consulting Services', StageName = 'Contract Signed', Amount = 500000));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),
                                        StageName = 'Project Awarded', Amount = 500000, Type = 'Turnkey System'));
        
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),
                                        Type= 'Consulting Services', StageName = 'Project Awarded', Amount = 500000, Type = 'Turnkey System'));
*/                                                                                                                                                      
        insert o;                                                                                                                       
        
        AcctSeed__Project__c[] projectBerk = new AcctSeed__Project__c[0];
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        //projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        //projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[3].Id));
        //projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[1].Id));
        //projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[2].Id));                                                            
           
        Test.StartTest();
    
        //insert projectBerk[3];
        //insert projectBerk[4];                                    
        insert projectBerk[0];

                
        //projectBerk[0].Branch__c = 'Boston';
        update projectBerk[0];
        projectBerk[0].Racking_Type__c = 'Smarts and Parts'; update projectBerk[0];
    
/*      
        projectBerk[0].Branch__c = 'San Diego'; update projectBerk[0];
        projectBerk[0].Branch__c = 'Mid Atlantic'; update projectBerk[0];
        projectBerk[1].Branch__c = 'San Diego'; update projectBerk[1];
        projectBerk[2].Branch__c = 'Mid Atlantic'; update projectBerk[2];
*/
        
        //Test updateProj()
/*      
        List<Id> opps = new List<Id>();
        opps.add(projectBerk[0].AcctSeed__Opportunity__c);
        projectBerk[0].Pre_Contract__c = true;
        projectBerk[0].Racking_Type__c = 'PV Direct';
        projectBerk[0].Branch__c = 'Berkeley';
        update projectBerk[0];
        updateProj(opps);
*/
/*      
        projectBerk[4].Pre_Contract__c = true;
        projectBerk[4].Racking_Type__c = 'PV Direct';
        projectBerk[4].Branch__c = 'Berkeley';
        update projectBerk[4];
        o[2].StageName = 'Contract Signed'; 
        update o[2];   
*/     
        Test.stopTest();                                                        
    }
    
    
    @isTest static void pUpdateTest1(){
     
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
        insert a;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = a[0].Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',
                StageName = 'Prospecting', Amount = 500000, Proposed_System_Size__c = 10000, Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        insert o;                                                                                                                       
        
        AcctSeed__Project__c[] projectBerk = new AcctSeed__Project__c[0];
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[3].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[1].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[2].Id));                                                          
           
        Test.StartTest();
    
        insert projectBerk[4];
                                    

/*              
        projectBerk[0].Branch__c = 'Boston'; update projectBerk[0];
        projectBerk[0].Racking_Type__c = 'Smarts and Parts'; update projectBerk[0];
    
        
        projectBerk[0].Branch__c = 'San Diego'; update projectBerk[0];
        projectBerk[0].Branch__c = 'Mid Atlantic'; update projectBerk[0];
        projectBerk[1].Branch__c = 'San Diego'; update projectBerk[1];
        projectBerk[2].Branch__c = 'Mid Atlantic'; update projectBerk[2];
*/
        
        //Test updateProj()
/*      
        List<Id> opps = new List<Id>();
        opps.add(projectBerk[0].AcctSeed__Opportunity__c);
        projectBerk[0].Pre_Contract__c = true;
        projectBerk[0].Racking_Type__c = 'PV Direct';
        projectBerk[0].Branch__c = 'Berkeley';
        update projectBerk[0];
        updateProj(opps);
*/

        projectBerk[4].Racking_Type__c = 'PV Direct';
        projectBerk[4].Branch__c = 'Berkeley';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Contract Signed'; 
        o[2].OwnerID=[Select id from User where isactive=true limit 1][0].ID;        
     //   update o[2];   
/*      
        projectBerk[4].Racking_Type__c = 'Turnkey System';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Project Awarded';  
        update o[2];
        o[2].StageName = 'Contract Signed'; 
        update o[2];
*/    
        Test.stopTest();                                                        
    }  
    
    @isTest static void pUpdateTest2(){
     
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
        insert a;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = a[0].Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        //Team__c='a1O2H00000D2iiiUAB'
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(),RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        insert o;                                                                                                                       
      //'Project Awarded'  
        AcctSeed__Project__c[] projectBerk = new AcctSeed__Project__c[0];
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[3].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[1].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[2].Id));                                                          
           
        Test.StartTest();
    
        insert projectBerk[4];
                                    

/*              
        projectBerk[0].Branch__c = 'Boston'; update projectBerk[0];
        projectBerk[0].Racking_Type__c = 'Smarts and Parts'; update projectBerk[0];
    
        
        projectBerk[0].Branch__c = 'San Diego'; update projectBerk[0];
        projectBerk[0].Branch__c = 'Mid Atlantic'; update projectBerk[0];
        projectBerk[1].Branch__c = 'San Diego'; update projectBerk[1];
        projectBerk[2].Branch__c = 'Mid Atlantic'; update projectBerk[2];
*/
        
        //Test updateProj()
/*      
        List<Id> opps = new List<Id>();
        opps.add(projectBerk[0].AcctSeed__Opportunity__c);
        projectBerk[0].Pre_Contract__c = true;
        projectBerk[0].Racking_Type__c = 'PV Direct';
        projectBerk[0].Branch__c = 'Berkeley';
        update projectBerk[0];
        updateProj(opps);
*/
    
        projectBerk[4].Racking_Type__c = 'Smarts and Parts';
        projectBerk[4].Branch__c = 'Berkeley';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].OwnerID=[Select id from User  where isactive=true  limit 1][0].ID;        
        o[2].StageName = 'Contract Signed'; 
       // update o[2];   
/*      
        projectBerk[4].Racking_Type__c = 'Design Only';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Project Awarded';  
        update o[2];
        o[2].StageName = 'Contract Signed'; 
        update o[2];
 */   
        Test.stopTest();                                                        
    }
    
    @isTest static void pUpdateTest3(){
     
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
        insert a;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = a[0].Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        insert o;                                                                                                                       
        
        AcctSeed__Project__c[] projectBerk = new AcctSeed__Project__c[0];
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[3].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[1].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[2].Id));                                                          
           
        Test.StartTest();
    
        insert projectBerk[4];
                                    

/*              
        projectBerk[0].Branch__c = 'Boston'; update projectBerk[0];
        projectBerk[0].Racking_Type__c = 'Smarts and Parts'; update projectBerk[0];
    
        
        projectBerk[0].Branch__c = 'San Diego'; update projectBerk[0];
        projectBerk[0].Branch__c = 'Mid Atlantic'; update projectBerk[0];
        projectBerk[1].Branch__c = 'San Diego'; update projectBerk[1];
        projectBerk[2].Branch__c = 'Mid Atlantic'; update projectBerk[2];
*/
        
        //Test updateProj()
/*      
        List<Id> opps = new List<Id>();
        opps.add(projectBerk[0].AcctSeed__Opportunity__c);
        projectBerk[0].Pre_Contract__c = true;
        projectBerk[0].Racking_Type__c = 'PV Direct';
        projectBerk[0].Branch__c = 'Berkeley';
        update projectBerk[0];
        updateProj(opps);
*/

        projectBerk[4].Racking_Type__c = 'Turnkey System';
        projectBerk[4].Branch__c = 'Berkeley';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];

        o[2].StageName = 'Contract Signed'; 
        o[2].OwnerID=[Select id from User  where isactive=true  limit 1][0].ID;
       // update o[2];   
        
/*      
        projectBerk[4].Racking_Type__c = 'Turnkey System';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Project Awarded';  
        update o[2];
        o[2].StageName = 'Contract Signed'; 
        update o[2];
 */   
        Test.stopTest();                                                        
    }
    
    @isTest static void pUpdateTest4(){
     
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
        insert a;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = a[0].Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                StageName = 'Prospecting', Amount = 500000, Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                Racking_Delivery_Date__c =system.now().Date(), Proposal_Submitted_Date__c = System.today(), Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c='a1O2H00000D2iiiUAB',
                Type = 'Consulting Services', StageName = 'Prospecting', Amount = 500000, Approximate_Install_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        insert o;                                                                                                                       
        
        AcctSeed__Project__c[] projectBerk = new AcctSeed__Project__c[0];
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[3].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[1].Id));
        projectBerk.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[2].Id));                                                          
           
        Test.StartTest();
    
        insert projectBerk[4];
                                    

/*              
        projectBerk[0].Branch__c = 'Boston'; update projectBerk[0];
        projectBerk[0].Racking_Type__c = 'Smarts and Parts'; update projectBerk[0];
    
        
        projectBerk[0].Branch__c = 'San Diego'; update projectBerk[0];
        projectBerk[0].Branch__c = 'Mid Atlantic'; update projectBerk[0];
        projectBerk[1].Branch__c = 'San Diego'; update projectBerk[1];
        projectBerk[2].Branch__c = 'Mid Atlantic'; update projectBerk[2];
*/
        
        //Test updateProj()
/*      
        List<Id> opps = new List<Id>();
        opps.add(projectBerk[0].AcctSeed__Opportunity__c);
        projectBerk[0].Pre_Contract__c = true;
        projectBerk[0].Racking_Type__c = 'PV Direct';
        projectBerk[0].Branch__c = 'Berkeley';
        update projectBerk[0];
        updateProj(opps);
*/
    
        projectBerk[4].Racking_Type__c = 'Design Only';
        projectBerk[4].Branch__c = 'Berkeley';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Contract Signed'; 
        o[2].OwnerID=[Select id from User  where isactive=true  limit 1][0].ID;        
       // update o[2];   
/*      
        projectBerk[4].Racking_Type__c = 'Design Only';
        projectBerk[4].Pre_Contract__c = true;
        update projectBerk[4];
        o[2].StageName = 'Project Awarded';  
        update o[2];
        o[2].StageName = 'Contract Signed'; 
        update o[2];
 */   
        Test.stopTest();                                                        
    }
    
 /*  @isTest static void pUpdateTest5(){
     
        Account[] a = new Account[0];
        a.add(new Account(Name = 'Test test', Branch__c = 'San Diego', ShippingCity = 'Park City')); 
        insert a;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = a[0].Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
        Opportunity[] o = new Opportunity[0];
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Consulting Services', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Design Only', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Direct Sales', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Service', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Sub-Contract Install', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Upgrades', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
        o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(),
                Racking_Delivery_Date__c =system.now().Date(), Proposed_System_Size__c = 10000, Expected_Rebate__c = 0, System_Owner__c = testContact.Id,
                StageName = 'Prospecting', Amount = 500000, Utility_Rate__c = 'N/A',Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, Financing__c = 'Cash', Team__c= 'a1O5500000CTyCj',
                Type = 'Smarts and Parts', Approximate_Install_Date__c = System.today(), 
                Proposal_Submitted_Date__c = System.today(), 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Development').getRecordTypeId()));
                
        insert o;
        
        String projectRtId = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosByName().get('O&M Project').getRecordTypeId();
        
        Site__c newSite = new Site__c(
                                Name = '123 Main Street',
                                Opportunity__c = o[0].Id
                            );
        insert newSite;
        
        AcctSeed__Project__c[] pro = new AcctSeed__Project__c[0];
        pro.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'San Diego',PC_Code__c = 10, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id,Overall_Project_Status__c='Design'));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2457',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Berkeley',PC_Code__c = 11, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id,Overall_Project_Status__c='Design'));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2458',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Corporate',PC_Code__c = 12, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
      pro.add(new AcctSeed__Project__c(Name = 'Knight - 2459',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Southeast',PC_Code__c = 13, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2460',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Puerto Rico',PC_Code__c = 14, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2461',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Boston',PC_Code__c = 15, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2462',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Mid Atlantic',PC_Code__c = 16, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
       pro.add(new AcctSeed__Project__c(Name = 'Knight - 2463',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Midwest',PC_Code__c = 17, RecordTypeId=projectRtId,EPC_Site__c=newSite.Id));
        
       //Test.StartTest();
    
        insert pro;
        
        Test.StartTest();
        
        pro[0].Job_Number__c = countPC(pro[0]);
        pro[0].PC_Code__c = setPCS()+1;
        update pro[0];
        
        o[0].Type = 'Service';
        update o[0];

        //pro[0].Branch__c = 'Mid Atlantic';
        //update pro[0];
        //o[0].StageName = 'Contract Signed'; 
        //update o[0];
        
        //-------------------------------
       pro[0].Branch__c = 'Berkeley';
        pro[0].AcctSeed__Opportunity__c = o[0].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[1].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[2].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[3].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[4].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[5].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[6].Id;
        update pro[0];
        
        pro[0].AcctSeed__Opportunity__c = o[7].Id;
        update pro[0];
        
        //----------
        pro[0].sales_segment__c = 'a1O80000008AeJE';
        pro[0].AcctSeed__Opportunity__c = o[0].Id;
        update pro[0];
        
        updateOpportunityChangeOrder(new Map<Id, Opportunity>{o[0].Id=>o[0]});
       upJNum(pro);
        convertToNewJobNum(pro);
        
        Test.stopTest(); 
        
        contractSigned(new List<Id>{o[0].Id});
        
        //------------------------------
        pro.add(new AcctSeed__Project__c(Name = 'Knight - 2463',AcctSeed__Opportunity__c = o[0].Id, Branch__c = 'Midwest',PC_Code__c = 18));
        pro[8].AcctSeed__Opportunity__c = null;
        insert pro[8];
        
        pro[8].AcctSeed__Opportunity__c = o[0].Id;
        update pro[8];
        
        
        //--------------
    }  */
}