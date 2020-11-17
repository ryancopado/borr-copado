public class WhitePagesPro {
	
	/*
	 *	JSON data structures and methods for accessing information from WhitePages Pro.
	 */
	
	// Data strucutres used by more than one WhitePages Pro request
	public class WPP_Error_Class {
		public String message {get; set;}
		public String name {get; set;}
	}
	
	public class WPP_LatLong_Class {
		public String latitude {get; set;}
		public String longitude {get; set;}
		public String accuracy {get; set;}
	}
	
	public class WPP_Phone_Class {
		public String id {get; set;}
		public String phone_number {get; set;}
		public String line_type {get; set;}
	}
	
	public class WPP_AssociatedPeople_Class {
		public String id {get; set;}
		public String name {get; set;}
		public String relation {get; set;}
	}
	
	public class WPP_Address_Class {
		public String id {get; set;}
		public String location_type {get; set;}
		public String street_line_1 {get; set;}
		public String street_line_2 {get; set;}
		public String city {get; set;}
		public String postal_code {get; set;}
		public String zip4 {get; set;}
		public String state_code {get; set;}
		public String country_code {get; set;}
		public WPP_LatLong_Class lat_long {get; set;}
		public String is_active {get; set;}
		public String delivery_point {get; set;}
		public String link_to_person_start_date {get; set;}
		public String link_to_person_end_date {get; set;}
		
		public WPP_Address_Class() {
			lat_long = new WPP_LatLong_Class();
		}
	}
	
	// Find Person API data structures
	public class WPP_FP_Person_Class {
		public String id {get; set;}
		public String name {get; set;}
		public String firstname {get; set;}
		public String middlename {get; set;}
		public String lastname {get; set;}
		public String age_range {get; set;}
		public String gender {get; set;}
		public String type {get; set;}
		public String link_to_address_start_date {get; set;}
		public WPP_Address_Class found_at_address {get; set;}
		public List<WPP_Address_Class> current_addresses {get; set;}
		public List<WPP_Address_Class> historical_addresses {get; set;}
		public List<WPP_Phone_Class> phones {get; set;}
		public List<WPP_AssociatedPeople_Class> associated_people {get; set;}
		
		public WPP_FP_Person_Class() {
			found_at_address = new WPP_Address_Class();
			current_addresses = new List<WPP_Address_Class>();
			historical_addresses = new List<WPP_Address_Class>();
			phones = new List<WPP_Phone_Class>();
			associated_people = new List<WPP_AssociatedPeople_Class>();
		}
	}
	
	public class WPP_FP_FindPerson_Class {
		public String count_person {get; set;}
		public List<WPP_FP_Person_Class> person {get; set;}
		public List<String> warnings {get; set;}
		public WPP_Error_Class error {get; set;}
		
		public WPP_FP_FindPerson_Class() {
			person = new List<WPP_FP_Person_Class>();
			warnings = new List<String>();
			error = new WPP_Error_Class();
		}
	}
	
	public class WPP_FP_Response_Class {
		public String result {get; set;}
		public WPP_FP_FindPerson_Class findPerson {get; set;}
		
		public WPP_FP_Response_Class() {
			findPerson = new WPP_FP_FindPerson_Class();
		}
	}
	
	// Reverse Address API data structures
	public class WPP_RA_Person_Class {
		public String id {get; set;}
		public String name {get; set;}
		public String firstname {get; set;}
		public String middlename {get; set;}
		public String lastname {get; set;}
		public String age_range {get; set;}
		public String gender {get; set;}
		public String type {get; set;}
		public String link_to_address_start_date {get; set;}
		public List<WPP_Phone_Class> phones {get; set;}
		public List<WPP_Address_Class> historical_addresses {get; set;}
		public List<WPP_AssociatedPeople_Class> associcated_people {get; set;}
		
		public WPP_RA_Person_Class() {
			phones = new List<WPP_Phone_Class>();
			historical_addresses = new List<WPP_Address_Class>();
			associcated_people = new List<WPP_AssociatedPeople_Class>();
		}
	}
	
	public class WPP_RA_AssociatedAddress_Class {
		public String id {get; set;}
		public String is_valid {get; set;}
		public String street_line_1 {get; set;}
		public String street_line_2 {get; set;}
		public String city {get; set;}
		public String postal_code {get; set;}
		public String zip4 {get; set;}
		public String state_code {get; set;}
		public String country_code {get; set;}
		public WPP_LatLong_Class lat_long {get; set;}
		public String is_active {get; set;}
		public String is_commercial {get; set;}
		public String is_forwarder {get; set;}
		public String delivery_point {get; set;}
		public List<WPP_RA_Person_Class> current_residents {get; set;}
		public String last_sale_date {get; set;}
		public String total_value {get; set;}
		public List<WPP_RA_Person_Class> owners {get; set;}
		
		public WPP_RA_AssociatedAddress_Class() {
			lat_long = new WPP_LatLong_Class();
			current_residents = new List<WPP_RA_Person_Class>();
			owners = new List<WPP_RA_Person_Class>();
		}
	}
	
	public class WPP_RA_ReverseAddress_Class {
		public String id {get; set;}
		public String is_valid {get; set;}
		public String street_line_1 {get; set;}
		public String street_line_2 {get; set;}
		public String city {get; set;}
		public String postal_code {get; set;}
		public String zip4 {get; set;}
		public String state_code {get; set;}
		public String country_code {get; set;}
		public WPP_LatLong_Class lat_long {get; set;}
		public String is_active {get; set;}
		public String is_commercial {get; set;}
		public String is_forwarder {get; set;}
		public String delivery_point {get; set;}
		public List<WPP_RA_Person_Class> current_residents {get; set;}
		public String last_sale_date {get; set;}
		public String total_value {get; set;}
		public List<WPP_RA_Person_Class> owners {get; set;}
		public List<WPP_RA_AssociatedAddress_Class> associated_addresses {get; set;}
		public WPP_Error_Class error {get; set;}
		public List<String> warnings {get; set;}
		
		public WPP_RA_ReverseAddress_Class() {
			lat_long = new WPP_LatLong_Class();
			current_residents = new List<WPP_RA_Person_Class>();
			owners = new List<WPP_RA_Person_Class>();
			associated_addresses = new List<WPP_RA_AssociatedAddress_Class>();
			error = new WPP_Error_Class();
			warnings = new List<String>();
		}
	}
	
	public class WPP_RA_Response_Class {
		public String result {get; set;}
		public WPP_RA_ReverseAddress_Class reverseAddress {get; set;}
		
		public WPP_RA_Response_Class() {
			reverseAddress = new WPP_RA_ReverseAddress_Class();
		}
	}
	
	public static WPP_FP_Response_Class findPerson(String fullName, String addrStreet1, String addrStreet2, String addrCity, String addrPostalCode, String addrStateCode, String addrCountryCode) {
		String response;
		WPP_FP_Response_Class fpResponse = new WPP_FP_Response_Class();
		
		fpResponse.result = 'SUCCESS';
		
		String name = (String.isBlank(fullName)) ? '' : EncodingUtil.urlEncode(fullName, 'UTF-8');
		String street1 = (String.isBlank(addrStreet1)) ? '' : EncodingUtil.urlEncode(addrStreet1, 'UTF-8');
		String street2 = (String.isBlank(addrStreet2)) ? '' : EncodingUtil.urlEncode(addrStreet2, 'UTF-8');
		String city = (String.isBlank(addrCity)) ? '' : EncodingUtil.urlEncode(addrCity, 'UTF-8');
		String postalCode = (String.isBlank(addrPostalCode)) ? '' : EncodingUtil.urlEncode(addrPostalCode, 'UTF-8');
		String stateCode = (String.isBlank(addrStateCode)) ? '' : EncodingUtil.urlEncode(addrStateCode, 'UTF-8');
		String countryCode = (String.isBlank(addrCountryCode)) ? '' : EncodingUtil.urlEncode(addrCountryCode, 'UTF-8');
		
		WhitePagesPro_API__mdt wpp_api = [select Id, MasterLabel, DeveloperName, API_Base_URL__c, API_Key__c from WhitePagesPro_API__mdt where DeveloperName = 'Find_Person_API'];
		
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http(); 
		req.setEndpoint(wpp_api.API_Base_URL__c + 'name=' + name + '&address.street_line_1=' + street1 + '&address.street_line_2=' + street2 + '&address.city=' + city + '&address.postal_code=' + postalCode + '&address.state_code=' + stateCode + '&address.country_code=' + countryCode + '&api_key=' + wpp_api.API_Key__c);
		req.setMethod('GET');
		req.setHeader('Content-Type', 'application/json');
		
		try {
			if (!Test.isRunningTest()) {
				res = http.send(req);
				response = res.toString();
				if (response == 'System.HttpResponse[Status=OK, StatusCode=200]') {
						
					fpResponse.findPerson = (WPP_FP_FindPerson_Class)JSON.deserialize(res.getBody(), WPP_FP_FindPerson_Class.class);
					
					if (fpResponse.findPerson.error != null) {
						fpResponse.result = 'ERROR: ' + fpResponse.findPerson.error.name + ' - ' + fpResponse.findPerson.error.message;
					}
						
				} else {
					fpResponse.result = 'WhitePages Pro communication failure, error = ' + response;
				}
			} else {
				fpResponse.findPerson.person.add(new WPP_FP_Person_Class());
				fpResponse.findPerson.person[0].phones.add(new WPP_Phone_Class());
				fpResponse.findPerson.person[0].phones[0].phone_number = '+15555555555';
			}
		
		} catch(System.Exception e) {
			
			system.debug('*****WhitePages Pro FindPerson Exception: '+ e.getMessage());
			if (res != null) {
				system.debug('*****WhitePages Pro FindPerson http response: ' + res.toString());
				system.debug('*****WhitePages Pro FindPerson response JSON data: ' + res.getBody());
			}
			fpResponse.result = 'WhitePages Pro FindPerson Exception: '+ e.getMessage();
			
		}
		
		return fpResponse;
	}
	
	public static WPP_RA_Response_Class reverseAddress(String addrStreet1, String addrStreet2, String addrCity, String addrPostalCode, String addrStateCode, String addrCountryCode) {
		String response;
		WPP_RA_Response_Class raResponse = new WPP_RA_Response_Class();
		
		raResponse.result = 'SUCCESS';
		
		String street1 = (String.isBlank(addrStreet1)) ? '' : EncodingUtil.urlEncode(addrStreet1, 'UTF-8');
		String street2 = (String.isBlank(addrStreet2)) ? '' : EncodingUtil.urlEncode(addrStreet2, 'UTF-8');
		String city = (String.isBlank(addrCity)) ? '' : EncodingUtil.urlEncode(addrCity, 'UTF-8');
		String postalCode = (String.isBlank(addrPostalCode)) ? '' : EncodingUtil.urlEncode(addrPostalCode, 'UTF-8');
		String stateCode = (String.isBlank(addrStateCode)) ? '' : EncodingUtil.urlEncode(addrStateCode, 'UTF-8');
		String countryCode = (String.isBlank(addrCountryCode)) ? '' : EncodingUtil.urlEncode(addrCountryCode, 'UTF-8');
		
		WhitePagesPro_API__mdt wpp_api = [select Id, MasterLabel, DeveloperName, API_Base_URL__c, API_Key__c from WhitePagesPro_API__mdt where DeveloperName = 'Reverse_Address_API'];
		
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http(); 
		req.setEndpoint(wpp_api.API_Base_URL__c + 'street_line_1=' + street1 + '&street_line_2=' + street2 + '&city=' + city + '&postal_code=' + postalCode + '&state_code=' + stateCode + '&country_code=' + countryCode + '&api_key=' + wpp_api.API_Key__c);
		req.setMethod('GET');
		req.setHeader('Content-Type', 'application/json');
		
		try {
			if (!Test.isRunningTest()) {
				res = http.send(req);
				response = res.toString();
				if (response == 'System.HttpResponse[Status=OK, StatusCode=200]') {
						
					raResponse.reverseAddress = (WPP_RA_ReverseAddress_Class)JSON.deserialize(res.getBody(), WPP_RA_ReverseAddress_Class.class);
					
					if (raResponse.reverseAddress.error != null) {
						raResponse.result = 'ERROR: ' + raResponse.reverseAddress.error.name + ' - ' + raResponse.reverseAddress.error.message;
					} else if (raREsponse.reverseAddress.is_valid != 'true') {
						raResponse.result = 'ERROR: invalid address';
					}
						
				} else {
					raResponse.result = 'WhitePages Pro communication failure, error = ' + response;
				}
			} else {
				raResponse.reverseAddress.current_residents.add(new WPP_RA_Person_Class());
				raResponse.reverseAddress.current_residents[0].id = 'Person';
				raResponse.reverseAddress.current_residents[0].firstname = 'Billy';
				raResponse.reverseAddress.current_residents[0].lastname = 'Bob';
				raResponse.reverseAddress.current_residents[0].phones.add(new WPP_Phone_Class());
				raResponse.reverseAddress.current_residents[0].phones[0].phone_number = '+15555555555';
			}
		
		} catch(System.Exception e) {
			
			system.debug('*****WhitePages Pro ReverseAddress Exception: '+ e.getMessage());
			if (res != null) {
				system.debug('*****WhitePages Pro ReverseAddress http response: ' + res.toString());
				system.debug('*****WhitePages Pro ReverseAddress response JSON data: ' + res.getBody());
			}
			raResponse.result = 'WhitePages Pro ReverseAddress Exception: '+ e.getMessage();
			
		}
		
		return raResponse;
	}
}