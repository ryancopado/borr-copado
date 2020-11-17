@istest(SeeAllData=true)
public class QuoteSelectedUserCtrltest {
    
    static testmethod void QuoteSelectedUserCtrltest1(){
        list<Product_Quotes__c> prodlist=new list<Product_Quotes__c>();
        User u1 =new user(); 
        u1.userName = 'test7654@gmamail.com';
        u1.LastName = 'test';
        u1.Email = 't@gmail.com';
        u1.Alias = 'demo';
        u1.Department='cse';
        u1.TimeZoneSidKey = 'Asia/Kolkata';
        u1.LanguageLocaleKey = 'en_US';
        u1.LocaleSidKey = 'en_US';
        u1.EmailEncodingKey = 'UTF-8';
        u1.profileid=UserInfo.getProfileId(); 
        u1.IsActive = true;
        insert u1;
        
        Account ac=new Account();
        ac.Name='testac1';
        ac.Type='customer';
        ac.Phone='999999999999';
        ac.Description='arsertdfyguhw4sedrfytgwsedf';
        insert ac;
        
        //list<Opportunity> opp = new list<Opportunity>();
        Opportunity op= new Opportunity();
        op.AccountId=ac.Id;
        op.Name= 'testop';
        op.Lead_Source_Specific__c='wastdefygsrtdfyhuider';
        op.CloseDate=system.today();
        op.Lead_Source_Specific__c='Direct Marketing Campaign';
        op.StageName='prospecting';
        //opp.add(op);
        insert op;
        
        
        AcctSeed__Project__c ap=new AcctSeed__Project__c();
        ap.Name='testproject';
        
        ap.AcctSeed__Opportunity__c=op.id;
        
        ap.AcctSeed__Account__c=ac.Id;
        ap.Branch__c='Commercial';
        insert ap;
        /*
AcctSeed__Ledger__c al=new AcctSeed__Ledger__c();
al.AcctSeed__Type__c='Transactional';
al.AcctSeed__Billing_Activity_Statement_Format__c=ap.Id;
insert al;*/
        
        
        Request_for_Information_RFI__c rp=new Request_for_Information_RFI__c();
        Id devRecordTypeId = Schema.SObjectType.Request_for_Information_RFI__c.getRecordTypeInfosByName().get('Incoming RFI').getRecordTypeId();
        
        
        rp.Subject__c='dasdfgyhuj';
        rp.ASProject__c=ap.id;
        rp.Request_Response_Date__c=date.today();
        rp.Tag__c='Engineering';
        rp.Detailed_Description__c='Test Desc';
        rp.Schedule_Impact__c=5;
        rp.To_Borrego_Approver__c=u1.id;
        insert rp;
        
        Product_Quotes__c p = new Product_Quotes__c();
        p.Assigned_to__c=u1.Id;
        p.Issue_Tracker__c=rp.id;
        p.Selected_Users__c=u1.id;
        insert p;
        
        Product_Quotes__c p1 = new Product_Quotes__c();
        p1.Assigned_to__c=u1.Id;
        p1.Issue_Tracker__c=rp.id;
        p1.Selected_Users__c=UserInfo.getUserId();
        insert p1;
        
        Test_Report__c tr = new Test_Report__c();
        tr.Assigned_to__c=u1.Id;
        tr.Issue_Tracker__c=rp.id;
        tr.Selected_Users__c=u1.id;
        insert tr;
        
        Test_Report__c tr1 = new Test_Report__c();
        tr1.Assigned_to__c=u1.Id;
        tr1.Issue_Tracker__c=rp.id;
        tr1.Selected_Users__c=UserInfo.getUserId();
        insert tr1;
        
        ApexPages.StandardController sc1 = new ApexPages.standardController(p);
        QuoteSelectedUserCtrl controller1 = new QuoteSelectedUserCtrl(sc1);
        
        PageReference pageRef = Page.ProductQuoteSelectedUser;
        pageRef.getParameters().put('id', String.valueOf(p.Id));
        Test.setCurrentPage(pageRef);
         p.Selected_Users__c=u1.id+','+Userinfo.getUserId();
         update p;
        controller1.save();     
        
        ApexPages.StandardController sc11 = new ApexPages.standardController(p1);
        QuoteSelectedUserCtrl controller11 = new QuoteSelectedUserCtrl(sc11);
        controller11.save();
        
        ApexPages.StandardController sc2 = new ApexPages.standardController(tr);
        TestReportSelectedUserCtrl controller2 = new TestReportSelectedUserCtrl(sc2);
        PageReference page1 = Page.TestReportSelectedUser;
        page1.getParameters().put('id', String.valueOf(tr.Id));
        Test.setCurrentPage(page1);
        tr.Selected_Users__c=u1.id+','+Userinfo.getUserId();
         update tr;
        controller2.save();
        
        ApexPages.StandardController sc21 = new ApexPages.standardController(tr1);
        TestReportSelectedUserCtrl controller21 = new TestReportSelectedUserCtrl(sc21);
        controller21.save();
    }
    
}