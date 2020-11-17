public with sharing class IssueTrackerSelectedUserCtrl {
	
	public Request_for_Information_RFI__c IssueTracker {get; set;}
	public SelectOption[] selectedUsers {get; set;}
	public SelectOption[] allUsers {get; set;}
	public String Message {get; set;}
	public Boolean fatalError {get; set;}
	public Boolean refreshParent {get; set;}
	public Integer maxUsers {get; set;}
	
	public IssueTrackerSelectedUserCtrl(ApexPages.StandardController controller) {
		
		IssueTracker = null;
		Message = null;
		fatalError = true;
		refreshParent = false;
		maxUsers = 8;
		
		try {
			List<Request_for_Information_RFI__c> listOfIssueTracker = [select Id, Name, Contact_E_mail_Address__c, 
					Account__c, Notes_and_Additional_Information__c, Contact__c, Selected_Users__c, Status__c, 
					Email_User_1__c, Email_User_2__c, Email_User_3__c, Email_User_4__c, Email_User_5__c, 
					Email_User_6__c, Email_User_7__c, Email_User_8__c, CCIssueTracker__c 
					from Request_for_Information_RFI__c where id=:ApexPages.currentPage().getParameters().get('Id')];
		
			if (listOfIssueTracker != null && listOfIssueTracker.size() > 0) {
				IssueTracker = listOfIssueTracker[0];
				
				selectedUsers = new List<SelectOption>();
				
				List<User> Users = [select Id, Name, Email from User where isActive = true and UserType = 'Standard' order by Name];    
				allUsers = new List<SelectOption>();
				for (User c : Users) {
					String strSelectedUsers = IssueTracker.Selected_Users__c;
					if (strSelectedUsers != null) {
						if (strSelectedUsers.contains(c.Id)) {
							selectedUsers.add(new SelectOption(c.Id, c.Name));
						} else {
							allUsers.add(new SelectOption(c.Id, c.Name));
						}
					} else {
						allUsers.add(new SelectOption(c.Id, c.Name));
					}
				}
				fatalError = false;
			} else {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Invalid page parameters.'));
				Message = 'Invalid page parameters.';
			}
		} catch(Exception e) {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
			Message = e.getMessage();
		}
	}
	
	// Initialize the new email user fields if necessary (users had been selected before the new 
	// email user fields were added).
	public PageReference initUserFields() {
		
		if (IssueTracker != null) {
			if (selectedUsers.size() > 0 && IssueTracker.Email_User_1__c == null) {
				setEmailUserFields();
				update IssueTracker;
			}
			
			if (selectedUsers.size() > maxUsers) {
				Message = 'Too many users selected. Please select no more than ' + maxUsers;
			}
		}
		
		return null;
	}
	
	private void setEmailUserFields() {
		if (IssueTracker != null) {
			for (Integer i = 0; i < maxUsers; i++) {
				IssueTracker.put('Email_User_' + String.valueOf(i + 1) + '__c' , null);
				if (selectedUsers.size() > i) {
					IssueTracker.put('Email_User_' + String.valueOf(i + 1) + '__c' , selectedUsers[i].getValue());
				}
			}
		}
	}
	
	// Save the selected users and if they have changed, trigger workflow rule to send email alert
	public PageReference save() {
		
		refreshParent = false;
		if (IssueTracker != null) {
			
			if (selectedUsers.size() > maxUsers) {
				Message = 'Too many users selected. Please select no more than ' + maxUsers;
			} else {
				Message = null;
				String strSelectedOptions = '';
				for (SelectOption so :selectedUsers) {
					if (strSelectedOptions == '') {
						strSelectedOptions += so.getValue();
					} else {
						strSelectedOptions += ',' + so.getValue();
					}
				}
				
				if (IssueTracker.Selected_Users__c != strSelectedOptions) {
					IssueTracker.Selected_Users__c = strSelectedOptions;
					setEmailUserFields();
					
					if (String.isNotEmpty(strSelectedOptions)) {
						IssueTracker.CCIssueTracker__c = true;
					}
					
					try {
						update IssueTracker;
						refreshParent = true;
					} catch(Exception e) {
						ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
					}
				}
			}
		}
		
		return null;
	}
	
	/*
	public String message {get; set;}
	
	public PageReference save() {
		boolean isChanged=false;
        message = 'Selected Users: ';
        Boolean first = true;
        for ( SelectOption so : selectedUsers ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
          if(IssueTracker != null){
          
             list<id> listOfUserId=new list<id>();
             string strSelectedOptions='';
             for(SelectOption SO: selectedUsers ){
                 if(strSelectedOptions=='')
                     strSelectedOptions+=so.getValue();
                 else
                     strSelectedOptions+=','+ so.getValue();
                     
                     listOfUserId.add(so.getValue());
             }
             if(IssueTracker.Selected_Users__c!=strSelectedOptions)
                 isChanged=true;
             IssueTracker.Selected_Users__c=strSelectedOptions;
             update IssueTracker;
             
             
             if (isChanged==true){ 
                     
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     
                    list<contact> listOfTemparoryContacts=new list<contact>();
                    
                    Try{
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='CC User Notification'];
                            
                            list<string> listOfEmailAdd=new list<string>();
                            
                            for(User user:[Select id,email,Name from User where id in :listOfUserId]){
                                if(listOfTemparoryContacts.size()==1){
                                    listOfEmailAdd.add(user.email);
                                }
                                else{
                                    Contact con=new Contact();
                                    con.LastName=user.Name;
                                    con.email=user.email;
                                    listOfTemparoryContacts.add(con);
                                    //listOfEmailAdd.add(user.email);
                               }
                            }
                            
                            
                            insert listOfTemparoryContacts;
                            
                            for(Contact con : listOfTemparoryContacts) {            
                               mail.setTargetObjectId(con.id);
                            } 
                            
                             
                            
                            mail.setToAddresses(listOfEmailAdd);
                            
                            //list<string> listOfBCCEmailAdd=new list<string>();
                            
                            //listOfBCCEmailAdd.add('hardik.ce1993@gmail.com');
                            
                            //mail.setBCCAddresses(listOfBCCEmailAdd); 
                            
                            mail.setwhatid(issueTracker.id);
                            
                            mail.setTemplateId(e.Id);
                                                   
                            mail.setSaveAsActivity(false);
                                                         
                            Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[] {};
                    
                            Messaging.sendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                                        
                            if(results.size() > 0){
                                for ( Messaging.sendEmailResult result : results ) {
                                    if ( !result.isSuccess () ) {
                                        Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, result.getErrors().get(0).getMessage()));
                    
                                    }
                                }
                            }
                 }
                 catch(exception ex){
                 
                 }
                 
                 if(listOfTemparoryContacts.size()>0) delete listOfTemparoryContacts;
                 
             }
        }     
        return null;       
    }
    */
}