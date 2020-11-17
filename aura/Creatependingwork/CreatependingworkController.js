({
doInit : function(component, event, helper) {
    alert('calling comp200');
    
    
   var action = component.get("c.Projupdate");

 var projectid = component.get("v.recordId");
    
    //alert('555project id' +projectid);
    //var projectType = projectid.get('v.value');
 action.setParams({"ProId1" : component.get("v.recordId")});
   action.setCallback(this, function(response){
    var state = response.getState();
       //alert(state);
       if(state === "SUCCESS"){
            //alert(response.getReturnValue());
           var createnewRec = $A.get("e.force:createRecord");
            createnewRec.setParams({

        "entityApiName": "Pending_Work__c",
    
            "defaultFieldValues": { 
                                   Project__c :component.get("v.recordId"),
                                   Account__c: response.getReturnValue(),
                                   Type__c:'Manual Creation Project'
                
                        } });
    

createnewRec.fire();
             }
             
             
});
                      
      
       
        $A.enqueueAction(action);
    //$A.get('e.force:refreshView').fire();
}
    

  
    
                   
 
})