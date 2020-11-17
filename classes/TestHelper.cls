@isTest
public class TestHelper {

  public static final Id DEFAULT_PRICEBOOK = Test.getStandardPricebookId();

  private static User newUser;

  public static User createStandardUser(String firstName, String lastName) {
    Profile pf = [Select Id from profile where Name='Standard User']; 
    if (newUser == null) {
      setNewUser();
    }
    User returnUser;
    System.runAs(newUser) {
      String orgId = UserInfo.getOrganizationId(); 
      String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
      Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
      String uniqueName = orgId + dateString + randomId; 
      returnUser = new User(
        firstname = firstName, 
        lastName = lastName, 
        email = uniqueName + '.' + orgId + '@example.com', 
        Username = uniqueName + '.' + orgId + '@example.com', 
        EmailEncodingKey = 'ISO-8859-1', 
        Alias = uniqueName.substring(18, 23), 
        TimeZoneSidKey = 'America/Los_Angeles', 
        LocaleSidKey = 'en_US', 
        LanguageLocaleKey = 'en_US', 
        ProfileId = pf.Id,
        Department = 'Test',
        isActive = true
      ); 
      insert returnUser;
    }
    return returnUser;
  }
  public static User createAdminUser(String firstName, String lastName){
    Profile pf = [Select Id from profile where Name='System Administrator']; 
    if (newUser == null) {
      setNewUser();
    }
    User returnUser;
    System.runAs(newUser) {
      String orgId = UserInfo.getOrganizationId(); 
      String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
      Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
      String uniqueName = orgId + dateString + randomId; 
      returnUser = new User(
        firstname = firstName, 
        lastName = lastName, 
        email = uniqueName + '.' + orgId + '@example.com', 
        Username = uniqueName + '.' + orgId + '@example.com', 
        EmailEncodingKey = 'ISO-8859-1', 
        Alias = uniqueName.substring(18, 23), 
        TimeZoneSidKey = 'America/Los_Angeles', 
        LocaleSidKey = 'en_US', 
        LanguageLocaleKey = 'en_US', 
        ProfileId = pf.Id,
        Department = 'Test',
        isActive = true
      ); 
      insert returnUser;
    }
    return returnUser;
  }
    
  public static void assignCustomPermission(String customerPermission, User assignUser) {
    if (newUser == null) {
      setNewUser();
    }
    System.runAs(newUser) {
      PermissionSet ps = new PermissionSet();
      ps.Name = 'Test';
      ps.Label = 'Test';
      insert ps;
      SetupEntityAccess sea = new SetupEntityAccess();
      sea.ParentId = ps.Id;
      sea.SetupEntityId = [select Id from CustomPermission where DeveloperName = :customerPermission][0].Id;
      insert sea;
      PermissionSetAssignment psa = new PermissionSetAssignment();
      psa.AssigneeId = assignUser != null ? assignUser.Id : UserInfo.getUserId();
      psa.PermissionSetId = ps.Id;
      insert psa;
    }
  }
    
  public static User getNewUser() {
    if (newUser != null ) {
      return newUser;
    }
    setnewUser();
    return newUser;
  }
    
  private static void setNewUser() {
    list<UserRole> portalRoles = [Select Id From UserRole Where PortalType = 'None'];
    newUser = [select id from user where isActive = true AND UserRoleId in :portalRoles AND Profile.Name = 'System Administrator' limit 1];
  }
    
  public static void newContextInsert(list<sObject> objList) {
    if (newUser == null) {
      setNewUser();
    }
    System.runAs(newUser) {
      insert objList;
    }
  }
    
  public static void newContextUpsert(list<sObject> objList) {
    if (newUser == null) {
      setNewUser();
    }
    System.runAs(newUser) {
      upsert objList;
    }
  }
    
  public static Account getAccount(String accountName) {
    return new Account(
      Name = accountName
    );
  }
  public static Contact getContact(String firstName, String lastName, String email, Id accountId) {
    return new Contact(
      FirstName = firstName,
      LastName = lastName,
      Email = email,
      AccountId = accountId
    );
  }
    
  public static Lead getLead(String firstName, String lastName, String CompanyName) {
    return new Lead(
      FirstName = firstName,
      LastName = lastName,
      Company = CompanyName
    );
  }
  
    
  public static Product2 getProduct() {
    return getProduct(null);
  }
    
  public static Product2 getProduct(String currencyISOCode) {
    return new Product2(
      Name = 'newProduct',
      isActive = true
    );
  }
    
  public static Opportunity getOpportunity(Id accountId) {
    return new Opportunity(
      AccountId = accountId,
      Name = 'test Opp',
      StageName = 'Prospecting',
      CloseDate = Date.today().addDays(2),
      Amount = 5000,
      Pricebook2Id = DEFAULT_PRICEBOOK
    );
  }
    
  public static PricebookEntry getPriceBookEntry(Id productId) {
    return new PricebookEntry(
      Pricebook2Id = DEFAULT_PRICEBOOK,
      Product2Id = productId,
      UnitPrice = 10000, 
      IsActive = true 
    );
  }
  
  public class CalloutMock implements HttpCalloutMock {
    public map<String,Object> mockEndpointToResBody;
    public map<String,Integer> mockEndpointToStatusCode;
    public map<String,String> endpointToRequestBody = new map<String,String>();
    public map<String,String> urlParams = new map<String,String>();
    public String message;
    public Integer code;
    public list<Object> sequenceResponse;
    public CalloutMock() {
      this(null,null);
    }
    public CalloutMock(String message, Integer code){
      this.message = message;
      this.code = code;
    }
    public CalloutMock(list<Object> sequenceResponse){
      this.sequenceResponse = sequenceResponse;
    }
    public HTTPResponse respond(HTTPRequest req) {
      String endpoint = req.getEndpoint();
      String urlParam;
      endpointToRequestBody.put(req.getEndpoint(), req.getBody());
      system.debug('endpoint:: ' + endPoint);
      if (!String.isBlank(endpoint) && endpoint.contains('?')) {
        list<String> tempList = endpoint.split('\\?');
        endpoint = tempList[0];
        urlParam = tempList[1];
      }
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      if (this.mockEndpointToResBody != null) {
        if (this.mockEndpointToResBody.get(endpoint) instanceof String) {
          res.setBody((String)this.mockEndpointToResBody.get(endpoint));
        } else if(this.mockEndpointToResBody.get(endpoint) instanceof Blob) {
          res.setBodyAsBlob((Blob)this.mockEndpointToResBody.get(endpoint));
        }
        res.setStatusCode(this.mockEndpointToStatusCode != null ? this.mockEndpointToStatusCode.get(endpoint) : this.code);
      } else if (this.sequenceResponse != null) {
        map<String,Object> responseMap = (map<String,Object>) this.sequenceResponse.remove(0);
        res.setBody((String)responseMap.get('body'));
        res.setStatusCode((Integer)responseMap.get('code'));
      } else {
        res.setBody(this.message);
        res.setStatusCode(this.mockEndpointToStatusCode != null ? this.mockEndpointToStatusCode.get(endpoint) : this.code);

      }

      
      return res;
    }
  }
    
}