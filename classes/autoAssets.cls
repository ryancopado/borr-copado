public with sharing class autoAssets {
    /*
    public static void checkAssets() {
        
        //Find all Projects that either need to have Asset records created or
        //that need to have the warranty date of existing Asset records updated.
        AcctSeed__Project__c[] pro = [select Id, AcctSeed__Opportunity__c, PTO_Date__c, Create_Assets__c, Warranty_Date__c
                from AcctSeed__Project__c where Create_Assets__c =: true or Warranty_Date__c =: true];
        
        List<AcctSeed__Project__c> caPro = new List<AcctSeed__Project__c>();
        List<AcctSeed__Project__c> wdPro = new List<AcctSeed__Project__c>();
        for (Integer i=0; i<pro.size(); i++) {
            if (pro[i].Create_Assets__c == true) {
                pro[i].Create_Assets__c = false;
                pro[i].Warranty_Date__c = false;
                caPro.add(pro[i]);
            }
            if (pro[i].Warranty_Date__c == true) {
                pro[i].Warranty_Date__c = false;
                wdPro.add(pro[i]);
            }
        }
        
        if (caPro.size() > 0) {
            createAssets(caPro);
        }
        if (wdPro.size() > 0) {
            assetWarranty(wdPro);
        }
        if (pro.size() > 0) {
            update(pro);
        }
    }
    */
    /*
    public static void createAssets(SFDC_Project__c[] pro) {
    	
    }
    */
    /*
	public static void createAssets(AcctSeed__Project__c[] pro) {
	*/	
		/*
		 *	Create Asset records for Accounts associated with Opportunities that
		 *	are associated with Projects with Project Products where the 
		 *	Interconnection Status field of the Project and has just been changed to
		 * "Permission to Operate" (see trigger ptoReceived).
		 *
		 */
		/*
		//Get the Opportunity, Project Products, and Account records
		List<Contract> ListOfContract=[Select ASProject__c,id from Contract where ASProject__c in :pro];
		List<Asset> ListOfAssets=[Select  id, Opportunity__c,Product2Id,Name  from Asset where Contract__r.ASProject__c in :pro];
		Map<id,Asset> MapOfAssets = new Map<id,Asset>();
		Map<string,Asset> TempMapOfAssets = new Map<string,Asset>();
                
        for (Asset Asset:ListOfAssets) {
            MapOfAssets.put(Asset.Product2Id, Asset);
            TempMapOfAssets.PUT(Asset.Name, Asset);
        }        
        
        Map<id,Contract> MapOfContract = new Map<id,Contract>();
        for (Contract Contract :ListOfContract) {
            MapOfContract.put(Contract.ASProject__c, Contract);
        }
        
        List<Id> oppId = new List<Id>();
        List<Id> pIds = new List<Id>();
        for (Integer i=0; i<pro.size(); i++) {
            oppId.add(pro[i].AcctSeed__Opportunity__c);
            pIds.add(pro[i].Id);
        }
        Opportunity[] opp = [select Id, AccountId, Type, StageName from Opportunity where Id in:oppId];
        List<Id> accId = new List<Id>();
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        for (Integer i=0; i<opp.size(); i++) {
            accId.add(opp[i].AccountId);
            oppMap.put(opp[i].Id, opp[i]);
        }
        Account[] acc = [select Id, RecordTypeId from Account where Id in:accId];
        Project_Products__c[] projProds = [select Id, Project__c, Product__c, Quantity__c, Site__c from Project_Products__c 
        		where Project__c in :pIds];
		List<Id> p2Id = new List<Id>();
		for (Project_Products__c p :projProds) {
			p2Id.add(p.Product__c);
		}
		
        Product2[] p2 = [select Id, RecordTypeId from Product2 where Id in:p2Id];
        Map<Id, Product2> p2Map = new Map<Id, Product2>();
        for (Integer i=0; i<p2.size(); i++) {
            p2Map.put(p2[i].Id, p2[i]);
        }
        
        system.debug('*****autoAssets p2Map.size = ' + p2Map.size());
        
        //Get the RecordType records for each Account and each Product
        List<Id> rtId = new List<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        for (Integer i=0; i<acc.size(); i++) {
            rtId.add(acc[i].RecordTypeId);
            accMap.put(acc[i].Id, acc[i]);
        }
        for (Integer i=0; i<p2.size(); i++) {
            rtId.add(p2[i].RecordTypeId);
        }
        RecordType[] rt = [select Id, Name from RecordType where Id in:rtId];
        Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
        for (Integer i=0; i<rt.size(); i++) {
            rtMap.put(rt[i].Id, rt[i]);
        }
        
        system.debug('*****autoAssets rtMap.size = ' + rtMap.size());
        
		//Create new Asset records as appropriate
		Asset[] assets = new Asset[0];
		for (Integer p=0; p<pro.size(); p++) {
            
			//Verify Opportunity StageName fields
			if (oppMap.get(pro[p].AcctSeed__Opportunity__c).Type == 'Turnkey System') {
				
				//Verify Account record RecordType field
				if (rtMap.get(accMap.get(oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId).RecordTypeId).Name == 'Customer') {
					
					//Create an Asset for each Project Product that is of type Inverter.
                    Integer InverterNumber = 1;
                    boolean solarInsert = false;
                    boolean inverterInsert = false;
                    boolean DASInsert = false;
                    boolean MiscellaneousInsert = false;
                    boolean OtherAssetsInsert=false;
					
					for (Integer i=0; i<projProds.size(); i++) {
						InverterNumber = 1;
						
						if (projProds[i].Project__c == pro[p].Id) {
							
							system.debug('*****autoAssets projProds[i].Product__c = ' + projProds[i].Product__c);
							system.debug('*****autoAssets p2Map.containsKey(projProds[i].Product__c) = ' + p2Map.containsKey(projProds[i].Product__c));
							
							if (rtMap.get(p2Map.get(projProds[i].Product__c).RecordTypeId).Name == 'Inverter') {
								
								for (Integer q=0; q<projProds[i].Quantity__c; q++) {
									system.debug('*****createAssets In Quantity Loop!!!' + rtMap.get(p2Map.get(projProds[i].Product__c).RecordTypeId).Name);
									
									if (MapOfAssets.get(projProds[i].Product__c) == null) {
										system.debug('*****createAssets existing asset not found, create new');
										
										Asset Asset = new Asset();
										if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
											Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
										}
										
										if (MapOfContract.ContainsKey(pro[p].id)) {
											Asset.Contract__c=MapOfContract.get(pro[p].id).id;
										}
										Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
										Asset.Auto_Create__c = true;
										Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
										Asset.Name = rtMap.get(p2Map.get(projProds[i].Product__c).RecordTypeId).Name + ' ' + InverterNumber;
										Asset.Product2Id = projProds[i].Product__c;
										Asset.Site__c = projProds[i].Site__c;
										Asset.Inverter_Number__c = InverterNumber;
										assets.add(Asset);
										
										string RecordTypeName=rtMap.get(p2Map.get(projProds[i].Product__c).RecordTypeId).Name;
										if (RecordTypeName == 'Inverter') {
											InverterInsert = true;
										} else {
											if (RecordTypeName == 'Solar Module') {
												SolarInsert = true;
											} else {
												if (RecordTypeName == 'DAS') {
													DASInsert = true;
												} else {
													if (RecordTypeName == 'Miscellaneous') {
														MiscellaneousInsert = true;
													} else {
														OtherAssetsInsert= true;
													}
												}
											}
										}
									}                                                     
									InverterNumber++;
								}
							}
						}
					}
					
					Asset DasAsset;
					if (TempMapOfAssets.ContainsKey('DAS 1')) {
						DasAsset = TempMapOfAssets.get('DAS 1');
					}
					
					Asset SMAsset;
					if (TempMapOfAssets.ContainsKey('Solar Module 1')) {
						SMAsset = TempMapOfAssets.get('Solar Module 1');
					}
					
					Asset INVAsset;
					if (TempMapOfAssets.ContainsKey('Inverter 1')) {
						INVAsset = TempMapOfAssets.get('Inverter 1');
					}
					
					Asset MiscellaneousAsset;
					if (TempMapOfAssets.ContainsKey('Other equipment')) {
						MiscellaneousAsset = TempMapOfAssets.get('Other equipment');
					}
					
					Asset OtherAsset;
					if (TempMapOfAssets.ContainsKey('Electrical Material')) {
						OtherAsset = TempMapOfAssets.get('Electrical Material');
					}
					
					if ((!OtherAssetsInsert) && OtherAsset == null) {
						Asset Asset =new Asset();
						Id prdID = [select Id from Product2 where Name = 'Electrical Material' limit 1].id;
						
						if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
							Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
						}
						if (MapOfContract.ContainsKey(pro[p].Id)) {
							Asset.Contract__c = MapOfContract.get(pro[p].Id).Id;
						}
						Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
						Asset.Auto_Create__c = true;
						Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
						Asset.Name = 'Electrical Material';
						Asset.Product2Id = prdID;
						Asset.Inverter_Number__c = InverterNumber;
						assets.add(Asset);
						TempMapOfAssets.put(Asset.name, Asset);
					}    
					
					if ((!DASInsert) && DasAsset == null) {
						Asset Asset = new Asset();
						Id prdID = [select Id from Product2 where Name = 'Demo DAS Product' limit 1].id;
						
						if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
							Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
						}
						if (MapOfContract.ContainsKey(pro[p].Id)) {
							Asset.Contract__c = MapOfContract.get(pro[p].Id).Id;
						}
						Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
						Asset.Auto_Create__c = true;
						Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
						Asset.Name = 'DAS 1';
						Asset.Product2Id = prdID;
						Asset.Inverter_Number__c = InverterNumber;
						assets.add(Asset);
						TempMapOfAssets.put(Asset.name,Asset);
					}
					
					if ((!SolarInsert) && SMAsset == null) {
						Asset Asset =new Asset();
						Id prdID = [select Id from Product2 where Name = 'Demo Module Product' limit 1].Id;
						
						if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
							Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
						}
						if (MapOfContract.ContainsKey(pro[p].Id)) {
							Asset.Contract__c = MapOfContract.get(pro[p].Id).Id;
						}
						Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
						Asset.Auto_Create__c = true;
						Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
						Asset.Name = 'Solar Module 1';
						Asset.Product2Id = prdID;
						Asset.Inverter_Number__c = InverterNumber;
						assets.add(Asset);
						TempMapOfAssets.put(Asset.name,Asset);
					}
					
					if ((!InverterInsert) && INVAsset == null) {
						Asset Asset = new Asset();
						Id prdID = [select Id from Product2 where Name = 'Demo Inverter Product' limit 1].Id;
						
						if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
							Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
						}
						if (MapOfContract.ContainsKey(pro[p].Id)) {
							Asset.Contract__c = MapOfContract.get(pro[p].Id).Id;
						}
						Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
						Asset.Auto_Create__c = true;
						Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
						Asset.Name = 'Inverter 1';
						Asset.Product2Id = prdID;
						Asset.Inverter_Number__c = InverterNumber;
						assets.add(Asset);
						TempMapOfAssets.put(Asset.name,Asset);
					}
					
					if ((!MiscellaneousInsert) && MiscellaneousAsset == null) {
						Asset Asset = new Asset();
						Id prdID = [select Id from Product2 where Name = 'Miscellaneous' limit 1].Id;
						
						if (oppMap.ContainsKey(pro[p].AcctSeed__Opportunity__c)) {
							Asset.AccountId = oppMap.get(pro[p].AcctSeed__Opportunity__c).AccountId;
						}
						if (MapOfContract.ContainsKey(pro[p].Id)) {
							Asset.Contract__c = MapOfContract.get(pro[p].Id).Id;
						}
						Asset.Opportunity__c = pro[p].AcctSeed__Opportunity__c;
						Asset.Auto_Create__c = true;
						Asset.Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
						Asset.Name = 'Other equipment';
						Asset.Product2Id = prdID;
						Asset.Inverter_Number__c = InverterNumber;
						assets.add(Asset);
						TempMapOfAssets.put(Asset.name,Asset);                              
					}
				}
			}
		}
		
		if (assets.size() > 0) {
			system.debug('*****createAssets insert ' + assets.size() + ' assets');
			insert assets;
		}
	}
    */
    /*
     public static void assetWarranty(SFDC_Project__c[] pro) {
     	
     }
    */
    /*
    public static void assetWarranty(AcctSeed__Project__c[] pro) {
        
        //The Project record Permission To Operate date has changed, update the
        //Product Warranty Start Date for all associated Asset records.
        List<Id> oppId = new List<Id>();
        for (Integer i=0; i<pro.size(); i++) {
            oppId.add(pro[i].AcctSeed__Opportunity__c);
        }
        Asset[] assets = [select Id, Opportunity__c, Product2Id, Product_Warranty_Start_Date__c
                from Asset where Opportunity__c in:oppId];
        List<Id> p2Id = new List<Id>();
        for (Integer i=0; i<assets.size(); i++) {
            p2Id.add(assets[i].Product2Id);
        }
        Product2[] p2 = [select Id, RecordTypeId from Product2 where Id in:p2Id];
        List<Id> rtId = new List<Id>();
        Map<Id, Product2> p2Map = new Map<Id, Product2>();
        for (Integer i=0; i<p2.size(); i++) {
            p2Map.put(p2[i].Id, p2[i]);
            rtId.add(p2[i].RecordTypeId);
        }
        RecordType[] rt = [select Id, Name from RecordType where Id in:rtId];
        Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
        for (Integer i=0; i<rt.size(); i++) {
            rtMap.put(rt[i].Id, rt[i]);
        }
        
        List<Asset> upAssets = new List<Asset>();
        for (Integer p=0; p<pro.size(); p++) {
            for (Integer a=0; a<assets.size(); a++) {
                if (assets[a].Opportunity__c == pro[p].AcctSeed__Opportunity__c) {
                    if (rtMap.get(p2Map.get(assets[a].Product2Id).RecordTypeId).Name == 'Inverter') {
                        assets[a].Product_Warranty_Start_Date__c = pro[p].PTO_Date__c;
                        upAssets.add(assets[a]);
                    }
                }
            }
        }
        if (upAssets.size() > 0) {
            update upAssets;
        }
    }
    */
    /*
    static testMethod void testAutoAssets() {
        
        //Create all the objects we need
        Id accRtId = '012300000000Yip';
        Id p2InverterRtId = '01230000000944Y';
        Id p2SolarModuleRtId = '01230000000944T';
        Id p2DASRtId = '012800000006pNO';
        Id p2MiscRtId = '0123000000096N3';
        Id p2RackingRtId = '012800000006pNJ';
        
        List<User> ListOfUser=new List<User>();
        
        User owner;
        
        ListOfUser = [select Id from User where Name = 'Emily East'];
        
        if (ListOfUser==null)
            ListOfUser = [select Id from User where isActive=True limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User where isActive=True   limit 1];
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            Owner=ListOfUser[0];
        
        User other;
        
        
        ListOfUser = [select Id from User where Name = 'Michael Hall']; 
  
        if (ListOfUser==null)
            ListOfUser = [select Id from User where isActive=True   limit 1];
         else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User where isActive=True   limit 1];    
            
            
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            other=ListOfUser[0];
  
        Account AccMake = new Account(Name = 'Knight - 2456', Type = 'Customers', Job_Type__c = 'Commercial',
                    Branch__c = 'Berkeley', RecordTypeId = accRtId, ShippingCity = 'Park City');
        insert AccMake;   
        Opportunity OppMake = new Opportunity(OwnerId = other.Id, Name = 'Knight - 2456', AccountId = AccMake.Id,
                    Type = 'Turnkey System', CloseDate = System.today(), StageName = 'Prospecting',
                    ForeCastCategoryName = 'Pipeline',
                    Last_Date_Called__c = System.today(),
                    Rating__c = 'Hot',
                    Financing__c = 'Cash',
                    Approximate_Install_Date__c = System.today(),
                    Job_Type__c = 'Commercial',
                    Service_Contract_Included__c = 'Yes',
                    Amount = 10000000,
                    Installation_Obstacles__c = 'Customer_Schedule',
                    Additional_Charges__c = 'Permit',
                    Utility_Company__c = 'SCE',
                    Expected_Rebate__c = 5000,
                    Project_Cost__c = 5000000,
                    Prevailing_Wage__c = 'Yes',
                    Tax_Exemption__c = 'Exempt',
                    Inverter_Delivery_Date__c = System.today(),
                    Module_Delivery_Date__c = System.today(),
                    Racking_Delivery_Date__c = System.today());
        insert OppMake;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        List<Product2> ProdMakeList = new List<Product2>();
        System.runAs(bh){
            ProdMakeList.add(new Product2(Name = 'Inverter GT250-480', Manufacturer__c = 'Acme', Family = 'Inverters', 
                    Cost__c = 30000, IsActive = true, Status__c = 'Approved for Sale', RecordTypeId = p2InverterRtId));
			ProdMakeList.add(new Product2(Name = 'Inverter GT250-480', Manufacturer__c = 'Acme', Family = 'Solar Modules', 
				Cost__c = 30000, IsActive = true, Status__c = 'Approved for Sale', RecordTypeId = p2SolarModuleRtId));
			ProdMakeList.add(new Product2(Name = 'Inverter GT250-480', Manufacturer__c = 'Acme', Family = 'DAS', 
				Cost__c = 30000, IsActive = true, Status__c = 'Approved for Sale', RecordTypeId = p2DASRtId));
			ProdMakeList.add(new Product2(Name = 'Inverter GT250-480', Manufacturer__c = 'Acme', Family = 'Misc', 
				Cost__c = 30000, IsActive = true, Status__c = 'Approved for Sale', RecordTypeId = p2MiscRtId));
			ProdMakeList.add(new Product2(Name = 'Inverter GT250-480', Manufacturer__c = 'Acme', Family = 'Racking', 
				Cost__c = 30000, IsActive = true, Status__c = 'Approved for Sale', RecordTypeId = p2RackingRtId));
            insert ProdMakeList;
        }
    
        AcctSeed__Project__c[] project = new AcctSeed__Project__c[0];
        project.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = OppMake.Id, AcctSeed__Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert project;
        
        List<Site__c> sList = new List<Site__c>();
		sList.add(new Site__c(
			Name = '123 Main Street',
			Project__c = project[0].Id)
		);
		sList.add(new Site__c(
			Name = '456 Main Street',
			Project__c = project[0].Id)
		);
		insert sList;
		
		List<Project_Products__c> ppList = new List<Project_Products__c>();
		ppList.add(new Project_Products__c(Project__c = project[0].Id, Site__c = sList[0].Id, Product__c = ProdMakeList[0].Id, Quantity__c = 2));
		ppList.add(new Project_Products__c(Project__c = project[0].Id, Site__c = sList[1].Id, Product__c = ProdMakeList[1].Id, Quantity__c = 2));
		ppList.add(new Project_Products__c(Project__c = project[0].Id, Site__c = sList[1].Id, Product__c = ProdMakeList[2].Id, Quantity__c = 2));
		ppList.add(new Project_Products__c(Project__c = project[0].Id, Site__c = sList[1].Id, Product__c = ProdMakeList[3].Id, Quantity__c = 2));
		ppList.add(new Project_Products__c(Project__c = project[0].Id, Site__c = sList[1].Id, Product__c = ProdMakeList[4].Id, Quantity__c = 2));
		insert ppList;
		
        Test.startTest();
        project[0].Interconnection_Status__c = 'Permission to Operate';
        project[0].PTO_Date__c = System.today();
        project[0].Create_Assets__c =true;
        update project;
        checkAssets();
        project[0].PTO_Date__c = project[0].PTO_Date__c.addDays(2);
        project[0].Date_Change_Explanation__c = 'This is the explanation';
        project[0].Warranty_Date__c =true;
        project[0].Create_Assets__c =false;
        update project;
        system.debug('AAAAA project[0] Warranty_Date__c = ' + project[0].Warranty_Date__c + ' Create_Assets__c = ' + project[0].Create_Assets__c);
        checkAssets();
        Test.stopTest();
    }
    
    
    
        static testMethod void testAutoAssets1() {
        
        //Create all the objects we need
        RecordType[] rt = [select Id, Name from RecordType where (Name = 'Customer' and SobjectType = 'Account') or (Name = 'Inverter' and SobjectType = 'Product2') or (Name = 'Standard Opportunity' and SobjectType = 'Opportunity')];
        Id accRtId;
        Id p2RtId;
        Id oppRtId;
        for (Integer i=0; i<rt.size(); i++) {
            if (rt[i].Name == 'Customer') {
                accRtId = rt[i].Id;
            }
            if (rt[i].Name == 'Inverter') {
                p2RtId = rt[i].Id;
            }
            if (rt[i].Name == 'Standard Opportunity') {
                oppRtId = rt[i].Id;
            }
        }
        List<User> ListOfUser=new List<User>();
        
        User owner;
        
        ListOfUser = [select Id from User where Name = 'Emily East'];
        
        if (ListOfUser==null)
            ListOfUser = [select Id from User where isActive=True limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User where isActive=True   limit 1];
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            Owner=ListOfUser[0];
        
        User other;
        
        
        ListOfUser = [select Id from User where Name = 'Michael Hall']; 
  
        if (ListOfUser==null)
            ListOfUser = [select Id from User where isActive=True   limit 1];
         else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User where isActive=True   limit 1];    
            
            
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            other=ListOfUser[0];
  
        Account AccMake = new Account(Name = 'Knight - 2456', Type = 'Customers', Job_Type__c = 'Commercial',
                    Branch__c = 'Berkeley', RecordTypeId = accRtId, ShippingCity = 'Park City');
        insert AccMake;   
        Opportunity OppMake = new Opportunity(OwnerId = other.Id, Name = 'Knight - 2456', AccountId = AccMake.Id,
                    Type = 'Turnkey System', CloseDate = System.today(), StageName = 'Contract Signed',
                    RecordTypeId = oppRtId,
                    ForeCastCategoryName = 'Pipeline',
                    Last_Date_Called__c = System.today(),
                    Rating__c = 'Hot',
                    Financing__c = 'Cash',
                    Approximate_Install_Date__c = System.today(),
                    Job_Type__c = 'Commercial',
                    Service_Contract_Included__c = 'Yes',
                    Amount = 10000000,
                    Installation_Obstacles__c = 'Customer_Schedule',
                    Additional_Charges__c = 'Permit',
                    Utility_Company__c = 'SCE',
                    Expected_Rebate__c = 5000,
                    Project_Cost__c = 5000000,
                    Prevailing_Wage__c = 'Yes',
                    Tax_Exemption__c = 'Exempt',
                    Inverter_Delivery_Date__c = System.today(),
                    Module_Delivery_Date__c = System.today(),
                    Racking_Delivery_Date__c = System.today());
        insert OppMake;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
       
    
        AcctSeed__Project__c[] project = new AcctSeed__Project__c[0];
        project.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = OppMake.Id, AcctSeed__Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert project;
        project[0].Interconnection_Status__c = 'Permission to Operate';
        project[0].PTO_Date__c = System.today();
        project[0].Create_Assets__c =true;
        update project;
        checkAssets();
        project[0].PTO_Date__c = project[0].PTO_Date__c.addDays(2);
        project[0].Date_Change_Explanation__c = 'This is another explanation';
        update project;
        checkAssets();
    }
    */
}