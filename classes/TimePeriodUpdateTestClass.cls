@isTest(seealldata=true)
public class TimePeriodUpdateTestClass
{
static testMethod void testMethodtimeperiod()
 {
Account testrecord1 = new Account();
testrecord1.Name='testaccount1';
testrecord1.Branch__c='Mid-Atlantic';
testrecord1.Phone='(609)-524-4500';
testrecord1.Type='service';
testrecord1.Industry='Electric Utilities';
testrecord1.Job_Type__c='Private';
testrecord1.Description='NY Community Solar - developer'; 
insert testrecord1; 
//Contact testcontact =new Contact();
//testcontact.Name='test lastname';
//testcontact.Account=testrecord1.id; 
//insert testcontact; 
 
AcctSeed__Project__c testAccount2 = new AcctSeed__Project__c();
testAccount2.Name='TestAccount';
testAccount2.Site_State__c='MA';
insert testAccount2;
 //Contract cntrct = new Contract(Name ='csvContract', Account='testaccount1',Contract_Status__c = 'Active');
 //insert cntrct;
 Asset testasset=new Asset();
 testasset.Name='testassetrecord';
 //testasset.Component_Type__c='Other';
 //testasset.Project__c='testAccount2.id';
 //testasset.Product2='misscellaneus';
 testasset.AccountId=testrecord1.id;
 testasset.Product_Warranty_Start_Date__c=date.newInstance(2017, 07, 01);
 insert testasset;
 SV__c obj= new SV__c();
 obj.Visit_Date__c=date.newInstance(2018, 3, 26);
 obj.Technician__c='00334000020yQPM';
 //obj.Contract__c='cntrct.id';
 obj.WorkStarted__c=datetime.newInstance(2018, 3, 26,16,0,0);
 obj.Work_Ended__c=datetime.newInstance(2018, 3, 26,17,0,0);
 obj.Case_Resolved__c='yes';
 obj.Weather_Conditions__c='sunny';
 obj.Soiling__c ='heavy';
 obj.Vegetation__c='6"';
 obj.Asset__c=testasset.id;   
 obj.Was_Asset_Offline__c='No';      
 insert obj;
 SV__c obj1= new SV__c();
 obj1.Visit_Date__c=date.newInstance(2018, 3, 25);
 obj.Technician__c='00334000020yQPM';
 //obj.Contract__c='cntrct.id';
 obj1.WorkStarted__c=datetime.newInstance(2018, 3, 25,16,0,0);
 obj1.Work_Ended__c=datetime.newInstance(2018, 3, 25,17,0,0);
 obj1.Case_Resolved__c='yes';
 obj1.Weather_Conditions__c='sunny';
 obj1.Soiling__c ='heavy';
 obj1.Vegetation__c='6"';
 obj1.Asset__c=testasset.id;   
 obj1.Was_Asset_Offline__c='No';      
 insert obj1;
 SV__c obj2= new SV__c();
 obj2.Visit_Date__c=date.newInstance(2018, 3, 27);
 obj2.Technician__c='00334000020yQPM';
 //obj.Contract__c='cntrct.id';
 obj2.WorkStarted__c=datetime.newInstance(2018, 3, 27,16,0,0);
 obj2.Work_Ended__c=datetime.newInstance(2018, 3, 27,17,0,0);
 obj2.Case_Resolved__c='yes';
 obj2.Weather_Conditions__c='sunny';
 obj2.Soiling__c ='heavy';
 obj2.Vegetation__c='6"';
 obj2.Asset__c=testasset.id;   
 obj2.Was_Asset_Offline__c='No';      
 insert obj2;
 SV__c obj3= new SV__c();
 obj3.Visit_Date__c=date.newInstance(2018, 3, 28);
 obj3.Technician__c='00334000020yQPM';
 //obj.Contract__c='cntrct.id';
 obj3.WorkStarted__c=datetime.newInstance(2018, 3, 28,16,0,0);
 obj3.Work_Ended__c=datetime.newInstance(2018, 3, 28,17,0,0);
 obj3.Case_Resolved__c='yes';
 obj3.Weather_Conditions__c='sunny';
 obj3.Soiling__c ='heavy';
 obj3.Vegetation__c='6"';
 obj3.Asset__c=testasset.id;   
 obj3.Was_Asset_Offline__c='No';      
 insert obj3;
 
 Non_Exempt_Time__c testnonexempt = new Non_Exempt_Time__c();
 testnonexempt.Employee_Name__c='0053400000BHsP3';
 testnonexempt.Time_Card_Week__c='a1y34000008lH6f';
 insert testnonexempt;
 }
 }