({
         
	doInit : function(component, event, helper) {
        
        var action = component.get("c.PrdModSubmit");
        action.setParams({"PModId" : component.get("v.recordId")});
               
       
         action.setCallback(this, function(response){
            var state = response.getState();
            // alert(state);
             
            if(state === "SUCCESS"){
               component.set("v.PMID", response.getReturnValue());
                if (response.getReturnValue()!=null){
                     alert(response.getReturnValue());
                    
                     }
                  var navigateEvent = $A.get("e.force:navigateToSObject");
   navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
   navigateEvent.fire();
                
          $A.get('e.force:refreshView').fire();  
              
               
              } else {
                
                 alert(response.getReturnValue());
                  location.reload();
            }
             
           
      
        
  });
        $A.enqueueAction(action);
    	
	}
})