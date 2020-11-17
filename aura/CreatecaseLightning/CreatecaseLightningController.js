({
    doInit: function(component) {
        
     //   alert('calling the component 567');
        
        
        
        //call apex class method
        //
        
        var action = component.get("c.ProjectId");
        //var caseId = cmp.get('v.recordId')
        var PId = component.get('v.recordId');
        // alert(PId);
        
        action.setParams({"ProId" : component.get("v.recordId")});
        
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            //  alert(state);
            
            if (state === "SUCCESS") {
                //set response value in wrapperList attribute on component.
                //var test=component.get("v.PSDList");          
                
                var records = response.getReturnValue();            
           //     alert('records'+records);
                
                component.set("v.contractlist", records);
                
                
            }    
            
        });
        $A.enqueueAction(action);
    },
    gotoURL:function(component, event, helper){
    //    alert('this is goto url-->')
        
        
        console.log(event.getSource().get("v.class"));
     var entryId = event.getSource().get("v.class");
     //  alert(entryId);
      
       
        //debugger;  
         var evt = $A.get("e.force:navigateToComponent"); 
        //var PId = component.get('v.recordId');
        evt.setParams({
          componentDef :"c:caserecordtypeselector",
            componentAttributes: {
           getconid : entryId
        
                                      }
        
         });
        
        evt.fire();
    }
})