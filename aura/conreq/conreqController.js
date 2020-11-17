({
doInit : function(component, event, helper) {
    
    
    var action = component.get("c.redirect");

 var projectid = component.get("v.recordId");
    //alert('555project id' +projectid);
    //var projectType = projectid.get('v.value');
 action.setParams({"ProId" : component.get("v.recordId")});
   action.setCallback(this, function(response){
    var state = response.getState();
       //alert(state);
         if(state === "SUCCESS"){
               //component.set("v.salesId", response.getReturnValue());
               var createnewRec = $A.get("e.force:createRecord");
             //alert('Length' +response.getReturnValue.length);
     //console.log('sales Id'+v.salesId);        
    console.log('Project Id'+response.getReturnValue());
             if(response.getReturnValue().length==18)
             {
        createnewRec.setParams({

        "entityApiName": "Con_Req_Group__c",
    
            "defaultFieldValues": { Project__c	 : component.get("v.recordId"),
                                   Sales_Order__c  : response.getReturnValue()
                        } });
    console.log('Project Id'+projectid);

createnewRec.fire();
             }
             
              else  {
                
                 alert(response.getReturnValue());
                  location.reload();

               //$A.get('e.force:refreshView').fire();
            }
             //$A.get('e.force:refreshView').fire();
}
      
        });
        $A.enqueueAction(action);
    //$A.get('e.force:refreshView').fire();
    

   }
    
                   
 
})