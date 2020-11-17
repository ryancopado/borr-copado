({
    doinit : function(component, event, helper) {
        var action = component.get("c.locksales");
        var projectid = component.get("v.recordId");
        
        action.setParams({"ProId" : component.get("v.recordId")});
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state === "SUCCESS"){
                
              //  alert('333' +response.getReturnValue());
                
                if (response.getReturnValue() == 'Already Sales budget locked.'){
                    
                //    alert('this is condition');
                    alert(response.getReturnValue());
                    location.reload();
                    
                }
                else{
                    window.location = response.getReturnValue();
                    
                }
                
                
            }
            
        });
        $A.enqueueAction(action);
        
        
    }
})