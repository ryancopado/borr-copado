({
    onRecordSubmit : function(component, event, helper) 
    {
   //alert('Entering 123');
         
       var eventFields = event.getParam("fields"); 
       //alert('Values' +eventFields);
       if(eventFields["Status"] != "Closed")
       {
           event.preventDefault();
           alert('Please set the status as CLOSED before closing the case');
       }
       /*  if(eventFields["RecordTypeId"]=="01234000000BnNoAAK") 
        {
            //alert(eventFields["Labor_Billing__c"]);
            if((eventFields["Labor_Billing__c"]=="Billable") )
            {
                if((eventFields["Quote_Attached__c"]==null))
                {
                     event.preventDefault();
           alert('Before closing a billable project case you must attach the Quote in the Notes & Attachments section of the Case.');
                }
            }
                 if((eventFields["Labor_Billing__c"]=="Billable - Fixed Price") )
            {
                alert('this is fixed price'  +eventFields["Quote_Attached__c"]);
                if((eventFields["Quote_Attached__c"]==null))
                {
                     event.preventDefault();
           alert('Before closing a billable project case you must attach the Quote in the Notes & Attachments section of the Case.');
                }
                
           
            }
        }*/
       
        
        
    },
   	handleSuccess : function(component, event, helper) 
    { 
  // alert('entering sucess');
        
        var toastEvent = $A.get("e.force:showToast"); 
        toastEvent.setParams({ "title": "Success!", "message": "The Record has been updated.", "type": "success" }); 
        toastEvent.fire(); 
        location.reload();
        //helper.showHide(component);
        
    },
   
    cancelevent:function(component, event, helper) 
    {
        location.reload();
    },
    doInit : function(component, event, helper) {
        
  //    alert('Entering23');
        //alert(component.get("v.recordId"));
		//component.find('userId1').set('v.value', "Closed");
        //component.find('userId').set('v.value', "Closed");
        
        
        var action = component.get("c.getcase");
        
      action.setParams({"caseid" : component.get("v.recordId")});
        
             action.setCallback(this, function(response) {
       
        var state = response.getState();
       
          
        if (state === "SUCCESS") {
         
      
          var records = response.getReturnValue();            
          var JSONStr = JSON.stringify(records);
          var jsonString = JSON.parse(JSONStr);
            
            for (var i = 0; i < jsonString.length; i++) {
          var csid = jsonString[i].Id;
          var RecordTypename = jsonString[i].RecordType.Name;
          var rectypeid = jsonString[i].RecordTypeId;      
          
        }
            
            //alert('recid   14-->' +RecordTypename);
            
            component.set("v.cslistrec",records );
         
         component.set("v.cslist", csid);
         component.set("v.rectypename",RecordTypename); 
         component.set("v.recid",rectypeid )  ; 
         
       }    
       
      });
             
      $A.enqueueAction(action);
        },
    
     handleError:function(component, event, helper) 
    {
       /* alert('123');
        debugger;
         var eventFields = event.getParams("fields"); 
        
        alert(eventFields);
       if(eventFields["RecordTypeId"]=="01234000000BnNoAAK") 
        {
            alert(eventFields["Labor_Billing__c"]);
            if((eventFields["Labor_Billing__c"]=="Billable") && (eventFields["Quote_Attached__c"]==null))
            {
            event.preventDefault();
           alert('Before closing a billable project case you must attach the Quote in the Notes & Attachments section of the Case.');
            }
        }*/
    }

})