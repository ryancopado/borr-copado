public without sharing class APIHelper {
  
  public static map<String,Object> apiCallout(String method, String endpoint, map<String,String> headerMap, String bodyString){
    return apiCallout(method, endpoint, headerMap, bodyString, null);
  }

  @testVisible 
  private static String hostPathFix(String inUrl){
    return inUrl.replaceAll('(?<!:)[/]{2}','/');
  }

  private static map<String,Object> apiCallout(String method, String endpoint, map<String,String> headerMap, String bodyString, Integer customTimeout){
    HttpRequest req = new HttpRequest();
    req.setEndpoint(hostPathFix(endpoint));
    req.setMethod(method);
   req.setTimeout(120000);
    if (customTimeout != null) {
    system.debug('time out' +customTimeout );
     // req.setTimeout(customTimeout);
    }
    for(String headerName: headerMap.keySet()) {
      req.setHeader(headerName, headerMap.get(headerName));
    }
    if (String.isNotBlank(bodyString)) {
      req.setBody(bodyString);
    }
    try {
      Http http = new Http();
      system.debug('this is req-->' +req);
      
      HttpResponse response = http.send(req);
      system.debug('this is status-->' +response.getStatusCode());
      system.debug('this is body-->' +response.getBody());
      if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
        return new map<String,Object>{
          'success' => 'success',
          'body' => response.getBody(),
          'status' => response.getStatusCode()
        };
      } else {
        return new map<String,Object>{
          'error' => 'error',
          'body' => response.getBody(),
          'status'=> response.getStatusCode()
        };
      }
    } catch( System.Exception e) {
      return new map<String,Object>{
        'error' => 'Error: System Exception',
        'message' => e.getMessage()
      };
    }
  }

}