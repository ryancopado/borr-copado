public class psdUpdate {
   /* public static void addStatusDate(PSD__c[] psds) {
        for (PSD__c p:psds) {
            p.Status_Change__c = System.today();
        }
    }
    
    public static void emailPreSalesDesign(PSD__c[] psd) {
        
        //Send a design email request to the Design Partner for each PSD
        String emailBody;
        List<Id> conId = new List<Id>();
        for (Integer i=0; i<psd.size(); i++) {
            conId.add(psd[i].Contact__c);
        }
        Contact[] con = [select Id, Email from Contact where Id in:conId];
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        for (Integer i=0; i<con.size(); i++) {
            conMap.put(con[i].Id, con[i]);
        }
        
        UserRole appRole = [select Id from UserRole where Name =:'Applications Engineer'];
        Id cuId = UserInfo.getUserId();
        User[] users = [select Id, UserRoleId, Email, Region__c, Pre_Sales_Design_Request_Email__c from User where Id =:cuId or UserRoleId =:appRole.Id];
        User cUser;
        List<User> appUser = new List<User>();
        for (Integer i=0; i<users.size(); i++) {
            if (users[i].Id == cuId) {
                cUser = users[i];
            }
            if (users[i].UserRoleId == appRole.Id) {
                appUser.add(users[i]);
            }
        }
        
        List<String> ccaddr = new List<String>();
        for (Integer i=0; i<appUser.size(); i++) {
            if ( (appUser[i].Region__c == cUser.Region__c) && (appUser[i].Pre_Sales_Design_Request_Email__c) ) {
                ccaddr.add(appUser[i].Email);
            }
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for (Integer i=0; i<psd.size(); i++) {
            emailBody = '\nBorrego Solar Systems has requested a layout.\n\n';
            emailBody += 'Project:  ' + psd[i].Customer_Name__c + '\n';
            emailBody += 'Due Date:  ' + psd[i].Due_Date__c.format() + '\n';
            emailBody += 'Notes:  ' + psd[i].Additional_Notes__c + '\n\n';
            emailBody += 'Access the design information here:\n';
            emailBody += 'https://na6.salesforce.com/' + psd[i].Id + '\n\n';
            mail.setSubject(psd[i].Customer_Name__c + ': Borrego Solar Systems has requested a layout');
            mail.setPlainTextBody(emailBody);
            mail.setTargetObjectId(psd[i].Contact__c);
            mail.setCcAddresses(ccaddr);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        }
    }
    
    public static testMethod void psdTest(){
        User other = [select Id from User where Name = 'Michael Hall'];
        Account AccMake = new Account(Name = 'Knight - 2456', ShippingCity = 'Park City'); insert AccMake;
        Contact ConMake = new Contact(FirstName = 'Tom', LastName = 'Tuttle', AccountId = AccMake.Id, Email = 'tt@borregosolar.com.training');
        insert ConMake;
        RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity'];
        Opportunity OppMake = new Opportunity(OwnerId = other.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                                CloseDate = System.today(),StageName = 'Prospecting', of_Sites__c = 1,RecordTypeId = ContentRT.Id); insert OppMake;
        OppMake.StageName = 'Qualified'; update OppMake; //OppMake.Development_Only__c = 'No'; OppMake.Expected_Bid_Date__c = system.today(); 
        PSD__c psd = new PSD__c(Opportunity__c = OppMake.Id, Contact__c = ConMake.Id);
        insert psd;
        psd.Status__c = 'Submitted';
        psd.Proposal_Level_Needed__c = 'L1';
        psd.Designer__c = 'Outsource';
        update psd;
    }*/
}