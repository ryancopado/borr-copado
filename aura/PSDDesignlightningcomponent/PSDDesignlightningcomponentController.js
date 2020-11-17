({
    doInit: function(component, event, helper) {
  //      debugger;
      //alert('calling the component11');
      //call apex class method
      //
     
      var action = component.get("c.Oppdisplay");
        
      action.setParams({"OppId" : component.get("v.recordId")});
 
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
          //alert(state);
          
        if (state === "SUCCESS") {
          //set response value in wrapperList attribute on component.
          //var test=component.get("v.PSDList");          
          
          var records = response.getReturnValue();            
             //alert('records'+records);
            
         component.set("v.PSDList", records);
        
         
            

     
     
           
            

           
               
         
            
                            }    
       
      });
             
      $A.enqueueAction(action);
        },
    handleClick : function(component, event, helper) {

           var createRecordEvent = $A.get("e.force:createRecord");
        //alert('Getting Event');
        createRecordEvent.setParams({
            "entityApiName": "PSD__c",
                        "defaultFieldValues": { Opportunity__c	 : component.get("v.recordId"),
                                  
                        }
        });
        createRecordEvent.fire();
        },
    
    sectionOne : function(component, event, helper) {
       helper.helperFun(component,event,'articleOne');
    },

   
  //  }
    
})