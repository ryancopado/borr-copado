({
  doInit: function(component, event, helper) {
     //alert('this is component 23')
     var getcaseid = component.get('v.recordId')
   //    alert(caseId);
   //   var id=component.get("v.recordId")
   //   alert(id);
      

    var action = component.get("c.createconreq");
      
    action.setParams({ "caseid": component.get("v.recordId")});

    action.setCallback(this, function(response) {
      var state = response.getState();
      //alert(state);

      if (state === "SUCCESS") {
      //   alert(response.getReturnValue());

        var getvalues = response.getReturnValue();
        var JSONStr = JSON.stringify(getvalues);
        var jsonString = JSON.parse(JSONStr);

       // alert(JSONStr);

        debugger;

        for (var i = 0; i < jsonString.length; i++) {
          var project = jsonString[i].Project__c;
          var RecordTypeId = jsonString[i].RecordTypeId;
          var Sales_Order__c = jsonString[i].Sales_Order__c;
        }

         //alert(project);
        //alert(RecordTypeId);
       //alert(Sales_Order__c);

        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
          entityApiName: "Con_Req_Group__c",
            "defaultFieldValues": {
        RecordTypeId :RecordTypeId,
                Case__c :  getcaseid,       
        Project__c : project,
        Sales_Order__c : Sales_Order__c       
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
});