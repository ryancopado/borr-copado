public class ShopDrawingApprovalController{    
    public Boolean canApprove2 { get; set; }
    public Boolean canApprove { get; set; }
    public Shop_Drawing__c shopdr;
    public ShopDrawingApprovalController(ApexPages.StandardController controller) {}
    // Function called when Approve/Reject Button is clicked


public PageReference ApprRej()

{

// runs the check




// if the check fails then it changes the flag to display error message and re-renders the current Page

if(canApprove == false)

{

canApprove2 = false;

PageReference pageRef = ApexPages.currentPage();

pageRef.setRedirect(true);

return null;

}


// if check is successful then it runs a SOQL query to get the Approval ID and uses that to redirect to the relevant Approve/Reject page

else

{

List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId = :shopdr.Id];


String strAppId = workItemList[0].Id;

String partialURL = '/p/process/ProcessInstanceWorkitemWizardStageManager?id=' + strAppId;

canApprove2 = true;

PageReference pageRef = new PageReference(partialURL);

pageRef.setRedirect(true);

return pageRef;

}

}


// Function called when Reassign Button is clicked


public PageReference Reassign()

{

// runs a SOQL query to get the Approval ID and uses that to redirect to the relevant Reassign page

List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId
From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId = :shopdr.Id];


String strAppId = workItemList[0].Id;

String partialURL = '/' + strAppId + '/e?et=REASSIGN&retURL=apex/GMAView?id=' + Shop_Drawing__c.Id + '&sfdc.override=1';

PageReference pageRef = new PageReference(partialURL);

return pageRef;

}
}