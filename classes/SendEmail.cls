public class SendEmail {
/*	public static void addSendEmail(String role,String templateName,String whatId, Boolean activity){
	
	User[] backup = [Select Id, Email from User where Name = 'System User'];	
	Contact[] contact = [SELECT Id FROM contact WHERE Name = 'System User'];
	EmailTemplate[] template = [SELECT Id FROM EmailTemplate WHERE Name = :templateName];
		
		     	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				String[] toAddresses = new String[0];
				
				try {
					UserRole[] roleid = [SELECT Id FROM UserRole WHERE Name = :role];
						if (roleid.size() > 0){
							User[] user = [SELECT Email FROM User WHERE UserRoleId = :roleid[0].Id];
								if (user.size() > 0){
									toAddresses.add(user[0].Email);
								}
						}
				} catch(System.TypeException e){
					System.assert(e.getMessage().contains('List index out of bounds'), 
                     e.getMessage());
                     
					 toAddresses.add(backup[0].Email);
				}
				
				mail.setTemplateID(template[0].Id);
  				mail.setToAddresses(toAddresses);		
				mail.setSaveAsActivity(false);
				mail.setTargetObjectId(contact[0].Id);
				mail.setWhatId(whatId);
				mail.setSaveAsActivity(activity);
				
				// Send the email you have created.
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	public static testMethod void SendEmailTest(){
	ProjectTest.FieldUpdate(); 
	} */
}