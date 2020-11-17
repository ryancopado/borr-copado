({
	doInit: function(component, event, helper) {
     //alert('this is component 999')

    var action = component.get("c.createMP");
    action.setParams({ contractid: component.get("v.recordId") });

    action.setCallback(this, function(response) {
      var state = response.getState();
      //alert(state);

      if (state === "SUCCESS") {
       // alert(response.getReturnValue());

        var getvalues = response.getReturnValue();
        var JSONStr = JSON.stringify(getvalues);
        var jsonString = JSON.parse(JSONStr);
          
          
          for (var i = 0; i < jsonString.length; i++) {
          var account = jsonString[i].AccountId;
          var Contractnumber = jsonString[i].Id;
          
        }
          
         
            var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
          entityApiName: "MaintenancePlan",
            
            defaultFieldValues: {
            WorkTypeId:"08q2H0000008OIPQA2",
            WorkOrderGenerationMethod:"WorkOrderLineItemPerAsset",
            SvcApptGenerationMethod:"SvcApptPerWorkOrder",
            ServiceContract__c:Contractnumber,
            AccountId:account
            
            
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