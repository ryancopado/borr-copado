({
    doInit: function(component, event, helper) {
        
    //  alert('calling the 555');
        
        var action = component.get("c.Apphistoryid");
        var record=component.get("v.recordId");
       // alert('record id ' +record);
        
        action.setParams({"AppId" : component.get("v.recordId")});
        
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            alert(state);
            
            if (state === "SUCCESS") {
                
                
                var records = response.getReturnValue(); 
                
             
                  
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": records,
                    "isredirect":true ,
                });
                $A.get('e.force:refreshView').fire();
                urlEvent.fire();
               
                
                setTimeout(function(){ 
                    $A.get('e.force:refreshView').fire();
                }, 1);
                
            
                   
            }
             
            else
            {
                alert(response.getReturnValue());
            }
            
           
            
            
        });
        
        $A.enqueueAction(action);
    },
    
    pageloadbuttton: function(component, event, helper) {
        
      //  alert('this is approval page 4444');
        var action = component.get("c.Buttonshowhide");
        
        action.setParams({"processinstanceId" : component.get("v.recordId")});
        
        action.setCallback(this, function(response) {
            
            var state = response.getState();
           // alert(state);
            
            if (state === "SUCCESS") {
                
                var records = response.getReturnValue(); 
          //      alert('show hide value'  +records);
                component.set("v.buttondisplay", records);
                
                
            }
            
            
        });
        
        $A.enqueueAction(action);
    },
    
    
    Appascorrected: function(component, event, helper) {
      //  alert ('this is app as corrected');
         var action = component.get("c.Apphistoryrecallid");
        
        action.setParams({"recallId" : component.get("v.recordId")});
                action.setCallback(this, function(response) {
            
            var state = response.getState();
             alert(state);
            
            if (state === "SUCCESS") {
       
                var records = response.getReturnValue(); 
                
            
         
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": records,
                    "isredirect":true ,
                });
                 urlEvent.fire();
      
                setTimeout(function(){ 
                    $A.get('e.force:refreshView').fire();
                }, 1);
                   
            } 
                     else
            {
                alert(response.getReturnValue());
            }

        });
        
        $A.enqueueAction(action);
        
    },
    
    ITresolved: function(component, event, helper) {
     // alert('this is resolved issue 66') ;
         var action = component.get("c.Issueresolved");
        
        action.setParams({"IssueId" : component.get("v.recordId")});
        
          action.setCallback(this, function(response) {
            
            var state = response.getState();
            alert(state);
            
            if (state === "SUCCESS") {
       
                var records = response.getReturnValue(); 
                
         
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": records,
                    "isredirect":true ,
                });
                 urlEvent.fire();
      
                setTimeout(function(){ 
                    $A.get('e.force:refreshView').fire();
                }, 1);
               
            } 
               else
            {
                alert(response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
        
        
    }
    
})