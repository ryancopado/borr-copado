/**
 * Box helper class called by BoxBPSHandler - the boxRoadmap lwc and its child components
 */
public with sharing class BoxHelper {
  public class BoxHelperException extends Exception{}

  public static final String Named_Cred_SF = 'Named_Cred_SF';
  public static final String Template_Folder_Id = 'Template_Folder_Id';

  private static map<String,String> boxSettingsMap;
  public static String getBoxSetting(String name){
    if (boxSettingsMap == null) {
      boxSettingsMap = new map<String,String>();
      for (Box_Integration__mdt thisSetting : [select DeveloperName, Value__c from Box_Integration__mdt]) {
        boxSettingsMap.put(thisSetting.DeveloperName, thisSetting.Value__c);
      }
    }
    if (!boxSettingsMap.containsKey(name)) {
      throw new BoxHelperException('Box Setting ' + name + ' is missing');
    }
    return boxSettingsMap.get(name);
  }

  public static String getBaseURL() {
    return (Test.isRunningTest() ? 'https://callout.' : 'callout:') + getBoxSetting(Named_Cred_SF);
  }

  public class ScopedAccess {
    public String access_token {get;private set;}
  }

  // return an access token with privledge to upload and update only due to 'scope' attribute  
  public static ScopedAccess getDownscopeAccess() {
    String method = 'POST';
    String url = getBaseURL() + '/oauth2/token';
    url = String.format(url, new list<String>{getBoxSetting(Template_Folder_Id)});
    map<String,String> headerMap = new map<String,String>{
      'Content-Type' => 'application/x-www-form-urlencoded'
    }; 
    String bodyString = 'subject_token_type=urn:ietf:params:oauth:token-type:access_token' 
    + '&subject_token={!$Credential.OAuthToken}'
    + '&scope=item_upload item_rename'
    + '&grant_type=urn:ietf:params:oauth:grant-type:token-exchange';
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, bodyString);
    ScopedAccess access = (ScopedAccess) JSON.deserialize((String)responseMap.get('body'), ScopedAccess.class);
    return access;
  }

  public static map<String,Object> getTemplateFolderItems() {
    String method = 'GET';
    String url = getBaseURL() + '/2.0/folders/{0}/items';
    url = String.format(url, new list<String>{getBoxSetting(Template_Folder_Id)});
    map<String,String> headerMap = new map<String,String>{};
    map<String,Object> returnMap = APIHelper.apiCallout(method, url, headerMap, '');
    return returnMap;
  }

  public class FolderItems {
    public String total_count {get;private set;}
    public list<Entry> entries {get;private set;}
  }

  public class Entry {
    public String type {get;private set;}
    public String id {get;private set;}
    public String sequence_id {get;private set;}
    public String etag {get;private set;}
    public String name {get;private set;}
    public FileVersion file_version {get;private set;}
    public String sha1 {get;private set;}
  }

  public class FileVersion {
    public String type {get;private set;}
    public String id {get;private set;}
    public String sha1 {get;private set;}
  }
  
  public static FolderItems getFolderItems(String folderId) {
    String method = 'GET';
    String url = getBaseURL() + '/2.0/folders/{0}/items';
    url = String.format(url, new list<String>{folderId});
    map<String,String> headerMap = new map<String,String>{};
    
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, '');
    if (responseMap.containsKey('success')) {
      FolderItems responseItems = (FolderItems) JSON.deserialize((String)responseMap.get('body'), FolderItems.class);
      if (responseItems != null) {
        return responseItems;
      } else {
        throw new BoxHelperException('Response JSON Error.');
      }
    } else {
      if (responseMap.containsKey('body') ) {
         String responseBody = (String)responseMap.get('body');
         map<String,Object> errorBodyMap = !String.isBlank(responseBody) ? (map<String,Object>) JSON.deserializeUntyped(responseBody) : null;
         if (errorBodyMap != null && errorBodyMap.containsKey('context_info')) {
          map<String,Object> errorsObj = (map<String,Object>)errorBodyMap.get('context_info');
          list<Object> errorObjList = (list<Object>)errorsObj.get('errors');
          map<String,Object> firstError = (map<String,Object>) errorObjList[0];
          String errorMessage = (String) firstError.get('message');
          throw new BoxHelperException('Error: ' + errorMessage);
         } else {
          throw new BoxHelperException('Error: ' + errorBodyMap != null ? JSON.serialize(errorBodyMap) : responseBody);

         }
      }
      throw new BoxHelperException('Error: ' + (String)responseMap.get('body'));
    }
  }

  public static String createFolderShareLink(String folderId) {
    String method = 'PUT';
    String url = getBaseURL() + '/2.0/folders/{0}';
    url = String.format(url, new list<String>{folderId});
    map<String,String> headerMap = new map<String,String>{
      'Content-Type' => 'application/json'
    }; 
    
    map<String,Object> bodyMap = new map<String,Object>{
      'shared_link' => new map<String,Object>{
        'access' => 'company',
        'effective_access' => 'company',
        'effective_permission' => 'can_download'
      }
    };
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, JSON.serialize(bodyMap));
    if (responseMap.containsKey('success')) {
      return 'success';
    } else {
      if (responseMap.containsKey('body') ) {
         String responseBody = (String)responseMap.get('body');
         map<String,Object> errorBodyMap = !String.isBlank(responseBody) ? (map<String,Object>) JSON.deserializeUntyped(responseBody) : null;
         if (errorBodyMap != null && errorBodyMap.containsKey('context_info')) {
          try {
            map<String,Object> errorsObj = (map<String,Object>)errorBodyMap.get('context_info');
            list<Object> errorObjList = (list<Object>)errorsObj.get('errors');
            map<String,Object> firstError = (map<String,Object>) errorObjList[0];
            String errorMessage = (String) firstError.get('message');
            throw new BoxHelperException('Error: ' + errorMessage);
          } catch (Exception e) {
            throw new BoxHelperException('Error: ' + (String)errorBodyMap.get('context_info'));
          }
         } else {
          throw new BoxHelperException('Error: ' + errorBodyMap != null ? JSON.serialize(errorBodyMap) : responseBody);

         }
      }
      throw new BoxHelperException('Error: ' + (String)responseMap.get('body'));
    }
  }

  public static Entry copyFolder(String folderId, String newParentId, String newFolderName) {
    String method = 'POST';
    String url = getBaseURL() + '/2.0/folders/{0}/copy';
    url = String.format(url, new list<String>{folderId});
    map<String,String> headerMap = new map<String,String>{
      'Content-Type' => 'application/json'
    }; 
    
    map<String,Object> bodyMap = new map<String,Object>{
      'name' => newFolderName,
      'parent' => new map<String,Object>{
        'id' => newParentId
      }
    };
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, JSON.serialize(bodyMap));
    if (responseMap.containsKey('success')) {
      Entry responseEntry = (Entry) JSON.deserialize((String)responseMap.get('body'), Entry.class);
      if (responseEntry != null && responseEntry.id != null) {
        return responseEntry;
      } else {
        throw new BoxHelperException('copyFolder: unable to create entry');
      }
    } else {
      if (responseMap.containsKey('body')) {
         map<String,Object> errorBodyMap = (map<String,Object>) JSON.deserializeUntyped((String)responseMap.get('body'));
         if (errorBodyMap.containsKey('context_info')) {
          throw new BoxHelperException('copyFolder: ' + String.valueOf(errorBodyMap.get('context_info')));
         } else {
           throw new BoxHelperException('copyFolder: ' + JSON.serialize(errorBodyMap));
         }
      }
      throw new BoxHelperException('copyFolder: ' + (String)responseMap.get('message'));
    }
  }

  public static Entry createNewFolder(String folderName, String parentFolderId) {
    String method = 'POST';
    
    String url = getBaseURL() + '/2.0/folders';
    map<String,String> headerMap = new map<String,String>{ 
      'Content-Type' => 'application/json'
    };
    map<String,Object> bodyMap = new map<String,Object>{
      'name' => folderName,
      'parent' => new map<String,Object>{
        'id' => parentFolderId
      }
    };
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, JSON.serialize(bodyMap));
    if (responseMap.containsKey('success')) {
      Entry responseEntry = (Entry) JSON.deserialize((String)responseMap.get('body'), Entry.class);
      if (responseEntry != null && responseEntry.id != null) {
        return responseEntry;
      } else {
        throw new BoxHelperException('createNewFolder: unable to create entry');
      }
    } else {
      if (responseMap.containsKey('body')) {
        system.debug('responseMap' +  responseMap);
        map<String,Object> errorBodyMap = (map<String,Object>) JSON.deserializeUntyped((String)responseMap.get('body'));
         if (errorBodyMap.containsKey('context_info')) {
          try {
            map<String,Object> errorsObj = (map<String,Object>)errorBodyMap.get('context_info');
            list<Object> errorObjList = (list<Object>)errorsObj.get('errors');
            map<String,Object> firstError = (map<String,Object>) errorObjList[0];
            String errorMessage = (String) firstError.get('message');
            throw new BoxHelperException('createNewFolder: ' + errorMessage);
          } catch (Exception e) {
            throw new BoxHelperException('createNewFolder: ' + (String)errorBodyMap.get('context_info'));
          }
         } else {
          throw new BoxHelperException('createNewFolder: ' + JSON.serialize(errorBodyMap));

         }
      }
      system.debug('responseMap' +  responseMap);
      throw new BoxHelperException('createNewFolder: ' + (String)responseMap.get('message'));
    }
  }

  public static String deleteFolder(String folderId) {
    String method = 'DELETE';
    
    String url = getBaseURL() + '/2.0/folders/{0}?recursive=true';
    url = String.format(url, new list<String>{folderId});
    map<String,String> headerMap = new map<String,String>{ 
      'Content-Type' => 'application/json'
    };
    
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, '');
    if (responseMap.containsKey('success') && (Integer)responseMap.get('status') == 204) {
      return 'success';
    } else {
      if (responseMap.containsKey('body')) {
        throw new BoxHelperException('deleteFolder: ' + JSON.serialize(responseMap));
      }
      throw new BoxHelperException('deleteFolder: ' + (String)responseMap.get('message'));
    }
  }

  public static String deleteFile(String fileId) {
    String method = 'DELETE';
    
    String url = getBaseURL() + '/2.0/files/{0}';
    url = String.format(url, new list<String>{fileId});
    map<String,String> headerMap = new map<String,String>{ 
      'Content-Type' => 'application/json'
    };
    
    map<String,Object> responseMap = APIHelper.apiCallout(method, url, headerMap, '');
    if (responseMap.containsKey('success') && (Integer)responseMap.get('status') == 204) {
      return 'success';
    } else {
      if (responseMap.containsKey('body')) {
        throw new BoxHelperException('deleteFile: ' + JSON.serialize(responseMap));
      }
      throw new BoxHelperException('deleteFile: ' + (String)responseMap.get('message'));
    }
  }
  
  public static Entry newFileCreated(String responseString) {
    FolderItems responseItems = (FolderItems) JSON.deserialize(responseString, FolderItems.class);
    if (responseItems.entries != null && !responseItems.entries.isEmpty()) {
      return responseItems.entries[0];
    } else {
      throw new BoxHelperException('createNewFile: unable to create entry');
    }
  }
}