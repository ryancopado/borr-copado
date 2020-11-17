global class ScheduleBatchBoxFolders implements Schedulable {
	
	String objectName;
	Id recordId;
	
	public ScheduleBatchBoxFolders() {
		this.objectName = null;
		this.recordId = null;
	}
	
	public ScheduleBatchBoxFolders(String objName, Id recId) {
		this.objectName = objName;
		this.recordId = recId;
	}
	
	// Schedule Class for batch job BatchBoxFolders
	global void execute(SchedulableContext SC) {
		if (String.isNotBlank(this.objectName) && String.isNotBlank(this.recordId)) {
			BatchBoxFolders BB =  new BatchBoxFolders();
			BB.bbfQueryString = 'SELECT Id, Box_Folders__c, Box_Most_Recent_Error__c From ' + this.objectName + ' WHERE Id = \'' + this.recordId + '\'';
			BB.objectName = this.objectName;
			BB.recordId = this.recordId;
			Database.executeBatch(BB, 1);
		}
	}
}