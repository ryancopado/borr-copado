({
    
    doInit : function(component, event, helper) {
  //    alert('13');
  //      debugger;
        var action = component.get("c.CancelPR");
        action.setParams({"PriceId1" : component.get("v.recordId")});
        
        
        action.setCallback(this, function(response){
            var state = response.getState();
            debugger;
              console.log(state);
            
            if(state === "SUCCESS"){
         //       alert('coming into the sucess loop');
          var aa =response.getReturnValue()
         console.log(aa);   
                component.set("v.ReqId", response.getReturnValue());
                if(response.getReturnValue()!=null){
                    alert(response.getReturnValue());
                }
                
              var navigateEvent = $A.get("e.force:navigateToSObject");
   navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
   navigateEvent.fire();
                location.reload();
           //     location.reload();
   //     $A.get('e.force:refreshView').fire();  
                
            } else {
                if(response.getReturnValue()!=null){
                alert(response.getReturnValue());
                }
                location.reload();
            }
            
            
            
            
        });
        $A.enqueueAction(action);
        
    }
})