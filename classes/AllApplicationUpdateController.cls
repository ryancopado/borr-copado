public class AllApplicationUpdateController {
    
    Application__c Application;
    
    public AllApplicationUpdateController(ApexPages.StandardController controller) {
            Application=[Select id,
                            Host__c,
                            Host_Offtaker_Owner_Notes__c,
                            Interconnection_Application__c,
                            Offtaker__c,
                            Owner__c,
                            System_Size_AC_watts__c,
                            System_Size_DC_watts__c,
                            Utility_Project_ID_Notes__c,
                            WO__c,
                            WO_Notes__c
                        From Application__c
                        Where id=:controller.getrecord().id];
        }
    
    public pageReference UpdateAll(){
        List<Application__C> ListOfApplication=[Select id,
                            Host__c,
                            Host_Offtaker_Owner_Notes__c,
                            Interconnection_Application__c,
                            Offtaker__c,
                            Owner__c,
                            System_Size_AC_watts__c,
                            System_Size_DC_watts__c,
                            Utility_Project_ID_Notes__c,
                            WO__c,
                            WO_Notes__c
                        From Application__c
                        Where Interconnection_Application__c=:Application.Interconnection_Application__c
                        and Id!=:Application.ID];
        
        If(ListOfApplication==null || ListOfApplication.size()<=0)
            return ReturnBack();
        
        For(Application__C App:ListOfApplication){
            App.Host__c=Application.Host__c;
            App.Host_Offtaker_Owner_Notes__c=Application.Host_Offtaker_Owner_Notes__c;
            App.Offtaker__c=Application.Offtaker__c;
            App.Owner__c=Application.Owner__c;
            //App.System_Size_AC_watts__c=Application.System_Size_AC_watts__c;
            //App.System_Size_DC_watts__c=Application.System_Size_DC_watts__c;
            App.Utility_Project_ID_Notes__c=Application.Utility_Project_ID_Notes__c;
            //App.WO__c=Application.WO__c;
            App.WO_Notes__c=Application.WO_Notes__c;

        }
                
        Update ListOfApplication;
                
        return ReturnBack();
   }
   
   private Pagereference ReturnBack(){
       PageReference PR=new PageReference('/'+Application.id);
        PR.SetRedirect(true);
        return PR;
   }

}