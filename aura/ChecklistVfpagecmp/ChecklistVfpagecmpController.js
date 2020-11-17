({
	doInit : function(component, event, helper) {
		 
        
        var action = component.get("c.getchklist");
        
      action.setParams({"woId" : component.get("v.recordId")});
        
             action.setCallback(this, function(response) {
       
        var state = response.getState();
       
          
        if (state === "SUCCESS") {
         
      
          var records = response.getReturnValue();            
          var JSONStr = JSON.stringify(records);
          var jsonString = JSON.parse(JSONStr);
            
            for (var i = 0; i < jsonString.length; i++) {
          var chkid = jsonString[i].Id;
          var RecordTypename = jsonString[i].RecordType.Name;
          var rectypeid = jsonString[i].RecordTypeId;      
          
        }
            
       // alert('recid   15-->' +RecordTypename);
         //   alert('ID'    +chkid);
            
            component.set("v.chklistrec",records );
         
         component.set("v.chklist", chkid);
         component.set("v.rectypename",RecordTypename); 
         component.set("v.recid",rectypeid )  ; 
         
       }    
       
      });
             
      $A.enqueueAction(action);
        }, 
        
    	getpendingworkfiles : function(component, event, helper) {
		 
        
    /*    var action = component.get("c.getpendingwork");
            
       //     alert('getpendingworkmethod' +component.get("v.recordId"));
        
      action.setParams({"woId2" : component.get("v.recordId")});
        
             action.setCallback(this, function(response) {
       
        var state = response.getState();
       
          
        if (state === "SUCCESS") {
         
      debugger;
          var pendingrec = response.getReturnValue();            
        
          
             // alert('15' +response.getReturnValue());
             component.set("v.getpenwo", pendingrec);
       
         
       }    
       
      });
             
      $A.enqueueAction(action);*/
        },
    
    getfilesrec : function(component, event, helper) {
     //   alert('Entering');
		 
        
        var action = component.get("c.getFiles");
            
    //  alert('getfilesmethod' +component.get("v.recordId"));
        
      action.setParams({"woId1" : component.get("v.recordId")});
        
             action.setCallback(this, function(response) {
       
        var state = response.getState();
       
          
        if (state === "SUCCESS") {
     //       alert('sucess');
         
      
          var filesrec = response.getReturnValue();            
        
         // debugger;
         //   alert('14' +filesrec);
             component.set("v.getfile", filesrec);
       
         
       }    
       
      });
             
      $A.enqueueAction(action);
        }
         
})