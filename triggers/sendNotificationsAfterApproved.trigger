trigger sendNotificationsAfterApproved on Specification_1__c (after Update) {
    
    if(trigger.new.size()>1) return;
    Specification_1__c Specification;
    SelectOption[] selectedUsers;
    if(trigger.new[0].Status__c!=trigger.old[0].status__c && trigger.new[0].Status__c=='Approved'){
        Specification=[Select id,Selected_Users__c  from Specification_1__c where id=: trigger.new[0].id];
        
        selectedUsers = new List<SelectOption>();
        
        List<User> Users = [SELECT Name,email, Id FROM User where isActive=true];    
         
        for ( User c : Users ) {
            string strSelectedUsers=Specification.Selected_Users__c;
            if(strSelectedUsers!=null){
                if(strSelectedUsers.contains(c.id)){
                    selectedUsers.add(new SelectOption(c.Id, c.Name));
                } 
            }
        }
        SendMail();
    }
    
    private void SendMail(){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         
                    list<contact> listOfTemparoryContacts=new list<contact>();
                    
                    Try{ 
         
                            list<id> listOfUserId=new list<id>();
                            
                            for(SelectOption SO: selectedUsers ){
                                     listOfUserId.add(so.getValue());
                             }
                            
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
                            
                            /*list<string> listOfBCCEmailAdd=new list<string>();
                            
                            listOfBCCEmailAdd.add('hardik.ce1993@gmail.com');
                            
                            mail.setBCCAddresses(listOfBCCEmailAdd);*/
                            
                            mail.setwhatid(Specification.id);
                            
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='Specification 1 Approval'];
                            
                    
                    
                            mail.setTemplateId(e.Id);
                           //mail.setSubject('test');
                           //mail.setPlainTextBody('test');
                                
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