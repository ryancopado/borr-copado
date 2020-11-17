@isTest(SeeAllData=true)
public class TestSubmitRequest {
    //Test class for Submit Request(Pricing Request) controller
    static testMethod void testMethod1() 
    {
        Pricing_Tool_Approval__c submitreqList=new Pricing_Tool_Approval__c();
        submitreqList=[SELECT Id FROM Pricing_Tool_Approval__c LIMIT 1];
          String result = submitrequestcontroller.PricepUpdate(submitreqList.Id); //this is calling submit request test  method        
          string result2 = submitrequestcontroller.CancelPR(submitreqList.Id);  // this is calling cancel request test method 
        }
    }