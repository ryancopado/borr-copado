({

    /*

     * This methid takes recordTypeId and entityTypeName parameters

     * and invoke standard force:createRecord event to create record

     * if recordTypeIs is blank, this will create record under master recordType

     * */

    showCreateRecordModal : function(component, selectedRecordTypeId, entityApiName) {

        

        var createRecordEvent = $A.get("e.force:createRecord");

        if(createRecordEvent){ //checking if the event is supported

            if(selectedRecordTypeId){//if recordTypeId is supplied, then set recordTypeId parameter

                createRecordEvent.setParams({

                    "entityApiName": "Opportunity",

                   "recordTypeId": selectedRecordTypeId,

                    "defaultFieldValues": {

                "AccountId": component.get("v.recordId")

                    }

                    

                });

            } else{//else create record under master recordType

                createRecordEvent.setParams({

                    "entityApiName": "Opportunity",

                    "defaultFieldValues": {

                          "AccountId": component.get("v.recordId")

                    }

                });

            }

            createRecordEvent.fire();

        } else{

            alert('This event is not supported');

        }

  
    },

    
 /*   gotourl: function(component, event, helper) {
        alert ('hhhh');
       var evt = $A.get("e.force:navigateToComponent");
        console.log('Event '+evt);

      //  var accountFromId = component.get("v.recordId");

        evt.setParams({

            componentDef:"c:Oppbuttonpage2" ,
            

                        
        });
        evt.fire();

 }, */
    /*

     * closing quickAction modal window

     * */

    closeModal : function(component, event, helper){

      var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();

    }

})