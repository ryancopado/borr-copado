({
  doInit: function(component, event, helper) {
     //alert('this is component 666')

    var action = component.get("c.createcontract");
    action.setParams({ Oppid: component.get("v.recordId") });

    action.setCallback(this, function(response) {
      var state = response.getState();
      alert(state);

      if (state === "SUCCESS") {
       // alert(response.getReturnValue());

        var getvalues = response.getReturnValue();
        var JSONStr = JSON.stringify(getvalues);
        var jsonString = JSON.parse(JSONStr);

        //alert(JSONStr);

        debugger;

        for (var i = 0; i < jsonString.length; i++) {
          var Account = jsonString[i].AccountId;
          var paymentoption = jsonString[i].Payment_Options__c;
          var OMpackage = jsonString[i].O_M_Package__c;
            var Esclatordetails=jsonString[i].Escalator_Details1__c;
            var solarelectrate1=jsonString[i].Solar_Electrician_1_Rate__c;
            var solarelectrateOT1=jsonString[i].Solar_Electrician_1_OT_Rate__c;
            var solarelectrate2=jsonString[i].Solar_Electrician_2_Rate__c;
            var solarelectrateOT2=jsonString[i].Solar_Electrician_2_OT_Rate__c;
            var solarengineerrate=jsonString[i].Solar_Engineer_Rate__c;
            var solarengineerOTrate=jsonString[i].Solar_Engineer_Rate_OT_Rate__c;
            var internal=jsonString[i].Internal_Prevailing_Wage__c;
            var travel=jsonString[i].Travel_Billable__c;
            var travelbilling=jsonString[i].Travel_Billing_Cap_Hours__c;
            var equipmentrental=jsonString[i].Equipment_Rental_Included1__c;
            var costlandscaping=jsonString[i].Cost_for_Added_Landscaping_per_Visit__c;
            var costmodulewashing=jsonString[i].Cost_for_Added_Module_Washing_per_Wash__c;
            var costsnowremoval=jsonString[i].Cost_for_Added_Snow_Removal_per_Visit__c;
            var PMvisit=jsonString[i].Primary_PM_Visits__c;
          var SecondPMVisit= jsonString[i].Secondary_PM_Visits__c;
           var modulewashing=jsonString[i].Modules_Washings_per_Year__c;
           var landscapingvisit=jsonString[i].Landscaping_Visits_per_Year__c;
           var snowremoval=jsonString[i].Snow_Removal_Included__c;
           var contractamt=jsonString[i].Amount;
           var name=jsonString[i].Name;
           var guarntee=jsonString[i].Guarantee_Start_Date__c;
           var guaranteestatus=jsonString[i].Guarantee_Status__c;
           var link=jsonString[i].Link_to_Performance_Model__c;
           var penaltyrate=jsonString[i].Penalty_Rate_kWh__c;
           var escl=jsonString[i].Escalator__c;
           var regionalmanagerrate=jsonString[i].Regional_Manager_Rate__c;
           var reportingrequirements=jsonString[i].Reporting_Requirements__c;
            var tar=jsonString[i].Tariff__c;
            var preapproval=jsonString[i].Preapproval_Level__c;
             var hvac=jsonString[i].HVAC_Included__c;
            var fire=jsonString[i].Fire_Suppression_Included__c;
           var X24= jsonString[i].X24_Hour_Response_kW__c;
           var X48= jsonString[i].X48_Hour_Response_kW__c;
            var X72=jsonString[i].X72_Hour_Response_kW__c;
            var thermal=jsonString[i].Thermal__c;
           var VOC= jsonString[i].VOC_IMP__c;
           var IVC= jsonString[i].IV_Curve__c;
           var transformer= jsonString[i].Transformer_DGA__c;
            var torque=jsonString[i].Torque_Structural__c;
            var tier=jsonString[i].Tier__c;
            var monitor=jsonString[i].Monitoring__c;
            var aerial=jsonString[i].Aerial_Thermal_Inspection__c;
            var id=jsonString[i].Id;
            var equipment=jsonString[i].Material_and_Equipment_Mark_Up__c;
        }

         //alert(paymentoption);
          //alert(OMpackage);
          //alert(contractamt);

        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
          entityApiName: "Contract",
         
          defaultFieldValues: {
            Payment_Options__c: paymentoption,
            O_M_Package__c: OMpackage,
            AccountId: Account,
              Escalator_Details__c:Esclatordetails,
              Solar_Electrician_1__c:solarelectrate1,
              Solar_Electrician_1_OT__c:solarelectrateOT1,
              Solar_Electrician_2__c:solarelectrate2,
              Solar_Electrician_2_OT__c:solarelectrateOT2,
              Solar_Engineer__c:solarengineerrate,
              Solar_Engineer_OT__c:solarengineerOTrate,
              Internal_Prevailing_Wage_Rate__c:internal,
              Travel_Billable__c:travel,
              Travel_Billing_Cap_Hours__c:travelbilling,
              Equipment_Rental_Included__c:equipmentrental,
              Cost_for_Added_Landscaping_per_Visit__c:costlandscaping,
              Cost_for_Added_Module_Washing_per_Wash__c:costmodulewashing,
              Cost_for_Added_Snow_Removal_per_Visit__c:costsnowremoval,
              Full_PM_Visits__c:PMvisit,
              Secondary_PM_Visit__c:SecondPMVisit,
              Modules_Washings_per_Year__c:modulewashing,
              Landscaping_Visits_per_Year__c:landscapingvisit,
              Snow_Removal_Included__c:snowremoval,
              Contract_Amount__c:contractamt,
              Opportunity__c:id,
              Guarantee_Start_Date__c:guarntee,
              Guarantee_Status__c:guaranteestatus,
              Link_to_Performance_Model__c:link,
              Penalty_Rate_kWh__c:penaltyrate,
              Escalator__c:escl,
              Regional_Manager__c:regionalmanagerrate,
              Reporting_Requirements__c:reportingrequirements,
              Tariff__c:tar,
              Preapproved_Level__c:preapproval,
              HVAC_Included__c:hvac,
              Fire_Suppression_Included__c:fire,
              X24_Hour_Response_kW__c:X24,
              X48_Hour_Response_kW__c:X48,
              X72_Hour_Response_kW__c:X72,
              Thermal_Imaging__c:thermal,
              VOC_IMP__c:VOC,
              IV_Curve__c:IVC,
              Transformer_DGA__c:transformer,
              Torque_Structural__c:torque,
              Service_Contract_Tier__c:tier,
              Monitoring_Required__c:monitor,
              Aerial_Thermal_Inspection__c:aerial,
              Material_and_Equipment_Mark_Up__c:equipment
              
                   
              
              
          }
        });
        createRecordEvent.fire();
     //   $A.get("e.force:refreshView").fire();
      } else {
        alert(response.getReturnValue());
      }
    });
    $A.enqueueAction(action);
  }
});