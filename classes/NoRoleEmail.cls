public class NoRoleEmail {
    public static void addNoRoleEmail(String employee,String templateName, String whatId, Boolean activity){
    
        /*User[] backup = [Select Id, Email from User where Name = 'System User'];    
        Contact[] contact = [SELECT Id FROM contact WHERE Name = 'System User'];
       
       
        EmailTemplate[] template = [SELECT Id FROM EmailTemplate WHERE Name = :templateName];

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[0];
                try {
                    User[] user = [SELECT Email FROM user WHERE Id = :employee];
                        if (user.size() > 0){
                            toAddresses.add(user[0].Email);
                        }
                } catch(System.TypeException e){
                    System.assert(e.getMessage().contains('List index out of bounds'), 
                     e.getMessage());
                     
                     toAddresses.add(backup[0].Email);
                }
                
                mail.setToAddresses(toAddresses);

                mail.setSaveAsActivity(activity);
                
                if (Contact.Size()>0)
                    mail.setTargetObjectId(contact[0].Id);
                    
                mail.setWhatId(whatId);
                
                mail.setTemplateID(template[0].Id);
                
                // Send the email you have created.
                if (Contact.Size()>0)
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
    }
    public static testMethod void NoEmailTest(){
    	try{
	    	projectTestOld.FieldUpdate(); 
	    	Cost_Code__c costcode = new Cost_Code__c(Name = 'Test', Number__c = '1234', Category__c = 'L');
	    	insert costcode;
	    	NoRoleEmail.addNoRoleEmail(UserInfo.getUserId(), 'Complete Cell Phone Request', costcode.Id, false);
    	}catch(Exception e){
    		System.debug(e);
    	}
    }
}