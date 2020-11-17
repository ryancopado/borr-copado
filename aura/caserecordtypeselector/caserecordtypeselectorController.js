({

    /*

     * This method is being called from init event

     * to fetch all available recordTypes

     * */

    fetchListOfRecordTypes: function(component, event, helper) {
        
    var conid= component.get("v.getconid");
        //alert(conid);
        var action = component.get("c.fetchRecordTypeValues");

        
         action.setParams({ "objectname": component.get("v.getconid")});

        //pass the object name here for which you want

        //to fetch record types

        //action.setParams({

           // "objectname" : conid

       // });

        

        action.setCallback(this, function(response) {

        //    alert (response.getReturnValue());
            var mapOfRecordTypes = response.getReturnValue();

            component.set("v.mapOfRecordType", mapOfRecordTypes);

            

            var recordTypeList = [];

            //Creating recordTypeList from retrieved Map

            for(var key in mapOfRecordTypes){

                recordTypeList.push(mapOfRecordTypes[key]);

            }

            

            if(recordTypeList.length == 0){
                alert('entering if');
                //Object does not have any record types

                //Close Quick Action Modal here

                helper.closeModal();

                

                //Calling CreateRecord modal here without providing recordTypeId

                helper.showCreateRecordModal(component, "", "Case");

            } else{

            component.set("v.lstOfRecordType", recordTypeList);

            }

            

        });

        $A.enqueueAction(action);

    },
     caseeditpage:function(component, event, helper){
         //alert('this is caseeditpage');
         var conid= component.get("v.getconid");
          var selectedRecordTypeName = component.find("recordTypePickList").get("v.value");
         if(selectedRecordTypeName != ""){
              var selectedRecordTypeMap = component.get("v.mapOfRecordType");
              var selectedRecordTypeId;
             
             for(var key in selectedRecordTypeMap){

                if(selectedRecordTypeName == selectedRecordTypeMap[key]){

                 //alert('if condition satisfying');
                    selectedRecordTypeId = key;//match found, set value in selectedRecordTypeId variable
			
                    break;
                }

                }
             
    
          var action = component.get("c.editpage");
          action.setParams({ "contractid": component.get("v.getconid")});
          action.setCallback(this, function(response) {
              
             var state = response.getState();
              
               if(state === "SUCCESS"){
                              
               var getvalues = response.getReturnValue();
               var JSONStr = JSON.stringify(getvalues);
               var jsonString = JSON.parse(JSONStr);
               for (var i = 0; i < jsonString.length; i++) {
                   
                   var servicecontract = jsonString[i].Id;
                   var project = jsonString[i].ASProject__c;
                   var account = jsonString[i].AccountId;
                   var branch=jsonString[i].Branch__c;
               }

                   var createnewRec = $A.get("e.force:createRecord");
                   createnewRec.setParams({

        "entityApiName": "Case",
    
            "defaultFieldValues": { AccountId	 : account,
                                   Project__c  : project,
                                   ServiceContract_Case__c:servicecontract,
                                   Branch__c:branch,
                                   RecordTypeId:selectedRecordTypeId
                        } });
   
createnewRec.fire();

     }
          });
                $A.enqueueAction(action);
         }
         else{
              alert('Please select any Record Type');
         }
     },
     closeFocusedTab : function(component, event, helper) {
     var workspaceAPI = component.find("workspace");
     workspaceAPI.getFocusedTabInfo().then(function(response) {
      var focusedTabId = response.tabId;
            workspaceAPI.closeTab({tabId: focusedTabId});
        })
        .catch(function(error) {
     console.log(error);
        });

    }
})