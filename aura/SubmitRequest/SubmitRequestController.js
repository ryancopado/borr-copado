({
         
	doInit : function(component, event, helper) {
         //var windowRedirect = window.location.href;
        // var dismissActionPanel = $A.get("e.force:closeQuickAction");
        // dismissActionPanel.fire();
         //get opportunity ID
        //var action = component.get("c.getOpportuniy");
        var action = component.get("c.PricepUpdate");
        action.setParams({"PriceId" : component.get("v.recordId")});
               
       
         action.setCallback(this, function(response){
            var state = response.getState();
             //alert(state);
             
            if(state === "SUCCESS"){
               component.set("v.ReqId", response.getReturnValue());
                alert( '111' +response.getReturnValue());
                 var navigateEvent = $A.get("e.force:navigateToSObject");
                 navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
                 navigateEvent.fire();
               // var dismissActionPanel = $A.get("e.force:closeQuickAction");
         		// dismissActionPanel.fire();
                $A.get('e.force:refreshView').fire();
                //location.reload();
               // window.location.href = windowRedirect;
            } else {
                
                 alert(response.getReturnValue());
            }
             
           
      
        
  });
        $A.enqueueAction(action);
    	
	}
})