global class MyDomainDiscLoginDefaultHandler implements Auth.MyDomainLoginDiscoveryHandler {

 global PageReference login(String identifier, String startUrl, Map<String, String> requestAttributes) 

{

   if (identifier != null) {
        // Search for user by email
         if(identifier .endsWith('@borregosolar.com'))
         {

        List<User> users = [SELECT Id FROM User WHERE Email = :identifier AND IsActive = TRUE];

        if (!users.isEmpty() && users.size() == 1) {

            return discoveryResult(users[0], startUrl, requestAttributes);

        } else {

            throw new Auth.LoginDiscoveryException('No unique user found. User count=' + users.size());

        }
        }
        else
        {
         List<User> users = [SELECT Id FROM User WHERE Email = :identifier AND IsActive = TRUE];

        if (!users.isEmpty() && users.size() == 1) {
        

            return discoveryResult1(Users[0], startUrl, requestAttributes);  
            

        } else {

            throw new Auth.LoginDiscoveryException('No unique user found. User count=' + users.size());

        }
        
        
        }

    }

    throw new Auth.LoginDiscoveryException('Invalid Identifier');

  }
    private PageReference getSsoRedirect(User user, String startUrl, Map<String, String> requestAttributes) {

    SamlSsoConfig SSO = [select Id from SamlSsoConfig where developerName= 'Google' limit 1];
    String ssoUrl = Auth.AuthConfiguration.getSamlSsoUrl(requestAttributes.get('MyDomainURL'), startUrl, SSO.Id);
    System.debug('requestAttributes>>>>>'+requestAttributes);
    System.debug('SSO>>>>>'+SSO);
    System.debug('ssoUrl >>>>>'+ssoUrl );
    if(ssoUrl!=null || ssoUrl!='') {
        return new PageReference(ssoUrl);
    }
    return null;

  }

     private PageReference discoveryResult(User user, String startUrl, Map<String, String> requestAttributes) 

     {

     PageReference ssoRedirect = getSsoRedirect(user, startUrl, requestAttributes);

      if (ssoRedirect != null) {

        return ssoRedirect;

      } 

      else {

        return Auth.SessionManagement.finishLoginDiscovery(Auth.LoginDiscoveryMethod.password, user.Id);    

      }

   }
   
   private PageReference discoveryResult1(User user, String startUrl, Map<String, String> requestAttributes) 

     {

     

        return Auth.SessionManagement.finishLoginDiscovery(Auth.LoginDiscoveryMethod.password, user.Id);    

      }
      

}