@isTest(seealldata=true)

public class TestSubmittalApphistorybuttons {
    
    
     static testMethod void testMethod1() 
    {
        

        
        Request_for_Information_RFI__c testissue=[select id from Request_for_Information_RFI__c where Status__c='Submitted/Pending'limit 1 ];
        ProcessInstanceWorkitem testprocessInstanceworkitem=[select id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:testissue.id];
      
         Submittal_1__c testsubmittal=[select id from Submittal_1__c where Status__c='Approval Pending'limit 1];
        submittal_1__c testbutton = [select id from submittal_1__c where status__c='Approval Pending' order by id desc limit 1];
        ProcessInstanceWorkitem testbuttonpi = [select id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:testbutton.id];
   
        system.debug('this is id-->' +testsubmittal.id);
        ProcessInstanceWorkitem testprocessInstanceworkitem1=[select id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:testsubmittal.id];
        system.debug('this is submittal id' +testprocessInstanceworkitem1.Id);
        
        String resut1=SubmittalApphistorybuttons.Buttonshowhide(testbuttonpi.id);
        String result = SubmittalApphistorybuttons.Issueresolved(testprocessInstanceworkitem.id);
      
        String resut2=SubmittalApphistorybuttons.Apphistoryrecallid(testprocessInstanceworkitem1.id);
      
        
        

}
    
     static testMethod void testMethod2() 
    {
        
        Submittal_1__c testsubmittal=[select id from Submittal_1__c where Status__c='Approval Pending'limit 1];
        submittal_1__c testbutton = [select id from submittal_1__c where status__c='Approval Pending' order by id desc limit 1];
        ProcessInstanceWorkitem testbuttonpi = [select id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:testbutton.id];
   
        ProcessInstanceWorkitem testprocessInstanceworkitem1=[select id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:testsubmittal.id];
        
        
        String resut1=SubmittalApphistorybuttons.Buttonshowhide(testbuttonpi.id);
        String resut3=SubmittalApphistorybuttons.Apphistoryid(testprocessInstanceworkitem1.id);
        
    }
    
}