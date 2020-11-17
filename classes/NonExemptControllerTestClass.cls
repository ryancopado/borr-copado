@isTest(seealldata=true)
public class NonExemptControllerTestClass
{
    public static Date d = System.Today();
    public static Date dold = d.toStartOfWeek() - 7;
    public static String LastWeek = dold.format();
    public static Date dnew = date.parse(LastWeek);
    public static string timecardweekname;
    public static string Technicianid;
    public static string employeename= Userinfo.getuserId();
   static{
    List<Contact> contactlist=[select id from contact where  SF_User_Record__c=:employeename];
    if(contactlist.size()>0)
    {
      Technicianid=contactlist.get(0).Id;
      
      }
      }
     
    
      
      
    
   
 
 static testMethod void nonexemptimecardsetup() 
 {
    Test.StartTest();
  
    Account testrecord2 = new Account();
    testrecord2.Name='testaccount2';
    testrecord2.Branch__c='Mid-Atlantic';
    testrecord2.Phone='(609)-524-4500';
    testrecord2.Type='service';
    testrecord2.Industry='Electric Utilities';
    testrecord2.Job_Type__c='Private';
    testrecord2.Description='NY Community Solar - developer'; 
    //insert testrecord2;
    
    AcctSeed__Project__c testAccount3 = new AcctSeed__Project__c();
    testAccount3.Name='TestAccount1';
    testAccount3.Site_State__c='MA';
    insert testAccount3; 
    
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
     
    Contact testcontact=new Contact();
    testcontact.SF_User_Record__c ='0053400000BYSEfAAP';
    //testcontact.AccountId=testrecord2.id;
    //insert testcontact;
 
    //Date d = System.Today(); 
    //Date dold = d.toStartOfWeek() - 7;
    //system.debug('start of week'+d.toStartofWeek());
    //String LastWeek = dold.format();
    //system.debug('Last week - '+LastWeek);
    //Date dnew=date.parse(LastWeek);
    
     SV__c obj2= new SV__c();
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
 
   Date startdate= NonExemptControllerTestClass.dnew;
   obj2.Visit_Date__c=  date.newInstance(startdate.year(),startdate.month(),startdate.day());
   system.debug('day of the week' +obj2.Visit_Date__c);
   obj2.Visit_Start_Time__c='8:00 AM';
   //obj2.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj2.Visit_Date__c=System.Today();
   obj2.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
  // DateTime startTime = System.Today();
   //Datetime beginDateTime = Datetime.newInstance(startTime.year(), startTime.month(), startTime.day(), 9, 00, 0);
   //Datetime endDateTime = Datetime.newInstance(startTime.year(), startTime.month(), startTime.day(), 12, 30, 0);
   
   obj2.WorkStarted__c=Datetime.newInstance(startdate.year(),startdate.month(),startdate.day(),9,00,0);
   obj2.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj2.Work_Ended__c=Datetime.newInstance(startdate.year(),startdate.month(),startdate.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj2.Case_Resolved__c='yes';
   obj2.Weather_Conditions__c='sunny';
   obj2.Soiling__c ='heavy';
   obj2.Vegetation__c='6"';
   obj2.Asset__c=testasset1.id;   
   obj2.Was_Asset_Offline__c='No';      
   insert obj2;
   
  Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
  ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
  NonExemptController testtimecard = new NonExemptController(sc);
  PageReference pageRef = Page.NonExemptTimecard;
  system.debug('Pageref' +pageRef);
  Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
  }
   
   
   static testMethod void nonexemptimecardsetup1() 
   {
      Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
   
   
   SV__c obj3= new SV__c();
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   Date startdate1= NonExemptControllerTestClass.dnew.addDays(1);
   obj3.Visit_Date__c=date.newInstance(startdate1.year(),startdate1.month(),startdate1.day());
   obj3.Visit_Start_Time__c='8:00 AM';
   //obj3.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj3.Visit_Date__c=System.Today().addDays(-2);
   system.debug ('week of the day' +obj3.Visit_Date__c);
   obj3.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime1 = System.Today().addDays(-2);
   //Datetime beginDateTime1 = Datetime.newInstance(startTime1.year(), startTime1.month(), startTime1.day(), 9, 00, 0);
   //Datetime endDateTime1 = Datetime.newInstance(startTime1.year(), startTime1.month(), startTime1.day(), 12, 30, 0);
   
   obj3.WorkStarted__c=Datetime.newInstance(startdate1.year(),startdate1.month(),startdate1.day(),9,00,0);
   obj3.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj3.Work_Ended__c=Datetime.newInstance(startdate1.year(),startdate1.month(),startdate1.day(),12,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj3.Case_Resolved__c='yes';
   obj3.Weather_Conditions__c='sunny';
   obj3.Soiling__c ='heavy';
   obj3.Vegetation__c='6"';
   obj3.Asset__c=testasset1.id;   
   obj3.Was_Asset_Offline__c='No';      
  insert obj3;
  Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
  ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
  NonExemptController testtimecard = new NonExemptController(sc);
  PageReference pageRef = Page.NonExemptTimecard;
  system.debug('Pageref' +pageRef);
  Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup2()
   { 
    Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
   
   SV__c obj4= new SV__c();
   Date startdate2= NonExemptControllerTestClass.dnew.addDays(2);
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   obj4.Visit_Date__c=date.newInstance(startdate2.year(),startdate2.month(),startdate2.day());
   obj4.Visit_Start_Time__c='8:00 AM';
   obj4.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj4.Visit_Date__c=System.Today().addDays(-1);
   
   obj4.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime2 = System.Today().addDays(-1);
   //Datetime beginDateTime2 = Datetime.newInstance(startTime2.year(), startTime2.month(), startTime2.day(), 9, 00, 0);
   //Datetime endDateTime2 = Datetime.newInstance(startTime2.year(), startTime2.month(), startTime2.day(), 12, 30, 0);
   
   obj4.WorkStarted__c=Datetime.newInstance(startdate2.year(),startdate2.month(),startdate2.day(),9,00,0);
   obj4.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj4.Work_Ended__c=Datetime.newInstance(startdate2.year(),startdate2.month(),startdate2.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj4.Case_Resolved__c='yes';
   obj4.Weather_Conditions__c='sunny';
   obj4.Soiling__c ='heavy';
   obj4.Vegetation__c='6"';
   obj4.Asset__c=testasset1.id;   
   obj4.Was_Asset_Offline__c='No';      
   insert obj4;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
  ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
  NonExemptController testtimecard = new NonExemptController(sc);
  PageReference pageRef = Page.NonExemptTimecard;
  system.debug('Pageref' +pageRef);
  Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
  }
  static testMethod void nonexemptimecardsetup3()
   {
    Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
   
   SV__c obj5= new SV__c();
   Date startdate3= NonExemptControllerTestClass.dnew.addDays(3);
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   obj5.Visit_Date__c=date.newInstance(startdate3.year(),startdate3.month(),startdate3.day());
   obj5.Visit_Start_Time__c='8:00 AM';
   obj5.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj5.Visit_Date__c=System.Today().addDays(-3);
   
   obj5.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime3 = System.Today().addDays(-3);
   //Datetime beginDateTime3 = Datetime.newInstance(startTime3.year(), startTime3.month(), startTime3.day(), 9, 00, 0);
   //Datetime endDateTime3 = Datetime.newInstance(startTime3.year(), startTime3.month(), startTime3.day(), 12, 30, 0);
   
   obj5.WorkStarted__c=Datetime.newInstance(startdate3.year(),startdate3.month(),startdate3.day(),9,00,0);
   obj5.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj5.Work_Ended__c=Datetime.newInstance(startdate3.year(),startdate3.month(),startdate3.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj5.Case_Resolved__c='yes';
   obj5.Weather_Conditions__c='sunny';
   obj5.Soiling__c ='heavy';
   obj5.Vegetation__c='6"';
   obj5.Asset__c=testasset1.id;   
   obj5.Was_Asset_Offline__c='No';      
   insert obj5;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
  ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
  NonExemptController testtimecard = new NonExemptController(sc);
  PageReference pageRef = Page.NonExemptTimecard;
  system.debug('Pageref' +pageRef);
  Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
  }
  
  
  static testMethod void nonexemptimecardsetup4()
  {
    Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
  
   SV__c obj6= new SV__c();
   Date startdate4= NonExemptControllerTestClass.dnew.addDays(4);
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   obj6.Visit_Date__c=date.newInstance(startdate4.year(),startdate4.month(),startdate4.day());
   obj6.Visit_Start_Time__c='8:00 AM';
   obj6.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj6.Visit_Date__c=System.Today().addDays(-4);
   
   obj6.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime4 = System.Today().addDays(-4);
   //Datetime beginDateTime4 = Datetime.newInstance(startTime4.year(), startTime4.month(), startTime4.day(), 9, 00, 0);
   //Datetime endDateTime4 = Datetime.newInstance(startTime4.year(), startTime4.month(), startTime4.day(), 12, 30, 0);
   
   obj6.WorkStarted__c=Datetime.newInstance(startdate4.year(),startdate4.month(),startdate4.day(),9,00,0);
   obj6.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj6.Work_Ended__c=Datetime.newInstance(startdate4.year(),startdate4.month(),startdate4.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj6.Case_Resolved__c='yes';
   obj6.Weather_Conditions__c='sunny';
   obj6.Soiling__c ='heavy';
   obj6.Vegetation__c='6"';
   obj6.Asset__c=testasset1.id;   
   obj6.Was_Asset_Offline__c='No';      
   insert obj6;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
  ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
  NonExemptController testtimecard = new NonExemptController(sc);
  PageReference pageRef = Page.NonExemptTimecard;
  system.debug('Pageref' +pageRef);
  Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
  }
  
  static testMethod void nonexemptimecardsetup5()
  {
    Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
   
   SV__c obj7= new SV__c();
   Date startdate5= NonExemptControllerTestClass.dnew.addDays(5);
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   obj7.Visit_Date__c=date.newInstance(startdate5.year(),startdate5.month(),startdate5.day());
   obj7.Visit_Start_Time__c='8:00 AM';
   obj7.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj7.Visit_Date__c=System.Today().addDays(-5);
   
   obj7.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime5 = System.Today().addDays(-5);
   //Datetime beginDateTime5 = Datetime.newInstance(startTime5.year(), startTime5.month(), startTime5.day(), 9, 00, 0);
   //Datetime endDateTime5 = Datetime.newInstance(startTime5.year(), startTime5.month(), startTime5.day(), 12, 30, 0);
   
   obj7.WorkStarted__c=Datetime.newInstance(startdate5.year(),startdate5.month(),startdate5.day(),9,00,0);
   obj7.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj7.Work_Ended__c=Datetime.newInstance(startdate5.year(),startdate5.month(),startdate5.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj7.Case_Resolved__c='yes';
   obj7.Weather_Conditions__c='sunny';
   obj7.Soiling__c ='heavy';
   obj7.Vegetation__c='6"';
   obj7.Asset__c=testasset1.id;   
   obj7.Was_Asset_Offline__c='No';      
   insert obj7;
    Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
  }
  
  
   static testMethod void nonexemptimecardsetup6()
   {
    Test.StartTest();
    Asset testasset1=new Asset();
    testasset1.Name='testassetrecord1';
    testasset1.AccountId='0018000000xpgUZ';
    testasset1.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
    insert testasset1;
   
   SV__c obj8= new SV__c();
   Date startdate6= NonExemptControllerTestClass.dnew.addDays(6);
 //obj2.Visit_Date__c=date.newInstance(2018,12,02);
   obj8.Visit_Date__c=date.newInstance(startdate6.year(),startdate6.month(),startdate6.day());
   obj8.Visit_Start_Time__c='8:00 AM';
   obj8.Time_Card_Period__c=timecardweekname; 
 //obj2.Visit_End_Date__c=date.newInstance(2018,12,02); 
   //obj8.Visit_Date__c=System.Today().addDays(-6);
   
   obj8.Visit_End_Time__c='5:00 PM';
 //obj2.Day_of_the_week__c ='Tuesday';
   //DateTime startTime6 = System.Today().addDays(-6);
  // Datetime beginDateTime6 = Datetime.newInstance(startTime6.year(), startTime6.month(), startTime6.day(), 9, 00, 0);
   //Datetime endDateTime6 = Datetime.newInstance(startTime6.year(), startTime6.month(), startTime6.day(), 12, 30, 0);
   
   obj8.WorkStarted__c=Datetime.newInstance(startdate6.year(),startdate6.month(),startdate6.day(),9,00,0);
   obj8.Technician__c=NonExemptControllerTestClass.Technicianid; //'00334000022WSwb';
 //obj.Contract__c='cntrct.id';
   obj8.Work_Ended__c=Datetime.newInstance(startdate6.year(),startdate6.month(),startdate6.day(),17,00,0);
   //system.debug('endDateTime'+endDateTime +' - starttime'+ beginDateTime);

   obj8.Case_Resolved__c='yes';
   obj8.Weather_Conditions__c='sunny';
   obj8.Soiling__c ='heavy';
   obj8.Vegetation__c='6"';
   obj8.Asset__c=testasset1.id;   
   obj8.Was_Asset_Offline__c='No';      
   insert obj8;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
  testtimecard.Save(); 
  Test.StopTest();
   }
   static testMethod void nonexemptimecardsetup7()
   {
    Test.StartTest();
    
    
   
   
   RecordType RT = [select Id FROM RecordType WHERE name='Admin Service Visit'];
   SV__c obj9= new SV__c();
   Date startdate7=NonExemptControllerTestClass.dnew.addDays(6);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj9.RecordTypeId=RT.id;
   obj9.SiteArrivalTime__c=Datetime.newInstance(startdate7.year(), startdate7.month(), startdate7.day(), 9, 00, 0); 
   obj9.Work_Ended__c=Datetime.newInstance(startdate7.year(), startdate7.month(), startdate7.day(), 12, 30, 0);
   obj9.NonActiveCategories__c='Sick';
   obj9.Additional_Comments__c='test';
   obj9.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj9.Project__c='a1t340000034Qdj';
   obj9.Contract__c='80034000001FWQk';
   
    insert obj9;
    Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
    static testMethod void nonexemptimecardsetup8() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(5);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup9() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(4);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup10() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(3);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup11() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(2);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   
   static testMethod void nonexemptimecardsetup12() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(1);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   static testMethod void nonexemptimecardsetup13() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew;
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Sick';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
    static testMethod void nonexemptimecardsetup14() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew;
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Holiday';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup15() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(1);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Holiday';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
   
   static testMethod void nonexemptimecardsetup16() 
   {
   Test.StartTest();
    
   
   RecordType RT1 = [select Id FROM RecordType WHERE name='Admin Service Visit' Limit 1];
   SV__c obj10= new SV__c();
   Date startdate8= NonExemptControllerTestClass.dnew.addDays(2);
   //DateTime startTime7 = System.Today();
   //Datetime beginDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 9, 00, 0);
   //Datetime endDateTime7 = Datetime.newInstance(startTime7.year(), startTime7.month(), startTime7.day(), 12, 30, 0);
   obj10.RecordTypeId=RT1.id;
   obj10.SiteArrivalTime__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 9, 00, 0); 
   obj10.Work_Ended__c=Datetime.newInstance(startdate8.year(), startdate8.month(), startdate8.day(), 12, 30, 0);
   obj10.NonActiveCategories__c='Holiday';
   obj10.Additional_Comments__c='test';
   obj10.Technician__c= NonExemptControllerTestClass.Technicianid;
   obj10.Project__c='a1t340000034Qdj';
   obj10.Contract__c='80034000001FWQk';
   
   insert obj10;
   Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
    ApexPages.StandardController sc = new ApexPages.StandardController(testnonexempt);
    NonExemptController testtimecard = new NonExemptController(sc);
    PageReference pageRef = Page.NonExemptTimecard;
    system.debug('Pageref' +pageRef);
    Test.setCurrentPage(pageRef); 
  
   testtimecard.Save(); 
   Test.StopTest();
   }
 
 
 
 
 
 
  
  }