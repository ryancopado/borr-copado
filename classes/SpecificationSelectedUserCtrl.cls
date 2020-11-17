public with sharing class SpecificationSelectedUserCtrl {

    public SpecificationSelectedUserCtrl (ApexPages.StandardController controller) {
        list<Specification_1__c> listOfSpecification=[Select id,  Selected_Users__c  from Specification_1__c where id=:ApexPages.currentPage().getParameters().get('Id')];
        
        IF(listOfSpecification!=null && listOfSpecification.Size()>0) 
            Specification=listOfSpecification[0];
         
       
         selectedUsers = new List<SelectOption>();
        
        List<User> Users = [SELECT Name,email, Id FROM User where isActive=true order by name];    
        allUsers = new List<SelectOption>();
        for ( User c : Users ) {
            string strSelectedUsers=Specification.Selected_Users__c;
            if(strSelectedUsers!=null){
                if(strSelectedUsers.contains(c.id)){
                    selectedUsers.add(new SelectOption(c.Id, c.Name));
                }
                else{
                    allUsers.add(new SelectOption(c.Id, c.Name));
                }
            }
            else
                allUsers.add(new SelectOption(c.Id, c.Name));
        }
    }
    public id shopdr;
    
    Public Specification_1__c Specification {get; set;}
    
    Public string Comment{get; set;}
        
     
    
    public SelectOption[] selectedUsers { get; set; }
    public SelectOption[] allUsers { get; set; }
    
    public String message { get; set; }
    
    
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
        
          if(Specification != null){
          
             list<id> listOfUserId=new list<id>();
             string strSelectedOptions='';
             for(SelectOption SO: selectedUsers ){
                 if(strSelectedOptions=='')
                     strSelectedOptions+=so.getValue();
                 else
                     strSelectedOptions+=','+ so.getValue();
                     
                     listOfUserId.add(so.getValue());
             }
             if(Specification.Selected_Users__c!=strSelectedOptions)
                 isChanged=true;
             Specification.Selected_Users__c=strSelectedOptions;
             update Specification;
             
             
             if (isChanged==true){ 
                     
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     
                    list<contact> listOfTemparoryContacts=new list<contact>();
                    
                    Try{
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='CC User Notification For Specification'];
                            
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
                            
                            mail.setwhatid(Specification.id);
                            
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
}