({
	Notifyhelper : function(component, event, helper) {
        
         var self = this;
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
              //  alert(component.get ("v.recordId") );
                var navigateEvent = $A.get("e.force:navigateToSObject");
   navigateEvent.setParams({ "recordId": component.get ("v.recordId") });
   navigateEvent.fire();
                
          $A.get('e.force:refreshView').fire();
       //      self.isRefreshed(component, event, helper);
          
            } else {
                
                 alert('abcd' +response.getReturnValue());
                
            }
             
       //    window.location.href = windowRedirect;
   //location.reload();
       
  });
        
        
        $A.enqueueAction(action);
      
	
	},
    
    isRefreshed: function(component, event, helper) {
         debugger;
       console.log('this is the second method')
       
      $A.get('e.force:refreshView').fire();
        location.reload();
    }
		
	
})