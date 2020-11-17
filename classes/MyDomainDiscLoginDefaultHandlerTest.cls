@isTest
class MyDomainDiscLoginDefaultHandlerTest {
    /* Test Discoverable handler login.
       Create a user with specific email identifier and invoke login.
       Expected : User should be discovered and pagereference should be returned.
     */
    @isTest static void testLogin() {
        // Create user
        String identifierEmail = 'divya@borregosolar.com';
        //createTestUser(identifierEmail);
        Map<String, String> requestAttributes = new Map<String, String>();
        String startUrl = '';
        MyDomainDiscLoginDefaultHandler myDomainDiscLoginDefaultHandler = new MyDomainDiscLoginDefaultHandler();
        // Invoke login method from handler with the email of user created
        PageReference  pageReference = myDomainDiscLoginDefaultHandler.login(identifierEmail, startUrl, requestAttributes);
        // Asser page reference is returned
        System.assertNotEquals(null, pageReference, 'Page reference was not returned');
    }
    @isTest static void testLoginWithInvalidUser() {
        try {
            Map<String, String> requestAttributes = new Map<String, String>();
            String startUrl = '';
            //String uniqueName = getUniqueName();
            String email ='invaliduser@mail.com';
            MyDomainDiscLoginDefaultHandler myDomainDiscLoginDefaultHandler = new MyDomainDiscLoginDefaultHandler();
            // Invoke login method from handler with non-existing user
            myDomainDiscLoginDefaultHandler.login(email, startUrl, requestAttributes);
        }catch (Auth.LoginDiscoveryException loginDiscoveryException) {
            // Assert exception message
            System.assert(loginDiscoveryException.getMessage().contains('No unique user found'), 'message=' + loginDiscoveryException.getMessage());
        }
    }
    @isTest static void testLoginWithInvalidborregouser() {
        try {
            Map<String, String> requestAttributes = new Map<String, String>();
            String startUrl = '';
            //String uniqueName = getUniqueName();
            String email ='abcxyz@borregosolar.com';
            MyDomainDiscLoginDefaultHandler myDomainDiscLoginDefaultHandler = new MyDomainDiscLoginDefaultHandler();
            // Invoke login method from handler with non-existing user
            myDomainDiscLoginDefaultHandler.login(email, startUrl, requestAttributes);
        }catch (Auth.LoginDiscoveryException loginDiscoveryException) {
            // Assert exception message
            System.assert(loginDiscoveryException.getMessage().contains('No unique user found'), 'message=' + loginDiscoveryException.getMessage());
        }
    }
    
     
}