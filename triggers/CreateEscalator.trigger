trigger CreateEscalator on Contract (after update) {
if(checkRecursive.runOnce())
{
    
 /* this trigger is fired only when the contract enddate changes*/
    
    Contract  cr = Trigger.new[0];

    //for (Contract cr : Trigger.new) {
if(Trigger.oldmap.get(cr.id).EndDate != Trigger.newmap.get(cr.id).EndDate)
{
 List <Service_Contract_Escalator__c> serconesc = new List <Service_Contract_Escalator__c>(); 
List<Service_Contract_Escalator__c> Escalatorrecords = new List<Service_Contract_Escalator__c>();
Service_Contract_Escalator__c escalatorcontractvalue= new Service_Contract_Escalator__c();
List<Service_Contract_Escalator__c> escalatorcontractvalue1= new List<Service_Contract_Escalator__c>();
Contract contractrecords= new contract();

Escalatorrecords=[select id, CY_End__c from Service_Contract_Escalator__c  where  Service_Contract__c=:cr.id and CY_End__c= :cr.EndDate]; //this list will be empty since we are checking for escalator records for the changing end date.
/*if(Test.isRunningTest()){
Escalatorrecords=[select id, CY_End__c from Service_Contract_Escalator__c  where  Service_Contract__c=:cr.id limit 1];
}*/
if(Escalatorrecords.isEmpty())
{
contractrecords=[select ContractTermYears__c,Escalator__c,Solar_Electrician_1__c,Labor_Escalator__c,Solar_Electrician_1_OT__c,Solar_Electrician_2__c,Regional_Manager__c,Solar_Engineer__c,Solar_Engineer_OT__c from Contract where id=:cr.id];
decimal mydeci = contractrecords.ContractTermYears__c;
Integer contractTerms= mydeci.intValue();
escalatorcontractvalue1=[select CurrentYearContractValue__c,Current_Year1__c,Year__c,Current_Year_Solar_Electrician_1_Rate__c,Current_Year_Solar_Electrician_1_OT_Ra__c,Current_Year_Solar_Electrician_2_OT_Ra__c,Current_Year12__c,Current_Year_Solar_Engineer_OT_Rate__c,Current_Year__c from Service_Contract_Escalator__c where Service_Contract__c=:cr.id order by Year__c DESC Limit 1];
if(escalatorcontractvalue1.size()>0)
{
escalatorcontractvalue=[select CurrentYearContractValue__c,Current_Year1__c,Year__c,Current_Year_Solar_Electrician_1_Rate__c,Current_Year_Solar_Electrician_1_OT_Ra__c,Current_Year_Solar_Electrician_2_OT_Ra__c,Current_Year12__c,Current_Year_Solar_Engineer_OT_Rate__c,Current_Year__c from Service_Contract_Escalator__c where Service_Contract__c=:cr.id order by Year__c DESC Limit 1];

 //for(integer i=0;i<contractTerms;i++)
   //{
   system.debug('List' +escalatorcontractvalue);
   
    Service_Contract_Escalator__c con = new Service_Contract_Escalator__c();
    
       system.debug('this is labor--->'  +con.Labor_Escalator__c);
       system.debug('this is contact labour-->' +contractrecords.Labor_Escalator__c);
       ////changes made to labor escalator value when it's null
     if (con.Labor_Escalator__c == null){
           con.Labor_Escalator__c = 0;
       } 
     if (contractrecords.Labor_Escalator__c ==null){
          contractrecords.Labor_Escalator__c = 0;
       }
  
    decimal myyear =  escalatorcontractvalue.Year__c+1;  
    integer year = myyear.intValue();
    con.Year__c=year;
    escalatorcontractvalue.Year__c=year;
       con.Service_Contract__c=cr.id;
    
    con.PriorYearContractValue__c=escalatorcontractvalue.CurrentYearContractValue__c;
    con.Solar_Electrician_1_Rate1__c=escalatorcontractvalue.Current_Year_Solar_Electrician_1_Rate__c;
    con.Prior_Year_Solar_Electrician_1_OT_Rate__c=escalatorcontractvalue.Current_Year_Solar_Electrician_1_OT_Ra__c;
    con.Prior_Year_Solar_Electrician_2_Rate__c=escalatorcontractvalue.Current_Year__c;
    con.Prior_Year__c=escalatorcontractvalue.Current_Year_Solar_Electrician_2_OT_Ra__c;
    con.Prior_Year1__c=escalatorcontractvalue.Current_Year1__c;
    con.Prior_Year12__c=escalatorcontractvalue.Current_Year12__c;
    con.Prior_Year_Solar_Engineer_OT_Rate__c=escalatorcontractvalue.Current_Year_Solar_Engineer_OT_Rate__c;
    con.Labor_Escalator__c=contractrecords.Labor_Escalator__c;
    con.Current_Year_Solar_Electrician_1_Rate__c=con.Solar_Electrician_1_Rate1__c+(con.Solar_Electrician_1_Rate1__c*con.Labor_Escalator__c/100);
    con.Current_Year_Solar_Electrician_1_OT_Ra__c=con.Prior_Year_Solar_Electrician_1_OT_Rate__c+(con.Prior_Year_Solar_Electrician_1_OT_Rate__c*con.Labor_Escalator__c/100);
    con.Current_Year_Solar_Electrician_2_OT_Ra__c=con.Prior_Year__c+(con.Prior_Year__c*con.Labor_Escalator__c/100);
    con.Current_Year12__c=con.Prior_Year12__c+(con.Prior_Year12__c*con.Labor_Escalator__c/100);
    con.Current_Year_Solar_Engineer_OT_Rate__c=con.Prior_Year_Solar_Engineer_OT_Rate__c+(con.Prior_Year_Solar_Engineer_OT_Rate__c*con.Labor_Escalator__c/100);
    con.Current_Year__c=con.Prior_Year_Solar_Electrician_2_Rate__c+(con.Prior_Year_Solar_Electrician_2_Rate__c*con.Labor_Escalator__c/100);
    con.Current_Year1__c=con.Prior_Year1__c+(con.Prior_Year1__c*con.Labor_Escalator__c/100);
    con.CurrentYearContractValue__c=con.PriorYearContractValue__c + con.PriorYearContractValue__c*(contractrecords.Escalator__c/100) ;
       //Assinging the values for calculation increamenting inside the for loop
       escalatorcontractvalue.CurrentYearContractValue__c = con.CurrentYearContractValue__c;
       escalatorcontractvalue.Current_Year_Solar_Electrician_1_Rate__c=con.Current_Year_Solar_Electrician_1_Rate__c;
       escalatorcontractvalue.Current_Year_Solar_Electrician_1_OT_Ra__c= con.Current_Year_Solar_Electrician_1_OT_Ra__c;
       escalatorcontractvalue.Current_Year__c= con.Current_Year__c;
       escalatorcontractvalue.Current_Year_Solar_Electrician_2_OT_Ra__c= con.Current_Year_Solar_Electrician_2_OT_Ra__c;
       escalatorcontractvalue.Current_Year1__c=con.Current_Year1__c;
       escalatorcontractvalue.Current_Year12__c=con.Current_Year12__c;
       escalatorcontractvalue.Current_Year_Solar_Engineer_OT_Rate__c=con.Current_Year_Solar_Engineer_OT_Rate__c;
   
    serconesc.add(con);

//}
             insert serconesc;
             
             system.debug('Inserted Escalator' +serconesc);
             /*Service_Contract_Escalator__c currentyear= new Service_Contract_Escalator__c();
             Contract conupdate= new Contract();
             currentyear=[select CurrentYearContractValue__c from Service_Contract_Escalator__c where Year__c=:cr.Year_of_Contract__c and Service_Contract__c=:cr.id]; 
             conupdate.Id=cr.Id;
             conupdate.Current_Year_Contract_Value__c=currentyear.CurrentYearContractValue__c;// ;//updatedcurrentyear;
                     
             Update conupdate;*/
    
}} 
}
}
}