@isTest
private class BoxBPSHandlerTest {
  @isTest
  static void testCanManuallySetFRUP() {
    User newUser = TestHelper.createStandardUser('Bob', 'Smith');
    TestHelper.assignCustomPermission('CanManuallySetFRUP', newUser);
    System.runAs(newUser) {
      Test.startTest();
      Boolean returnValue = BoxBPSHandler.canManuallySetFRUP();
      Test.stopTest();
      system.assert(returnValue, 'Can Set FRUP');
    }
  }

  @isTest
  static void testCanNotManuallySetFRUP() {
    User newUser = TestHelper.createStandardUser('Bob', 'Smith');
    System.runAs(newUser) {
      Test.startTest();
      Boolean returnValue = BoxBPSHandler.canManuallySetFRUP();
      Test.stopTest();
      system.assert(!returnValue, 'Can Not Set FRUP');
    }
  }

  @isTest
  static void testscopedAccessToken() {
    String responseBody = JSON.serialize(new map<String,String>{'access_token' => '12345'});
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(responseBody, 200);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    String returnToken = BoxBPSHandler.scopedAccessToken();
    Test.stopTest();
    system.assert('12345'.equals(returnToken), 'token returned');
  }

  @isTest
  static void testscopedAccessTokenFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 401);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      String returnToken = BoxBPSHandler.scopedAccessToken();
    } catch(AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'exception thrown');
  }

  @isTest
  static void testUpdateRealEstate() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Box_BPS__c box = BoxBPSHandler.createBoxBPSRecord(opp.Id, '1234', '432', 'myTemplate');
    Test.startTest();
    BoxBPSHandler.updateRealEstate(opp.Id, 55.00);
    Test.stopTest();
    box = BoxBPSHandler.getBoxBPSRecord(opp.Id);
    system.assert(box.Real_Estate_Status__c == 55.00, 'status set');
  }

  @isTest
  static void testUpdatePermitting() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Box_BPS__c box = BoxBPSHandler.createBoxBPSRecord(opp.Id, '1234', '432', 'myTemplate');
    Test.startTest();
    BoxBPSHandler.updatePermitting(opp.Id, 55.00);
    Test.stopTest();
    box = BoxBPSHandler.getBoxBPSRecord(opp.Id);
    system.assert(box.Permitting_Status__c == 55.00, 'status set');
  }

  @isTest
  static void testUpdateInterconnection() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Box_BPS__c box = BoxBPSHandler.createBoxBPSRecord(opp.Id, '1234', '432', 'myTemplate');
    Test.startTest();
    BoxBPSHandler.updateInterconnection(opp.Id, 55.00);
    Test.stopTest();
    box = BoxBPSHandler.getBoxBPSRecord(opp.Id);
    system.assert(box.Interconnection_Status__c == 55.00, 'status set');
  }

  @isTest
  static void testDeleteBoxFolderSuccess() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('success', 204);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    String response = BoxBPSHandler.deleteBoxFolder('1234');
    Test.stopTest();
    system.assert('success'.equalsIgnoreCase(response), 'Delete Success');
  }
  
  @isTest
  static void testDeleteBoxFolderFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 404);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      String response = BoxBPSHandler.deleteBoxFolder('1234');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testDeleteBoxFileSuccess() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('success', 204);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    String response = BoxBPSHandler.deleteBoxFile('1234');
    Test.stopTest();
    system.assert('success'.equalsIgnoreCase(response), 'Delete Success');
  }
  
  @isTest
  static void testDeleteBoxFileFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 404);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      String response = BoxBPSHandler.deleteBoxFile('1234');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testCreateBoxBPSRecord() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Test.startTest();
    Box_BPS__c box = BoxBPSHandler.createBoxBPSRecord(opp.Id, '1234', '432', 'myTemplate');
    Test.stopTest();
    list<Box_BPS__c> boxRecords = [select Id from Box_BPS__c where Id = :box.Id];
    system.assert(!boxRecords.isEmpty(), 'record created');
    system.assert(boxRecords[0].Id == box.Id, 'record record returned');
  }

  @isTest
  static void testNewFileResponseSuccess() {
    String itemResponse = JSON.serialize(getFolderItemsFileResponse());
    Test.startTest();
    BoxBPSHandler.FolderEntry response = BoxBPSHandler.newFileResponse('parentId', itemResponse);
    Test.stopTest();
    system.assert(response != null, 'Response Success');
    system.assert('03456'.equals(response.id) != null, 'Id set');
  }
  
  @isTest
  static void testNewFileResponseFail() {
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      BoxBPSHandler.FolderEntry response = BoxBPSHandler.newFileResponse('parentId', 'responseString');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testGetTemplateFoldersSuccess() {
    String responseBody = JSON.serialize(new map<String,Object>{
      'entries' => new list<Object>{
        new map<String,Object>{
          'id' => '123',
          'name' => 'templateA'
        },
        new map<String,Object>{
          'id' => '345',
          'name' => 'templateB'
        }
      }
    });
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(responseBody, 200);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    list<BoxBPSHandler.Picklist> response = BoxBPSHandler.getTemplateFolders();
    Test.stopTest();
    system.assert(response != null, 'Response Success');
    system.assert(response.size() == 2, 'two templates returned');
  }
  
  @isTest
  static void testGetTemplateFoldersFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 400);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      list<BoxBPSHandler.Picklist> response = BoxBPSHandler.getTemplateFolders();
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testCreateFolderSuccess() {
    String responseBody = JSON.serialize(getFolderEntryResponse());
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(responseBody, 200);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    BoxBPSHandler.FolderEntry response = BoxBPSHandler.createFolder('testFolder', '000');
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }
  
  @isTest
  static void testCreateFolderFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 400);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      BoxBPSHandler.FolderEntry response = BoxBPSHandler.createFolder('testFolder', '000');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testGetOpportunityBoxFrupSuccess() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new box__FRUP__c(
      box__Record_ID__c = opp.Id,
      box__Folder_ID__c = '0001'
    );
    Test.startTest();
    box__FRUP__c response = BoxBPSHandler.getOpportunityBoxFrup(opp.Id);
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }
  
  @isTest
  static void testGetOpportunityBoxFrupFailOpp() {
    
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      box__FRUP__c response = BoxBPSHandler.getOpportunityBoxFrup(null);
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }
  @isTest
  static void testGetOpportunityBoxFrupFailFRUP() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      box__FRUP__c response = BoxBPSHandler.getOpportunityBoxFrup(opp.Id);
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testCloneTemplateFolderSuccess() {
    String responseBody = JSON.serialize(getFolderEntryResponse());
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(responseBody, 200);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Test.startTest();
    BoxBPSHandler.Entry response = BoxBPSHandler.cloneTemplateFolder('123', '000');
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }
  
  @isTest
  static void testCloneTemplateFolderFail() {
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock('fail', 400);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      BoxBPSHandler.Entry response = BoxBPSHandler.cloneTemplateFolder('123', '000');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testCloneTemplateFolderFailShare() {
    list<Object> sequenceResponse = new list<Object>{
      new map<String,Object>{
        'body' => JSON.serialize(getFolderEntryResponse()),
        'code' => 200
      },
      new map<String,Object>{
        'body' => JSON.serialize(new map<String,Object>{
          'context_info' => new map<String,Object>{
            'errors' => new list<Object>{
              new map<String,Object>{
                'message' => 'bad share'
              }
            }
          }
        }),
        'code' => 400
      }
    };
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(sequenceResponse);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      BoxBPSHandler.Entry response = BoxBPSHandler.cloneTemplateFolder('123', '000');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testupdateFolderEntrySuccessNew() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Details__c = null
    );
    String itemResponse = JSON.serialize(getFolderItemsFileResponse());
    BoxBPSHandler.FolderEntry responseEntry = BoxBPSHandler.newFileResponse('parentId', itemResponse);
    Test.startTest();
    String response = BoxBPSHandler.updateFolderEntry(opp.Id, JSON.serialize(new list<BoxBPSHandler.FolderEntry>{responseEntry}));
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }

  @isTest
  static void testupdateFolderEntrySuccessUpdate() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Details__c = JSON.serialize(new list<BoxBPSHandler.EntryDetail>{getEntryDetail()})
    );
    String itemResponse = JSON.serialize(getFolderItemsFileResponse());
    BoxBPSHandler.FolderEntry responseEntry = BoxBPSHandler.newFileResponse('parentId', itemResponse);
    Test.startTest();
    String response = BoxBPSHandler.updateFolderEntry(opp.Id, JSON.serialize(new list<BoxBPSHandler.FolderEntry>{responseEntry}));
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }
  
  @isTest
  static void testupdateFolderEntryFail() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Details__c = null
    );
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      String response = BoxBPSHandler.updateFolderEntry(opp.Id, 'failString');
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown');
  }

  @isTest
  static void testGetFoldersAndFilesSuccess() {
    list<Object> sequenceResponse = new list<Object>{
      new map<String,Object>{
        'body' => JSON.serialize(getFolderItemsResponse()),
        'code' => 200
      },
      new map<String,Object>{
        'body' => JSON.serialize(getFolderItemsFileResponse()),
        'code' => 200
      }
    };
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(sequenceResponse);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Id__c = '0001',
      Folder_Details__c = JSON.serialize(new list<BoxBPSHandler.EntryDetail>{getEntryDetail()})
    );
    Test.startTest();
    list<BoxBPSHandler.FolderEntry> response = BoxBPSHandler.getFoldersAndFiles(opp.Id);
    Test.stopTest();
    system.assert(response != null, 'Response Success');
  }

  @isTest
  static void testGetFoldersAndFilesBadDetails() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Details__c = '[this looks bad]'
    );
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      list<BoxBPSHandler.FolderEntry> response = BoxBPSHandler.getFoldersAndFiles(opp.Id);
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown, bad details');
  }

  @isTest
  static void testGetFoldersAndFilesBadIdDetails() {
    String responseBody = JSON.serialize(new map<String,Object>{
      'context_info' => new map<String,Object>{
        'errors' => new list<Object>{
          new map<String,Object>{
            'message' => 'bad folder id'
          }
        }
      }
    });
    TestHelper.CalloutMock calloutMock = new TestHelper.CalloutMock(responseBody, 400);
    Test.setMock(HttpCalloutMock.class, calloutMock);
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    insert new Box_BPS__c(
      Record_Id__c = opp.Id,
      Folder_Id__c = '0001',
      Folder_Details__c = JSON.serialize(new list<BoxBPSHandler.EntryDetail>{getEntryDetail()})
    );
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      list<BoxBPSHandler.FolderEntry> response = BoxBPSHandler.getFoldersAndFiles(opp.Id);
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown, bad details');
  }
  
  @isTest
  static void testGetFoldersAndFilesFail() {
    Account account = TestHelper.getAccount('Toms Opp');
    insert account;
    Opportunity opp = TestHelper.getOpportunity(account.Id);
    insert opp;
    Boolean exceptionThrown = false;
    Test.startTest();
    try {
      list<BoxBPSHandler.FolderEntry> response = BoxBPSHandler.getFoldersAndFiles(opp.Id);
    } catch (AuraHandledException e) {
      exceptionThrown = true;
    }
    Test.stopTest();
    system.assert(exceptionThrown, 'Exception Thrown, no bps record');
  }

  private static BoxBPSHandler.EntryDetail getEntryDetail() {
    return (BoxBPSHandler.EntryDetail)JSON.deserialize(
      '{' +
      '    "id": "03456",' +
      '    "status": "complete",' +
      '    "schedule": null,' +
      '    "owner": "bob",' +
      '    "drpush": false,' +
      '    "notes": "some notes"' +
      '}',BoxBPSHandler.EntryDetail.class
    );
  }

  private static BoxHelper.Entry getFolderEntryResponse() {
    return (BoxHelper.Entry)JSON.deserialize(
      '{' +
      '    "type": "folder",' +
      '    "id": "03456",' +
      '    "sequence_id": "345",' +
      '    "etag": "456",' +
      '    "name": "567",' +
      '    "file_version": {"type": "folder", "id": "12", "sha1": "99"},' +
      '    "sha1": "9999"' +
      '}',BoxHelper.Entry.class
    );
  }

  private static BoxHelper.FolderItems getFolderItemsResponse() {
    return (BoxHelper.FolderItems)JSON.deserialize(
      '{' +
      '    "total_count": "1",' +
      '    "entries": [' +
      '        {' +
      '            "type": "folder",' +
      '            "id": "03456",' +
      '            "sequence_id": "345",' +
      '            "etag": "456",' +
      '            "name": "567",' +
      '            "file_version": {"type": "folder", "id": "03456", "sha1": "99"},' +
      '            "sha1": "9999"' +
      '        }' +
      '    ]' +
      '}',BoxHelper.FolderItems.class
    );
  }

  private static BoxHelper.FolderItems getFolderItemsFileResponse() {
    return (BoxHelper.FolderItems)JSON.deserialize(
      '{' +
      '    "total_count": "1",' +
      '    "entries": [' +
      '        {' +
      '            "type": "file",' +
      '            "id": "00123",' +
      '            "sequence_id": "345",' +
      '            "etag": "456",' +
      '            "name": "567",' +
      '            "file_version": {"type": "file", "id": "00123", "sha1": "99"},' +
      '            "sha1": "9999"' +
      '        }' +
      '    ]' +
      '}',BoxHelper.FolderItems.class
    );
  }
}