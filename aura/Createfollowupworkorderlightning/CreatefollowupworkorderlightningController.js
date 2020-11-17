({
	doInit : function(component, event, helper) {
        
        var action = component.get("c.Workordercreate");
        action.setParams({"WOId" : component.get("v.recordId")});
        
        
        action.setCallback(this, function(response){ 
         var state = response.getState();
        
            if(state === "SUCCESS"){
                 component.set("v.oppID", response.getReturnValue());
                alert(response.getReturnValue());
                var windowRedirect = response.getReturnValue();
                window.location.href = windowRedirect;
                
            }
            else {
                
                 alert('failure');
            }
        
        });
        $A.enqueueAction(action);
        
		
	}
})