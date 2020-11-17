public class createcontractfromopp {
      @Auraenabled
    public static List<Opportunity> createcontract(Id Oppid){
        
        List<Opportunity>  newlist = new List<Opportunity>();
            
            newlist=[select Id, Amount,AccountId,Payment_Options__c,O_M_Package__c,Escalator_Details1__c,Solar_Electrician_1_Rate__c,Solar_Electrician_1_OT_Rate__c,Solar_Electrician_2_Rate__c,Solar_Electrician_2_OT_Rate__c,Solar_Engineer_Rate__c,
            Solar_Engineer_Rate_OT_Rate__c,Internal_Prevailing_Wage__c,Travel_Billable__c,Travel_Billing_Cap_Hours__c,Equipment_Rental_Included1__c,Cost_for_Added_Landscaping_per_Visit__c,Cost_for_Added_Module_Washing_per_Wash__c,Cost_for_Added_Snow_Removal_per_Visit__c,
           Primary_PM_Visits__c,Secondary_PM_Visits__c,Modules_Washings_per_Year__c,Landscaping_Visits_per_Year__c,Snow_Removal_Included__c,Contract_Amount_yearly__c,Name,
           Guarantee_Start_Date__c,Guarantee_Status__c,Link_to_Performance_Model__c,Penalty_Rate_kWh__c,Escalator__c,Regional_Manager_Rate__c,Reporting_Requirements__c,
           Tariff__c,Preapproval_Level__c,HVAC_Included__c,Fire_Suppression_Included__c,X24_Hour_Response_kW__c,X48_Hour_Response_kW__c,X72_Hour_Response_kW__c,
           Thermal__c,VOC_IMP__c,IV_Curve__c,Transformer_DGA__c,Torque_Structural__c,Tier__c,Monitoring__c,Aerial_Thermal_Inspection__c,Material_and_Equipment_Mark_Up__c from opportunity where id=:Oppid];
        
         return newlist;

}
}