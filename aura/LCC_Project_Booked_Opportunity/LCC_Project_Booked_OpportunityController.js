({
         
	doInit : function(component, event, helper) {
         var windowRedirect = window.location.href;
         var dismissActionPanel = $A.get("e.force:closeQuickAction");
         dismissActionPanel.fire();
         //get opportunity ID
        //var action = component.get("c.getOpportuniy");
        var action = component.get("c.OppUpdate");
        action.setParams({"OppId" : component.get("v.recordId")});
               
       
         action.setCallback(this, function(response){
            var state = response.getState();
             //alert(state);
             
            if(state === "SUCCESS"){
               component.set("v.oppID", response.getReturnValue());
                alert(response.getReturnValue());
               // var dismissActionPanel = $A.get("e.force:closeQuickAction");
         		// dismissActionPanel.fire();
                $A.get('e.force:refreshView').fire();
               // window.location.href = windowRedirect;
            } else {
                
                 alert(response.getReturnValue());
            }
             
           
      
        
  });
        $A.enqueueAction(action);
    	
	}
})