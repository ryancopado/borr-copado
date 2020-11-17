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

                    "entityApiName": "Request_for_Information_RFI__c",

                   "recordTypeId": selectedRecordTypeId,

                    "defaultFieldValues": {

              			  ASProject__c: component.get("v.recordId")

                    }

                    

                });

            } else{//else create record under master recordType

                createRecordEvent.setParams({

                    "entityApiName": "Request_for_Information_RFI__c",

                    "defaultFieldValues": {

                          ASProject__c: component.get("v.recordId")

                    }

                });

            }

            createRecordEvent.fire();

        } else{

            alert('This event is not supported');

        }

  
    },

    
 closeModal : function(component, event, helper){

      var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();

    }

})