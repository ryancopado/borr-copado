/**

Last update 2010-07-15
labs@salesforce.com

* with sharing added
* squashed bugs around single / multiple updates
* added limits to SOQL -- 100 for Campaigns 1000 for Campaign Members
* fixed custom settings manager
* updated Static Resources 

*/
public with sharing class CampaignCallDownController{
    
    //setup appropriate variables
    private Boolean             hasCampaignID = false;
    private string              thisCampaign;
    private Lead[]              lead; 
    private Contact[]           contact;
    private CampaignMember[]    members; //the members for that campaign
    private Lead[]              relevantLeads; 
    Public List<leadPlusTaskPlusContact>   leadPlusTasks{get;set;}
    private Map<String, Boolean>            callDownColumns;    
    private List<Campaign>      activeCampaigns;
    public String               camp { get;set; } //campaign ID
    public String               status{ get;set; } //status ID
    private Map<String, String> cStatusMap;
    private boolean             cStatusMapIsSet;
    public string               campBackup;
    public string               backRef{ get; set; }
    public list<SelectOption>   owners;
    public string               ownerId{ get; set; }

// Added by Ankur Chopra for Pagination
    public boolean disableNext  { get; set; }
    public boolean disablePrevious { get; set; }
    private integer counter = 0;  //keeps track of the offset
    public integer list_size {get; set;} //sets the page size or number of rows
    public integer total_size {get; set;} //used to show user the total size of the list
    public integer PageNumberVal {get; set;}  //keeps track of the offset
    public integer totalPagesVal {get; set;} //sets the page size or number of rows
    public list<SelectOption> displayList {get; set;}
    public string displayVal {get; set;}

//Code Finish Here 

    
    /**
    *Constructor
    */
    
       //Pagination Code by Ankur
   public CampaignCallDownController( ApexPages.StandardController controller ){
        PageNumberVal = 0;
        totalPagesVal = 0;
  // Pagination Code Ends 
    
//    public CampaignCallDownController(){
        
        relevantLeads = new Lead[ 0 ];
        leadPlusTasks = new leadPlusTaskPlusContact[]{};
        callDownColumns = new Map<String, Boolean>();
        
        //get columns settings and set to Map
        if( ApexPages.currentPage().getUrl() != null ){
            camp = ApexPages.currentPage().getUrl().substring( 1 );
        }
        campBackup = camp;
        backRef = '/apex/CampaignCallDownSettings?var=/' + camp;
        cStatusMap = new Map<String, String>();
        cStatusMapIsSet = false;
        owners = new list<SelectOption>();
        // Pagination Code        
         createDisplayList();
// Pagination code ends
    }
    
    /**
    *Return if has campaign id
    *@return hasCampaignID boolean flag
    */
    public Boolean gethasCampaignID(){
        return hasCampaignID;
    }
        
    // Pagination code by Ankur
      public void createDisplayList(){
        displayVal = '5';
        list_size = Integer.valueOf(displayVal);
        displayList = new list<SelectOption>();
        displayList.add(new SelectOption('50', '50 Records'));
        displayList.add(new SelectOption('100', '100 Records'));
        displayList.add(new SelectOption('200', '200 Records'));
        displayList.add(new SelectOption('400', '400 Records'));
    }
    // Pagination Code Ends
    /**
    *Return the list of owners
    *@return owners
    */
    public List<SelectOption> getowners(){
        return owners;
    }
    
    public void setowners( List<SelectOption> l ){
        owners = l;
    }
    
    /**
    *Update all status and log , retuen page reference for redirection
    *@return null
    */
    public PageReference updateAll(){
        List<leadPlusTaskPlusContact> cleanRecords = new List<leadPlusTaskPlusContact>();
    
         for( leadPlusTaskPlusContact current :leadPlusTasks ){
          //status
          boolean updated = false;
          if(current.statusUpdate != null && current.statusUpdate != current.memStatus){
            //update status
            CampaignMember cm = [Select Id, Status From CampaignMember Where id = :current.MemberId limit 1];
            cm.status = current.statusUpdate;
            update cm;
            
            updated = true;
          }
          if (updated || (current.t.Description != '' && current.t.Description != null)) {
          //log a call
            current.t.Subject = 'Activity--Campaign: '+this.getCampaignName();
            insert current.t;
            updated = true;
          }
          if (!updated) {
            cleanRecords.add(current);
          }      

         } 
         leadPlusTasks = cleanRecords;
        return null;
    }
    
    /**
    *Filter Owners for leads
    */
    private void filterOwner(){
        if( ownerId == null || ownerId == '--ALL--' || leadPlusTasks.size() < 1 )
          return;
        else{
            list<leadPlusTaskPlusContact> newLptList = new list<leadPlusTaskPlusContact>();
            for( leadPlusTaskPlusContact lpt : leadPlusTasks ){
                if( lpt.ownerId == ownerId )
                  newLptList.add(lpt);
            }
            leadPlusTasks = newLptList;
        }
    }
    
     //**************      Added By Ankur Pagination    ****************//
    /****
    Name : createQuery
    Arguments : None
    Return Type : String
    Description : This method is used to generate the querry string on basis of selected filters..
    ****/
    public String createQuery() {                            
        
        String query = 'Select Id, ContactId, LeadId, Status, CampaignId, Campaign.Name,' +
                    +'Lead.Id, Lead.Salutation, Lead.Title, Lead.NAME, Lead.Company, Lead.Phone,'+
                    +'Lead.Street, Lead.State, Lead.PostalCode, Lead.Country, Lead.City, Lead.Fax,'+
                    +'Lead.Email, Lead.OwnerId, Lead.Owner.FirstName, Lead.Owner.LastName, Lead.Owner.Id,'+
                    +'Contact.ID, Contact.AccountId, Contact.Salutation, Contact.Title, Contact.Name,'+ 
                    +'Contact.Phone, Contact.MailingStreet, Contact.MailingState, Contact.MailingPostalCode,'+ 
                    +'Contact.MailingCountry, Contact.MailingCity, Contact.Fax, Contact.Email, Contact.OwnerId,'+
                    +'Contact.Owner.FirstName, Contact.Owner.LastName, Contact.Owner.Id, Contact.Account.name,'+
                    +'Contact.Date_Last_Call_Activity__c'+
                    +' from CampaignMember where CampaignId = :camp';
                    
        if( status != null && status != '--ALL--' ) {
            query += ' AND Status = :status';
        }
        
        query += ' Order by id LIMIT :list_Size OFFSET :counter';
        return query;
    }
    
    /****
    Name : createCountQuery
    Arguments : None
    Return Type : Integer
    Description : This method is used to generate the querry string for total pages count
    ****/
    public Integer createCountVal() {                            
        Integer countVal = 0;
        countVal = [Select count() from CampaignMember where CampaignId = :camp]; 
        if( status != null && status != '--ALL--' ) {
            countVal = [Select count() from CampaignMember where CampaignId = :camp AND Status = :status];
        }
        return countVal;
    }
    
    
    /**
    *Refresh campaign list
    *@return page reference
    */
    public PageReference campaignRefresh(){
    //pagination code
    list_size = Integer.valueOf(displayVal);
    //end here
    
        Map<String, String>ownerMap = new Map<String, String>();
        relevantLeads.clear(); leadPlusTasks.clear(); 
        cStatusMapIsSet = false;
        if ( camp != null && camp.length( ) >3 ){
            //set some variable values
                // pagination code 
                String queryString = createQuery();
            hasCampaignID = true;           
            try{
                
                members = (List<CampaignMember>)Database.query(queryString);
                
                
                
                system.debug('*******list_Size *******'+list_Size );
                system.debug('*******counter*******'+counter);
               
                system.debug('*******queryString*******'+queryString);
                system.debug('*******members *******'+members );
                
                total_size = createCountVal();
                //System.assertequals(counter/list_size,null);
                PageNumberVal = counter/list_size + 1;
                totalPagesVal = getTotalPages(total_size , list_size);
            }catch( Exception e ){
                ApexPages.addMessages( e );
            }
            
            if( members != null && members.size() > 0 )            
                thisCampaign = members[ 0 ].Campaign.Name;
                
            else
                thisCampaign ='';

                                  
                //loop through all leads, add relevent leads and their status
            if(members != null) {
                for ( CampaignMember m : members ){
                    leadPlusTaskPlusContact lpt = new leadPlusTaskPlusContact( m, getcStatusMap( camp ), camp );
                    leadPlusTasks.add( lpt );
                    ownerMap.put( lpt.ownerId, lpt.ownerFirstName + ' ' + lpt.ownerLastName );
                }
            }
            //set owners
            owners = ownerMapToSelectOption( ownerMap );
            //filter for owner
            filterOwner();
          //  if( leadPlusTasks.size() > 1 )
            //    quickSort( 'NAME',0, leadPlusTasks.size()-1 );
        }else{ 
            hasCampaignID=false;
            camp=this.campBackup;
        }
        return null;
    }
    // pagination code ends
            
    
    

   
    // Custom Pick List
   
 
    
    //builds a picklist of user names based on their profile
    public List<selectOption> getMgrs() {
        List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
       options.add(new SelectOption('--None--','--None--'));
       options.add(new SelectOption('Call - without VM','Call - without VM'));
       options.add(new SelectOption('Call - conversation','Call - conversation'));
       options.add(new SelectOption('Call - with message','Call - with message'));
       options.add(new SelectOption('Email','Email'));
       options.add(new SelectOption('In Person Meeting','In Person Meeting'));
       options.add(new SelectOption('Initial on-site meeting','Initial on-site meeting'));
       options.add(new SelectOption('Initial conversation','Initial conversation'));     
       options.add(new SelectOption('Initial meeting','Initial meeting'));
       options.add(new SelectOption('Internal','Internal'));

                  return options; //return the picklist options
 
}
    
    // Custom Pick list
    
    
    
     
    
    
    
    
            
         
    
    /**
    *With a map of owners and return a list of select option
    *@param ownerMap
    *@return returnVal
    */
    private List<SelectOption> ownerMapToSelectOption( Map<String, String> ownerMap ){
        List<SelectOption> returnVal=new List<SelectOption>();
        Set<String> keys = new Set<String>();
        keys = ownerMap.keySet();
        returnVal.add( new SelectOption( '--ALL--', '--ALL--' ));
        for ( String s: keys ){
            returnVal.add( new SelectOption(s, ownerMap.get( s )));
        }
        
        return returnVal;
    }
    
    /**
    *Sort by name
    *@return null
    */
    public PageReference sortByName(){
        if( leadPlusTasks.size() > 1 )
            quickSort( 'NAME',0, leadPlusTasks.size()-1 );
        return null;
    }

    /**
    *Sort by title
    *@return null
    */
    public PageReference sortByTitle(){
        if( leadPlusTasks.size() > 1 )
            quickSort( 'TITLE',0, leadPlusTasks.size()-1 );
        return null;
    }   

    /**
    *Sort by Company
    *@return PageReference = null
    */
    public PageReference sortByCompany(){
        if( leadPlusTasks.size() > 1 )
            quickSort( 'COMPANY',0, leadPlusTasks.size()-1 );
        return null;
    } 
  
    /**
    *Sort by Status
    *@return PageReference = null
    */
    public PageReference sortByStatus(){
        if( leadPlusTasks.size() > 1 )
            quickSort( 'STATUS',0, leadPlusTasks.size()-1 );
        return null;
    } 
    
    /**
    *Implementation of Quick sort
    *@param key
    *@param left
    *@param right
    */
    private void quickSort( String key, integer left, integer right ){
      integer index = partition( key, left, right );
      if ( left < index - 1 )
        quickSort( key, left, index - 1 );
      if (index < right )
        quickSort( key, index, right );
    }
    
    /**
    *Aux method for implement Quick Sort
    *@param key
    *@param left
    *@param right
    *@return i
    */
    private integer partition( String key, integer left, integer right ){
      integer i = left, j = right;
      leadPlusTaskPlusContact tmp;
      leadPlusTaskPlusContact pivot = leadPlusTasks[( left + right ) / 2 ];
      while ( i <= j ){
        while ( compare( key, leadPlusTasks[ i ], pivot ))
          i++;
        while ( compare( key, pivot,leadPlusTasks[ j ]))
          j--;
        if ( i <= j ){
          tmp = leadPlusTasks[ i ];
          leadPlusTasks[  i] = leadPlusTasks[ j ];
          leadPlusTasks[ j ] = tmp;
          i++;
          j--;
        }
      }
      return i;
  }
    
    /**
    *Compare 2 leads
    *@sortKey
    *leadPlusTaskPlusContact
    *leadPlusTaskPlusContact
    *@return Boolean
    */
    private boolean compare( string sortKey, leadPlusTaskPlusContact r1, leadPlusTaskPlusContact r2 ){
       if( sortKey=='TITLE' )
         return r1.TITLE < r2.TITLE;
       else if( sortKey == 'COMPANY' )
         return r1.COMPANY < r2.COMPANY;
       else if( sortKey == 'STATUS')
         return r1.memStatus < r2.memStatus;
       else 
         return r1.NAME < r2.NAME;
    }
    
    /**
    *Return a status map
    *@param cId
    *@return cStatusMap
    */
    public Map<String,String> getcStatusMap( string cId ){
        if( !cStatusMapIsSet ){
            CampaignMemberStatus[] cStatus = [ Select Label From CampaignMemberStatus where campaignId =: cId ]; 
            cStatusMap.clear();
            for ( CampaignMemberStatus s:cStatus )
                cStatusMap.put( s.Label, '' );
            cStatusMapIsSet = true;
        }  
        return cStatusMap;
    }
    
    /**
    *Return campaign items
    *@return options
    */
    public List<SelectOption> getcampaignItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption( '1', 'SELECT' ));
        for( Campaign c:getactiveCampaigns()){
            options.add( new SelectOption( c.ID, c.Name ));
        }
        return options;
    }
   
    /**
    *Return status items option list 
    *@return options
    */
    public List<Selectoption> getstatusItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add( new SelectOption( '--ALL--', '--ALL--' ));
        if ( camp == null || camp == '1' ){
            return options;
            }
        else    {
            for ( String k : getcStatusMap( camp ).keySet())
                options.add( new SelectOption( k, k ));
            return options;
        }
             
    }

    /**
    *Return a list of campaigns options
    *@return activeCampaigns
    */
    public List<Campaign> getactiveCampaigns(){
        if( activeCampaigns == null ){
            activeCampaigns = [ Select Name, Id From Campaign where isActive = true order by name LIMIT 100];
        }
        return activeCampaigns;
    }
    
    /**
    *Return the name
    *@retutn callDownColumns.get('Name')
    */
    public Boolean getName(){
        return callDownColumns.get( 'Name' );
    }
    
    /**
    *Return the campaign name
    */
    public String getCampaignName(){
        if ( hasCampaignID ){
            return thisCampaign;
        } else{
            return 'All Leads';
        }   
    }
        
        // Pagination Code By Ankur
     public PageReference Beginning() { //user clicked beginning
      counter = 0;
      campaignRefresh();
      return null;
   }

   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      campaignRefresh();
      return null;
   }

   public PageReference Next() { //user clicked next button
      counter += list_size;
      campaignRefresh();
      return null;
   }

   public PageReference End() { //user clicked end
      counter = total_size - Math.mod(total_size, list_size);
      campaignRefresh();
      return null;
   }

   public Boolean getDisablePrevious() {
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }

   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }

   public Integer getTotalPages(Integer total_size, Integer list_size) {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
   
   //code ends
    /**
    *Return lead Plus Task
    */
    public List<leadPlusTaskPlusContact> getLeadPlusTasks(){
        return leadPlusTasks;   
    }

    
    /**
    * Inner class to wrap Lead or Contact sobject.
    */
    public class leadPlusTaskPlusContact{
        //variable for each piece of the combined record

        public Task t;
        public String memStatus      {get; set;}
        public Map<String, String> localCStatusMap;
        public string ID             {get; set;}
        public string NAME           {get; set;}
        public string TITLE          {get; set;}
        public string SALUTATION     {get; set;}
        public string PHONE          {get; set;}
        public string COMPANY        {get; set;}
        public boolean isAContact    {get; set;}
        public string cORl           {get; set;}
        public string statusUpdate   {get; set;}
        public string memberID       {get; set;}
        public string ADDRESS        {get; set;}
        public string EMAIL          {get; set;}
        public string FAX            {get; set;}
        public string ownerFirstName {get; set;}
        public string ownerLastName  {get; set;}
        public string ownerId        {get; set;}
        public string accountName    {get; set;}
        public string callType       {get; set;}
        public string LASTCALL       {get; set;}
    
        /**
        *Constructor
        *@param m is a campaign member
        *@param statusMap a map of atatuses
        *@param camp id of campaign
        */  
        public leadPlusTaskPlusContact( CampaignMember m, Map<String, String> statusMap, string camp ){
            if ( m.Lead.id != null ){
                cORl = 'lead';
                //l=incomingLead;
                ID = m.Lead.Id;
                NAME = m.Lead.Name;
                TITLE = m.Lead.Title;
                SALUTATION=m.Lead.Salutation;
                PHONE = m.Lead.Phone;
                COMPANY = m.Lead.Company;
                LASTCALL = ' ';
                if( m.Lead.Street != null ){
                    ADDRESS = m.Lead.Street + '<br>';
                    if(m.Lead.City != null){
                        ADDRESS += ', ' +m.Lead.City;
                    }
                    if(m.Lead.State != null){
                        ADDRESS += ', ' +m.Lead.State;
                    }
                    if(m.Lead.PostalCode != null){
                        ADDRESS += ', ' +m.Lead.PostalCode;
                    }
                    if(m.Lead.Country != null){
                        ADDRESS += '<br>'+m.Lead.Country;
                    }
                }   
                else
                    ADDRESS=' ';
                 
                    if(m.Lead.Email != null){
                        EMAIL = '<a href="mailto:' + m.Lead.Email+'">' + m.Lead.Email + ' </a>';    
                    }else{
                        EMAIL =' ';
                    }
                    FAX=m.Lead.Fax;
                    ownerFirstName = m.Lead.Owner.FirstName; ownerLastName = m.Lead.Owner.LastName; 
                    ownerId = m.Lead.OwnerId; 
            }else{
                cORl = 'contact';
           
                if( m.Contact.MailingStreet != null ){
                    ADDRESS = m.Contact.MailingStreet + '<br>';
                    if(m.Contact.MailingCity != null){
                        ADDRESS += ', '+m.Contact.MailingCity;
                    }
                    if(m.Contact.MailingState != null){
                        ADDRESS += ', '+m.Contact.MailingState;
                    }
                    if(m.Contact.mailingPostalCode != null){
                        ADDRESS += ', '+m.Contact.mailingPostalCode;
                    }
                    if(m.Contact.MailingCountry != null){
                        ADDRESS += '<br>' + m.Contact.MailingCountry;
                    }
               }else{
                    ADDRESS = ' ';
               }
                
               ID               = m.Contact.Id;
               NAME             = m.Contact.Name;
               TITLE            = m.Contact.Title;
               SALUTATION       = m.Contact.Salutation;
               PHONE            = m.Contact.Phone;
               LASTCALL         = (m.Contact.Date_Last_Call_Activity__c == null) ? ' ' : m.Contact.Date_Last_Call_Activity__c.format();
               if(m.Contact.Email != null){
                    EMAIL = '<a href="mailto:' + m.Contact.Email + '">' + m.Contact.Email + '</a>';     
               }else{
                    EMAIL = ' ';
               }
               
               FAX              = m.Contact.Fax;
               ownerFirstName   = m.Contact.Owner.FirstName; ownerLastName = m.Contact.Owner.LastName; 
               ownerId          = m.Contact.OwnerId;
               if ( m.Contact.Account.name != null )
                    COMPANY = m.Contact.Account.name;
               else
                  COMPANY = '';
            }
            t = new Task();
            t.ActivityDate = System.today();
            t.WhoId = ID;
            t.Status = 'Completed';
            t.Subject = '';
            t.Description = '';
            if ( m.Lead.id == null ){
                t.WhatId = camp;
            }
            memberID = m.ID;
            memStatus = m.Status;
            localCStatusMap = statusMap;
        }

        /**
        *Return a task
        *@return t
        */
        public Task gett(){
            return t;
        }
        
        /**
        *Set the task propertie
        *@param tsk
        */
        public Void sett( Task tsk ){
            t = tsk;
        }
        
        /**
        *Return member status
        *@return memStatus
        */
        public String getmemStatus(){
            return memStatus;
        }

        /**
        *Return a list of members status values
        */
        public List<SelectOption> getmemStatusValue(){
            List<SelectOption> options = new List<SelectOption>();
            options.add( new SelectOption( memStatus, memStatus )); 
            for( String k: localCStatusMap.keySet()){
                if( k != memStatus )
                    options.add( new SelectOption( k, k ));
            }
            return options;
        }
   
    }
}