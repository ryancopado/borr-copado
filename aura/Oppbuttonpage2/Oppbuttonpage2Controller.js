({
	getoppname : function(component, event, helper) {
        var getname ='';
        var getcity ='';
		 getname = component.find("Input1").get("v.value");
		 getcity = component.find("Input2").get("v.value");
      
        var oppname = getname + '-' + getcity;
        if (getname!= null && getcity != null) {
         var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({

                    "entityApiName": "Opportunity",
           "recordTypeId": component.get ("v.myrecordid"),
            "defaultFieldValues": {
  
                          "AccountId": component.get ("v.myaccountid"),
              			  "Name"   :oppname,
                

                    }
      });
        createRecordEvent.fire();
        }
        else{
            
            alert('Please Enter the Description and City');
            location.reload();
        }

	},
    
    closeModal : function(component, event){

        alert('111');
        
    var navigateEvent = $A.get("e.force:navigateToSObject");
    navigateEvent.setParams({ "recordId": component.get ("v.myaccountid") });
    navigateEvent.fire();
    },

  closeFocusedTab : function(component, event, helper) {
     var workspaceAPI = component.find("workspace");
    workspaceAPI.getFocusedTabInfo().then(function(response) {
      var focusedTabId = response.tabId;
            workspaceAPI.closeTab({tabId: focusedTabId});
        })
        .catch(function(error) {
     console.log(error);
        });

    }

    

})