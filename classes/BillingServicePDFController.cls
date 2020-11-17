public class BillingServicePDFController {

    public static Double summaryTaxes { get; set; }
    public static String casenumber { get; set; }
    Public static string attname {get; set;}
    public boolean render{get; set;}
    public static list<contact> getattnames {get;set;}
     Public static string managername {get; set;}
     Public static string custinvoiceinfo {get; set;}
    
      
    public List<AcctSeed__Billing_Line__c> billingLines { get; set; }

    public BillingServicePDFController(ApexPages.StandardController controller) {
        summaryTaxes = 0;
        billingLines = new List<AcctSeed__Billing_Line__c>([
                SELECT Id, Category__c,Description__c,
                        AcctSeed__Hours_Units__c, AcctSeed__Rate__c,
                        AcctSeed__Total__c, AvaAcctSeed__LineTax__c,
                        Case__r.Subject, Case__r.CaseNumber,WorkOrder__r.WorkOrderNumber
                FROM AcctSeed__Billing_Line__c
                WHERE AcctSeed__Billing__c = :controller.getId()
        ]);
        for (AcctSeed__Billing_Line__c currBillingLine : billingLines) {
            if (currBillingLine.AvaAcctSeed__LineTax__c != null) {
                summaryTaxes += currBillingLine.AvaAcctSeed__LineTax__c;
                
            }
            casenumber=currBillingLine.Case__r.CaseNumber;
            
        }
       system.debug('this is main id-->' +controller.getId());
            AcctSeed__Billing__c getscno = new AcctSeed__Billing__c();
           getscno= [select  AcctSeed__Customer__r.Id ,AcctSeed__Customer__r.parentId ,AcctSeed__Customer__r.Name,Service_Contract__c,Service_Contract__r.Regional_Manager_User__c,Customer_Invoicing_Information__c from AcctSeed__Billing__c where id =:controller.getId() ];
           system.debug('this is scid-->' +getscno);
            managername = getscno.Service_Contract__r.Regional_Manager_User__c;
             custinvoiceinfo = getscno.Customer_Invoicing_Information__c;
            string accparentid = getscno.AcctSeed__Customer__r.parentId;
   
           system.debug('get id-->' +accparentid);
        
           getattnames = [SELECT email FROM contact where contact_type__c includes ('O&M Billing Contact') and accountid =:accparentid ];//'0013400001PBfH3'
           system.debug('this is the list'  +getattnames);
        
        if (getscno.AcctSeed__Customer__r.Name == 'C2 Special Situations Group'){
            
            render = true;
            
        }
        
          //   list<contact> getattnames = new list<contact>();
          //  list<ContractContactRole> getattnames = new list<ContractContactRole>();
          //  getattnames = [SELECT Contact.name FROM ContractContactRole where contractid=:getscno.Service_Contract__c  ];
  /*          for (contact getnames :getattnames)
        {
            string a;
            if (a ==''){
                
                attname = getnames.email;
                a=getnames.email
            }
            else{
                attname = attname + ',' +getnames.email;
            }
        }    
         system.debug('final names-->' +attname);*/
       /*    string a ='';
           string b ='';
            for(ContractContactRole getnames :getattnames)
            {
                 system.debug('this is getnames--> ' +getnames.contact.name);
                system.debug('this is a--->' +a);
                system.debug('this is attname--->' +attname);
                if (a == ''){
                    
                    b = getnames.contact.name;
                    a= getnames.contact.name;
                }else if( a != getnames.contact.name){
                    
                    b = b +',' + getnames.contact.name;
                    a= getnames.contact.name;
                }
                
              
                    
                    
                }
               
               
                  attname = b;             */
        
    }
    
}