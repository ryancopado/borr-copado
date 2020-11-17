public class submitApproval {
	public static void submit(String id, String comment) {	
		// Create an approval request for the object
		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
		req1.setComments(comment);
		req1.setObjectId(id);
		
		// Submit the approval request for the account
		Approval.ProcessResult result = Approval.process(req1);
		
		// Verify the result
		System.assert(result.isSuccess());
	//	System.assertEquals('Pending', result.getInstanceStatus(), 'Instance Status'+result.getInstanceStatus());
	}
	public static void app_rej(String id, String comment, String action) {
		
		ProcessInstance[] prInst = [Select Id from ProcessInstance where TargetObjectId=:id and Status='Pending'];		
		if(prInst.size()>0){
			ProcessInstanceWorkitem[] prInstWItem = [select Id,OriginalActorId from ProcessInstanceWorkitem where 
														ProcessInstanceId=:prInst[0].Id]; 
			Approval.ProcessWorkitemRequest prWkItem = new Approval.ProcessWorkitemRequest();
			prWkItem.setWorkitemId(prInstWItem[0].Id);
			prWkItem.setComments(comment); 
			prWkItem.setAction(action); 
			Approval.ProcessResult prResult = Approval.process(prWkItem);

          }
	}
}