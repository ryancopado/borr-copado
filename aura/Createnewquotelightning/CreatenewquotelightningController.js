({
	doInit : function(component, event, helper) {
     //  alert('11');
     //   alert(component.get("v.recordId"));
        var action = component.get("c.getquotefields");
    action.setParams({ caseid1: component.get("v.recordId") });

    action.setCallback(this, function(response) {
      var state = response.getState();
  //   alert(state);

      if (state === "SUCCESS") {
    //   alert(response.getReturnValue());

        var getvalues = response.getReturnValue();
        var JSONStr = JSON.stringify(getvalues);
        var jsonString = JSON.parse(JSONStr);
          
          
          for (var i = 0; i < jsonString.length; i++) {
          var project = jsonString[i].Project__c;
          var Contract = jsonString[i].ServiceContract_Case__c;
          
        }
          
        
        var getcaseid =component.get("v.recordId");
       // alert (Contract);
         var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
          entityApiName: "SBQQ__Quote__c",
            "defaultFieldValues": {
                Case__c :  getcaseid,
                Project__c:project,
                Contract__c:Contract
              //  recordtypeid :'012340000007nu9'
    }
        
        });
        createRecordEvent.fire();
      }  else {
        alert(response.getReturnValue());
      }
      });
         $A.enqueueAction(action);

      

    }
	
})