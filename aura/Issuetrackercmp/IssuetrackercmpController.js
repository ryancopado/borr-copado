({
	
     fetchListOfRecordTypes: function(component, event, helper) {

        var action = component.get("c.fetchRecordTypeValues");

       //pass the object name here for which you want

        //to fetch record types

        action.setParams({

            "objectName" : "Request_for_Information_RFI__c"

        });

         action.setCallback(this, function(response) {

        //    alert (response.getReturnValue());
            var mapOfRecordTypes = response.getReturnValue();

            component.set("v.mapOfRecordType", mapOfRecordTypes);

            

            var recordTypeList = [];

            //Creating recordTypeList from retrieved Map

            for(var key in mapOfRecordTypes){

                recordTypeList.push(mapOfRecordTypes[key]);

            }

            

            if(recordTypeList.length == 0){//Object does not have any record types

                //Close Quick Action Modal here

                helper.closeModal();
                //Calling CreateRecord modal here without providing recordTypeId

               helper.showCreateRecordModal(component, "", "Request_for_Information_RFI__c");

            } else{

            component.set("v.lstOfRecordType", recordTypeList);

            }

            

        });

        $A.enqueueAction(action);

    },

   createRecord: function(component, event, helper, sObjectRecord) {

        var selectedRecordTypeName = component.find("recordTypePickList").get("v.value");
      //  alert(selectedRecordTypeName);

        if(selectedRecordTypeName != ""){

            var selectedRecordTypeMap = component.get("v.mapOfRecordType");

            var selectedRecordTypeId;

            

            //finding selected recordTypeId from recordTypeName

            for(var key in selectedRecordTypeMap){

                if(selectedRecordTypeName == selectedRecordTypeMap[key]){

                //    alert('if condition satisfying');
                    selectedRecordTypeId = key;//match found, set value in selectedRecordTypeId variable
				//	alert(selectedRecordTypeId);
                    break;

                }

            }
             //Close Quick Action Modal here

           //    helper.closeModal();
            //Calling CreateRecord modal here without providing recordTypeId

           helper.showCreateRecordModal(component, selectedRecordTypeId, "Request_for_Information_RFI__c");
           
        } else{

            alert('You did not select any record type');

        }

        

   },
    
    
     closeModal : function(component, event, helper){

       helper.closeModal();

    }
   

    
    
})