({

    /*

     * This method is being called from init event

     * to fetch all available recordTypes

     * */

    fetchListOfRecordTypes: function(component, event, helper) {

        var action = component.get("c.fetchRecordTypeValues");

        

        //pass the object name here for which you want

        //to fetch record types

        action.setParams({

            "objectName" : "Opportunity"

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

                helper.showCreateRecordModal(component, "", "Opportunity");

            } else{

            component.set("v.lstOfRecordType", recordTypeList);

            }

            

        });

        $A.enqueueAction(action);

    },

    

    /*

     * This method will be called when "Next" button is clicked

     * It finds the recordTypeId from selected recordTypeName

     * and passes same value to helper to create a record

     * */

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

           helper.showCreateRecordModal(component, selectedRecordTypeId, "Opportunity");
           
        } else{

            alert('You did not select any record type');

        }

        

    },

    
    urlmodal:function(component, event, helper,sObjectRecord){
      
         var selectedRecordTypeName = component.find("recordTypePickList").get("v.value");
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
        		
			 if (selectedRecordTypeName  == 'Development' || selectedRecordTypeName == 'Captive/OnSite'){
                    var evt = $A.get("e.force:navigateToComponent");
                    console.log('Event '+evt);

        evt.setParams({

            componentDef:"c:Oppbuttonpage2" ,
            componentAttributes: { myaccountid : component.get("v.recordId"),
                                   myrecordid  : selectedRecordTypeId
                                 }

                        
        });
        evt.fire();
         }else{
             
             helper.showCreateRecordModal(component, selectedRecordTypeId, "Opportunity");
         }
        
       
    },
    /*

     * closing quickAction modal window

     * */

    closeModal : function(component, event, helper){

       helper.closeModal();

    }

})