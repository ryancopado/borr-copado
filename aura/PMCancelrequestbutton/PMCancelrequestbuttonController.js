({
         
	doInit : function(component, event, helper) {
         //var windowRedirect = window.location.href;
        // var dismissActionPanel = $A.get("e.force:closeQuickAction");
         //dismissActionPanel.fire();
         //get opportunity ID
        //var action = component.get("c.getOpportuniy");
        var action = component.get("c.PrdModCancel");
        action.setParams({"PModId" : component.get("v.recordId")});
               
       
         action.setCallback(this, function(response){
            var state = response.getState();
             //alert(state);
             
            if(state === "SUCCESS"){
               component.set("v.PMID", response.getReturnValue());
                if(response.getReturnValue()!=null)
                {
                alert(response.getReturnValue());
                }
               // var dismissActionPanel = $A.get("e.force:closeQuickAction");
         		// dismissActionPanel.fire();
                //$A.get('e.force:refreshView').fire();
               // window.location.href = windowRedirect;
               //location.reload();
                var navigateEvent = $A.get("e.force:navigateToSObject");
   navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
   navigateEvent.fire();
                
          $A.get('e.force:refreshView').fire();
                }
            
             else {
                
                 alert(response.getReturnValue());
                 location.reload();
            }
             
           
      
        
  });
        $A.enqueueAction(action);
    	
	}
})