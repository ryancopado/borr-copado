/**
 * Box server controller for the boxRoadmap lwc and its child components
 */
public without sharing class BoxBPSHandler {
  public static String DEFAULT_FOLDER_NAME = label.box_folder_name;
  public static String DEFAULT_STATUS = 'notstarted';
  public static String templateName = 'NY';
  
  @AuraEnabled(cacheable=true)
  public static Boolean canManuallySetFRUP() {
    return FeatureManagement.checkPermission('CanManuallySetFRUP');
  }

  @AuraEnabled
  public static String scopedAccessToken() {
    try {
      BoxHelper.ScopedAccess access = BoxHelper.getDownscopeAccess();
      return access.access_token;
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('scopedAccessToken: unable to get token -' + error.getMessage());
      e.setMessage('scopedAccessToken: unable to get token -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static void updateRealEstate(Id opportunityId, Decimal status) {
    try {
      Box_BPS__c bpsRecord = [select Id, Real_Estate_Status__c from Box_BPS__c where Record_Id__c = :opportunityId];
      bpsRecord.Real_Estate_Status__c = status;
      update bpsRecord;
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('updateRealEstate: unable to set status -' + error.getMessage());
      e.setMessage('updateRealEstate: unable to set status -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static void updatePermitting(Id opportunityId, Decimal status) {
    System.debug('Status: ' + status);
    try {
      Box_BPS__c bpsRecord = [select Id, Permitting_Status__c from Box_BPS__c where Record_Id__c = :opportunityId];
      bpsRecord.Permitting_Status__c = status;
      update bpsRecord;
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('updatePermitting: unable to set status -' + error.getMessage());
      e.setMessage('updatePermitting: unable to set status -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static void updateInterconnection(Id opportunityId, Decimal status) {
    try {
      Box_BPS__c bpsRecord = [select Id, Interconnection_Status__c from Box_BPS__c where Record_Id__c = :opportunityId];
      bpsRecord.Interconnection_Status__c = status;
      update bpsRecord;
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('updateInterconnection: unable to set status -' + error.getMessage());
      e.setMessage('updateInterconnection: unable to set status -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static String deleteBoxFolder(String folderId) {
    try {
      return BoxHelper.deleteFolder(folderId);
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('deleteBoxFolder: unable to delete folder ' + folderId + '-' + error.getMessage());
      e.setMessage('deleteBoxFolder: unable to delete folder ' + folderId + '-' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static String deleteBoxFile(String fileId) {
    try {
      return BoxHelper.deleteFile(fileId);
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('deleteBoxFile: unable to delete file ' + fileId + '-' + error.getMessage());
      e.setMessage('deleteBoxFile: unable to delete file ' + fileId + '-' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static Box_BPS__c createBoxBPSRecord(Id opportunityId, String folderId, String templateId, String templateName) {
    Box_BPS__c returnRecord = new Box_BPS__c (
      Opportunity__c = opportunityId, 
      Record_Id__c = opportunityId, 
      Folder_Id__c = folderId, 
      Template_Id__c = templateId, 
      Template_Name__c = templateName
    );
    upsert returnRecord Record_Id__c;
    return returnRecord;
  }

  @AuraEnabled
  public static FolderEntry newFileResponse(String parentId, String responseString) {
    try {
      BoxHelper.Entry returnEntry = BoxHelper.newFileCreated(responseString);
      return new FolderEntry(returnEntry, parentId);
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('newFileResponse: unable to parse response -' + error.getMessage());
      e.setMessage('newFileResponse: unable to parse response -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled(cacheable=true)
  public static list<Picklist> getTemplateFolders(){
    try {
      list<Picklist> returnList = new list<Picklist>();
      map<String,Object> responseMap = BoxHelper.getTemplateFolderItems();
      map<String,Object> bodyMap = (map<String,Object>) JSON.deserializeUntyped((String)responseMap.get('body'));
      list<Object> entriesObject = (list<Object>) bodyMap.get('entries');
      for (Object currentEntry : entriesObject) {
        map<String,Object> entriesMap = (map<String,Object>) currentEntry;
        returnList.add(new Picklist((String)entriesMap.get('id'), (String)entriesMap.get('name')));
      }
      return returnList;
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('getTemplateFolders: unable to parse response -' + error.getMessage());
      e.setMessage('getTemplateFolders: unable to parse response -' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static FolderEntry createFolder(String folderName, String parentFolderId){
    try{
      BoxHelper.Entry returnEntry = BoxHelper.createNewFolder(folderName, parentFolderId);
      return new FolderEntry(returnEntry, parentFolderId);
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('createFolder: unable to create folder ' + folderName + '-' + error.getMessage());
      e.setMessage('createFolder: unable to create folder ' + folderName + '-' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled(cacheable=true)
  public static box__FRUP__c getOpportunityBoxFrup(Id opportunityId){
    if (opportunityId == null) {
      AuraHandledException e = new AuraHandledException('OpportunityBoxFolderId: opportunity Id is required');
      e.setMessage('OpportunityBoxFolderId: opportunity Id is required'); 
      throw e;
    }
    list<box__FRUP__c> boxList = [select Id, box__Folder_ID__c from box__FRUP__c where box__Record_ID__c = :opportunityId AND box__Folder_ID__c != null];
    if (boxList.size() >= 1) {
      return boxList[0];
    } else {
      AuraHandledException e = new AuraHandledException('OpportunityBoxFolderId: unable to find FRUP for ' + opportunityId);
      e.setMessage('OpportunityBoxFolderId: unable to find FRUP for ' + opportunityId); 
      throw e;
    }
  }

  @AuraEnabled
  public static Entry cloneTemplateFolder(String templateId, String opportunityFolderId){
    if (templateId == null) {
      AuraHandledException e = new AuraHandledException('cloneTemplateFolder: Template Id is required');
      e.setMessage('cloneTemplateFolder: Template Id is required'); 
      throw e;
    }
    if (opportunityFolderId == null) {
      AuraHandledException e = new AuraHandledException('cloneTemplateFolder: Opportunity Folder Id is required');
      e.setMessage('cloneTemplateFolder: Opportunity Folder Id is required'); 
      throw e;
    }
    try {
      BoxHelper.Entry returnEntry = BoxHelper.copyFolder(templateId, opportunityFolderId, DEFAULT_FOLDER_NAME);
      BoxHelper.createFolderShareLink(returnEntry.id); // share the folder with company
      return new Entry(returnEntry, opportunityFolderId);
    } catch (exception error) {
      AuraHandledException e = new AuraHandledException('cloneTemplateFolder: unable to clone ' + templateId + '-' + error.getMessage());
      e.setMessage('cloneTemplateFolder: unable to clone ' + templateId + '-' + error.getMessage()); 
      throw e; 
    }
  }

  @AuraEnabled
  public static String updateFolderEntry(Id opportunityId, String folderEntryString) {
    try {
      list<FolderEntry> folderEntryList = (list<FolderEntry>) JSON.deserialize(folderEntryString, list<FolderEntry>.class);
      map<String,EntryDetail> entryDetailsMap = new map<String,EntryDetail>();
      for (FolderEntry folderEntry : folderEntryList) {
        EntryDetail detail = folderEntry.getFolderDetail();
        entryDetailsMap.put(detail.Id, detail);
      }
      Box_BPS__c bpsRecord;
      for (Box_BPS__c thisRecord : [select Id, Folder_Details__c from Box_BPS__c where Record_Id__c = :opportunityId]) {
        bpsRecord = thisRecord;
        break;
      }
      if (String.isBlank(bpsRecord.Folder_Details__c)) {
        bpsRecord.Folder_Details__c = JSON.serialize(entryDetailsMap.values());
        update bpsRecord;
        return 'success';
      } else {
        list<EntryDetail> detailsList = (list<EntryDetail>)JSON.deserialize(bpsRecord.Folder_Details__c, list<EntryDetail>.class);
        list<EntryDetail> updateList = new list<EntryDetail>();
        for (EntryDetail detail : detailsList) {
          if (!entryDetailsMap.containsKey(detail.Id)) {
            updateList.add(detail);
          }
        }
        updateList.addAll(entryDetailsMap.values());
        bpsRecord.Folder_Details__c = JSON.serialize(updateList);
        update bpsRecord;
        return 'success';
      }
    } catch(exception error) {
      AuraHandledException e = new AuraHandledException('updateFolderEntry: unable to commit details ' + opportunityId + '-' + error.getMessage());
      e.setMessage('updateFolderEntry: unable to commit details ' + opportunityId + '-' + error.getMessage()); 
      throw e;
    }
  }

  @AuraEnabled(cacheable=true)
  public static list<FolderEntry> getFoldersAndFiles(Id opportunityId){
    Box_BPS__c boxRecord;
    
      List<Box_BPS__c> boxOppRecords = [SELECT Id,Opportunity__c,Template_Id__c,Template_Name__c FROM Box_BPS__c WHERE Opportunity__c = :opportunityId LIMIT 1];
    
      if(!boxOppRecords.isEmpty()){
        templateName = boxOppRecords[0].Template_Name__c;
      }
    for (Box_BPS__c thisRecord : [select Id, Folder_Id__c, Folder_Details__c, Record_Id__c from Box_BPS__c where Record_Id__c = :opportunityId]) {
      boxRecord = thisRecord;
      break;
    }
    if (boxRecord != null) {
      try {
        loadEntryDetails(boxRecord); 
        system.debug('loadEntryDetails');
        list<FolderEntry> allItems = getAllFoldersItems(boxRecord.Folder_Id__c);
        system.debug('getAllFoldersItems');
        return allItems;
      } catch (exception e) {
        system.debug(e);
        AuraHandledException err = new AuraHandledException('getFoldersAndFiles: ' + e.getMessage());
        err.setMessage('getFoldersAndFiles: ' + e.getMessage()); 
        throw err;
      }
    } else {
      AuraHandledException err = new AuraHandledException('Opportunity BPS not initialized');
      err.setMessage('Opportunity BPS not initialized'); 
      throw err;
    }
  }

  @AuraEnabled(cacheable=true)
  public static Box_BPS__c getBoxBPSRecord(Id opportunityId){
    for (Box_BPS__c thisRecord : [select Id, Folder_Id__c, Folder_Details__c, Record_Id__c, Real_Estate_Status__c, Permitting_Status__c, Interconnection_Status__c from Box_BPS__c where Record_Id__c = :opportunityId]) {
      return thisRecord;
    }
    return new Box_BPS__c();
  }

  @AuraEnabled
  public static Box_BPS__c getFreshBoxBPSRecord(Id opportunityId){
    for (Box_BPS__c thisRecord : [select Id, Folder_Id__c, Folder_Details__c, Record_Id__c, Real_Estate_Status__c, Permitting_Status__c, Interconnection_Status__c from Box_BPS__c where Record_Id__c = :opportunityId]) {
      return thisRecord;
    }
    return new Box_BPS__c();
  }

  public static list<FolderEntry> getAllFoldersItems(String folderId) {
    try {
      list<FolderEntry> returnList = new list<FolderEntry>();
      BoxHelper.FolderItems returnFolder = BoxHelper.getFolderItems(folderId);
      for (BoxHelper.Entry currentEntry : returnFolder.entries) {
        if ('folder'.equals(currentEntry.type)) {
          returnList.add(new FolderEntry(currentEntry, folderId));
        }
      }
      return returnList;
    } catch (BoxHelper.BoxHelperException e) {
      system.debug(folderId + '- BoxHelperException: ' + e);
      if (e.getMessage().contains('Error: Invalid value')) {
        AuraHandledException err = new AuraHandledException('getAllFoldersItems: unable to find box folder - ' + folderId);
        err.setMessage('getAllFoldersItems: unable to find box folder - ' + folderId); 
        throw err;
      } else {
        throw e;
      }
    } catch (exception e) {
      system.debug(folderId + '- Exception: ' + e);
      throw e;
    }
  }
  
  public static map<String,EntryDetail> entryDetailsMap;
  public static void loadEntryDetails(Box_BPS__c bpsRecord) {
    entryDetailsMap = new map<String,EntryDetail>();
    if (String.isBlank(bpsRecord.Folder_Details__c)) {
      return;
    }
    try {
      list<EntryDetail> detailsList = (list<EntryDetail>)JSON.deserialize(bpsRecord.Folder_Details__c, list<EntryDetail>.class);
      for (EntryDetail detail : detailsList) {
        entryDetailsMap.put(detail.id, detail);
      }
    } catch (exception e) {
      AuraHandledException err = new AuraHandledException('Unable to load details record: ' + bpsRecord.Id);
      err.setMessage('Unable to load details record: ' + bpsRecord.Id); 
      throw err;
    }
  }

  private static map<String,String> boxOwnerMap;
  public static String getDefaultOwner(List<Box_Default_File_Owner__mdt> cmtRecords, String name) {
    if (boxOwnerMap == null) {
      boxOwnerMap = new map<String,String>();
      for (Box_Default_File_Owner__mdt thisSetting : cmtRecords) {
        boxOwnerMap.put(thisSetting.Name__c.trim().toLowerCase(), thisSetting.Owner__c);
      }
    }
    Integer periodCount = name.countMatches('.');
    if (periodCount == 2) {
      name = name.subString(name.indexOf('.') + 1, name.lastIndexOf('.'));
    } else if (periodCount == 1) {
      name = name.subString(0, name.lastIndexOf('.'));
    }
    name = name.trim().toLowerCase();
    return boxOwnerMap.get(name);
  }

  private static map<String,Boolean> boxInternalMap;
  public static Boolean getInternalReview(List<Box_Default_File_Owner__mdt> cmtRecords, String name) {
    if (boxInternalMap == null) {
      boxInternalMap = new map<String,Boolean>();
      for (Box_Default_File_Owner__mdt thisSetting : cmtRecords) {
        boxInternalMap.put(thisSetting.Name__c.trim().toLowerCase(), thisSetting.Needed_for_Internal_Review__c);
      }
    }
    Integer periodCount = name.countMatches('.');
    if (periodCount == 2) {
      name = name.subString(name.indexOf('.') + 1, name.lastIndexOf('.'));
    } else if (periodCount == 1) {
      name = name.subString(0, name.lastIndexOf('.'));
    }
    name = name.trim().toLowerCase();
    return boxInternalMap.get(name);
  }

  private static map<String,Boolean> boxExternalMap;
  public static Boolean getExternalReview(List<Box_Default_File_Owner__mdt> cmtRecords, String name) {
    if (boxExternalMap == null) {
      boxExternalMap = new map<String,Boolean>();
      for (Box_Default_File_Owner__mdt thisSetting : cmtRecords) {
        boxExternalMap.put(thisSetting.Name__c.trim().toLowerCase(), thisSetting.Needed_for_External_Review__c);
      }
    }
    Integer periodCount = name.countMatches('.');
    if (periodCount == 2) {
      name = name.subString(name.indexOf('.') + 1, name.lastIndexOf('.'));
    } else if (periodCount == 1) {
      name = name.subString(0, name.lastIndexOf('.'));
    }
    name = name.trim().toLowerCase();
    return boxExternalMap.get(name);
  }

  public class EntryDetail {
    public String id {get;private set;}
    public String status {get;private set;}
    public Date schedule {get;private set;}
    public String owner {get;private set;}
    public Boolean drpush {get;private set;}
    public String notes {get;private set;}

    public EntryDetail(String id, String status, Date schedule, String owner, Boolean drpush, String notes) {
      this.id = id;
      this.status = status;
      this.schedule = schedule;
      this.owner = owner;
      this.drpush = drpush;
      this.notes = notes;
    }
  }

  public class FolderEntry {
    @AuraEnabled public String id {get;private set;}
    @AuraEnabled public String parentid {get;private set;}
    @AuraEnabled public String type {get;private set;}
    @AuraEnabled public String name {get;private set;}
    @AuraEnabled public String status {get;private set;}
    @AuraEnabled public Date schedule {get;private set;}
    @AuraEnabled public String owner {get;private set;}
    @AuraEnabled public Boolean drpush {get;private set;}
    @AuraEnabled public Boolean internalReview {get;private set;}
    @AuraEnabled public Boolean externalReview {get;private set;}
    @AuraEnabled public String notes {get;private set;}
    @AuraEnabled public list<FolderEntry> children {get;private set;}
    
    public FolderEntry(BoxHelper.Entry inEntry, String parentid) {
      this(inEntry, parentid, false);
    }

    public FolderEntry(BoxHelper.Entry inEntry, String parentid, Boolean isNew) {

      this.id = inEntry.id;
      this.parentid = parentid;
      this.type = inEntry.type;
      this.name = inEntry.name;
      System.debug('Template Name: ' +templateName);
      List<Box_Default_File_Owner__mdt> cmtRecords = [select Name__c, Owner__c, Needed_for_External_Review__c, Needed_for_Internal_Review__c from Box_Default_File_Owner__mdt WHERE Template_Name__c = :templateName];
      if (entryDetailsMap != null && entryDetailsMap.containsKey(this.id)) {
        EntryDetail detail = entryDetailsMap.get(this.id);
        this.status = detail.status;
        this.schedule = detail.schedule;
        this.owner = detail.owner;
        this.drpush = detail.drpush;
        this.notes = detail.notes;
        this.internalReview = getInternalReview(cmtRecords, inEntry.name);
        this.externalReview = getExternalReview(cmtRecords, inEntry.name);
      } else {
        this.status = DEFAULT_STATUS;
        this.schedule = null;
        this.owner = getDefaultOwner(cmtRecords, inEntry.name); // store in map -> name to owner?
        this.drpush = false;
        this.internalReview = getInternalReview(cmtRecords, inEntry.name);
        this.externalReview = getExternalReview(cmtRecords, inEntry.name);
        this.notes = null;
      }
      if (!isNew) {
        this.children = getChildren(this, this.id);
      }
    }

    public EntryDetail getFolderDetail() {
      return new EntryDetail(this.id, this.status, this.schedule, this.owner, this.drpush, this.notes);
    }
  }

  public class Entry {
    @AuraEnabled public String id {get;private set;}
    @AuraEnabled public String parentid {get;private set;}
    @AuraEnabled public String type {get;private set;}
    @AuraEnabled public String name {get;private set;}

    public Entry(BoxHelper.Entry inEntry, String parentid) {
      this.id = inEntry.id;
      this.parentid = parentid;
      this.type = inEntry.type;
      this.name = inEntry.name;
    }
  }
  
  public static list<FolderEntry> getChildren(FolderEntry entry, String parentid) {
    if (!'folder'.equals(entry.type)) {
      return null;
    }
    try {
      BoxHelper.FolderItems folderItem = BoxHelper.getFolderItems(entry.id);
      if (folderItem.entries == null || folderItem.entries.isEmpty()) {
        return null;
      }
      list<FolderEntry> returnList = new list<FolderEntry>();
      for (BoxHelper.Entry childEntry : folderItem.entries) {
        returnList.add(new FolderEntry(childEntry, parentid));
      }
      return returnList;
    } catch (BoxHelper.BoxHelperException e) {
      system.debug(e);
      if (e.getMessage().contains('Error: Invalid value')) {
        AuraHandledException err = new AuraHandledException('getChildren: unable to find box folder - ' + entry.id);
        err.setMessage('getChildren: unable to find box folder - ' + entry.id); 
        throw err;
      } else {
        throw e;
      }
    } catch (exception e) {
      system.debug(e);
      throw e;
    }
  }
  
  public class Picklist {
    @AuraEnabled public String label {get;private set;}
    @AuraEnabled public String value {get;private set;}
    public Picklist(String value, String label) {
      this.value = value;
      this.label = label;
    }
  }
}