public class rfi_imbed {

    private final Request_for_Information_RFI__c rfi_stored;
    public rfi_imbed(ApexPages.StandardController stdController) {
        this.rfi_stored = (Request_for_Information_RFI__c)stdController.getRecord();
    }
    Request_for_Information_RFI__c rfi = [select Id, Contact__c, ASProject__c, Project_PM__c , OwnerId from Request_for_Information_RFI__c 
                        where Id = :ApexPages.currentPage().getParameters().get('id')]; 
        
        private AcctSeed__Project__c proj;
        private Map <Id, AcctSeed__Project__c> projMap = new Map <Id, AcctSeed__Project__c>();
        private Contact tempContact;
        private User tempUser;
        private User pm;

        public AcctSeed__Project__c getProject(){
                
                try {
                        proj = projMap.get(rfi.ASProject__c);
                }catch (Exception e) {
                        proj = null;
                }
                if (proj == null) {
                        try {
                                proj = [select Name, Id from AcctSeed__Project__c where Id = :rfi.ASProject__c];
                                projMap.put(proj.Id, proj);
                                
                        }catch (Exception e){
                                proj = new AcctSeed__Project__c();
                        }
                }
                return proj;
        }
        public Contact getContact(){
                
                try {
                        tempContact = [select Name, Id from Contact where Id = :rfi.Contact__c];
                        
                }catch (Exception e){
                        tempContact = new Contact();
                }
                return tempContact;
        }
        
        public User getPM(){
                
                try {
                        tempUser = [select Username, Name from User where Id = :rfi.Project_PM__c];
                }catch (Exception e){
                        tempUser = new User();
                }
                return tempUser;
        }
        
        public User getRfiOwner(){
                try {
                        tempUser = [select Username, Name from User where Id = :rfi.OwnerId];
                }catch (Exception e){
                        tempUser = new User();
                }
                return tempUser;
        }

    public String rfiDate {
      get {
        Date StartDate = System.today();
        Datetime temp = Datetime.newInstance(StartDate.year(), StartDate.month(), StartDate.day());
        return temp.format('MM/dd/yyyy');
      }
      set;
    }  
    
    public static testMethod void testImbed() {
        PageReference pageRef = Page.co;
        Test.setCurrentPage(pageRef);

		//MGtest

        //Request_for_Information_RFI__c rfi = [select Id from Request_for_Information_RFI__c LIMIT 1];
        Request_for_Information_RFI__c rfi = TestMethods.getRfi();
        
        ApexPages.currentPage().getParameters().put('id', rfi.Id);
        ApexPages.StandardController con = new ApexPages.StandardController(rfi);
        rfi_imbed ext = new rfi_imbed(con); 
  
        ext = new rfi_imbed(con);
        ext.getProject();
        ext.getContact();
        ext.getPM();
        ext.getRfiOwner();
        String today = ext.rfiDate;
    } 
}