({
	doInit : function(component, event, helper) {

   //alert('this is cmp 5')      ;  
        var action = component.get("c.newserviceapp");
        action.setParams({"WOId1" : component.get("v.recordId")});
        
         action.setCallback(this, function(response) {
      var state = response.getState();
  //    alert(state);

      if (state === "SUCCESS") {
       //  alert(response.getReturnValue());

        var getvalues = response.getReturnValue();
        var JSONStr = JSON.stringify(getvalues);
        var jsonString = JSON.parse(JSONStr);

       //  alert(JSONStr);

       debugger;

        for (var i = 0; i < jsonString.length; i++) {
          var ParentRecord = jsonString[i].Id;
          var CaseId = jsonString[i].CaseId;
          var Project__c = jsonString[i].Project__c;
        }

     //    alert(Project__c);
       //  alert(ParentRecord);
         //alert(CaseId);
         debugger;
          
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
          entityApiName: "ServiceAppointment",
              defaultFieldValues: {
                  ParentRecordId : ParentRecord,
                Project__c : Project__c,
                  Case__c : CaseId
            }
            
        });
          
        createRecordEvent.fire();
        //$A.get("e.force:refreshView").fire();
      } else {
        alert(response.getReturnValue());
      }
    });
    $A.enqueueAction(action);
		
	}
})