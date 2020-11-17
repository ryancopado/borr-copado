({
	doInit : function(component, event, helper) {
        
         var windowRedirect = window.location.href;
        var action = component.get("c.ConComitteeUpdate");
       // alert(component.get("v.recordId"));
        action.setParams({"ccsId" : component.get("v.recordId")});
        
        action.setCallback(this, function(response){
            var state = response.getState();
           //  alert(state);
             
            if(state === "SUCCESS"){
               component.set("v.recid", response.getReturnValue());
                alert(response.getReturnValue());
          //   window.location.href = windowRedirect;
            var navigateEvent = $A.get("e.force:navigateToSObject");
   navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
   navigateEvent.fire();
                
          $A.get('e.force:refreshView').fire();                    
              
            } else {
                
                 alert(response.getReturnValue());
                
            }
             
        
      
        
  });
        $A.enqueueAction(action);
    
		
	}
})