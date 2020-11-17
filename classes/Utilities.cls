public class Utilities {
    
        
    public static Map<Id, RecordType> allRecordTypes = new Map<Id, RecordType>();
    public static Map<String, RecordType> allRecordTypesByName = new Map<String, RecordType>();
    
    // Name signature
    public static RecordType getRecordType( String recordType ){
        if (Utilities.allRecordTypes.size()<1){
            loadRecordTypes(); // utility method loads both maps
        }
        try{
            RecordType recType = Utilities.allRecordTypesByName.get(recordType);
            return recType;
        } catch (Exception e) {
            System.debug(Logginglevel.ERROR, 'RecordType Error' + e  );
            return null;
        }
    }
    
    // Id signature
    public static RecordType getRecordType( Id recordType ){
        if (Utilities.allRecordTypes.size()<1){
            loadRecordTypes();
        }
        try{
            RecordType recType = Utilities.allRecordTypes.get(recordType);
            return recType;
        } catch (Exception e) {
            System.debug(Logginglevel.ERROR, 'RecordType Error' + e  );
            return null;
        }
    }
    
    
    
    
    public static Boolean isEmpty(String testString){
        return testString == '' || testString == null ? true : false;
    }
    
    public static Boolean isEmpty(Id testId){
        return testId == '' || testId == null ? true : false;
    }
    
    
    
    
    public static Integer nullToZero(Integer theNum ){
        return theNum == 0 || theNum == null ? 0 : theNum;
    }
    
    public static Double nullToZero(Double theNum ){
        return theNum == 0 || theNum == null ? 0 : theNum;
    }
    
    // Limit the length of any single word in the inputString to no more than maxLength characters.
    // Make sure there is a blank character at least every maxLength characters and if not insert one.
    public static String limitWordLength(String inputString, Integer maxLength) {
    	String outputString = '';
    	Integer j;
    	
		if (maxLength > 0 && String.isNotBlank(inputString)) {
			for (Integer i=0; i<inputString.length(); i++) {
				if (inputString.substring(i, i+1) == ' ') {
					outputString += inputString.substring(i, i+1);
				} else {
					for (j=i; j<i+maxLength && j<inputString.length() && inputString.substring(j, j+1)!=' '; j++) {
						outputString += inputString.substring(j, j+1);
					}
					if (j == i + maxLength && j < inputString.length() && inputString.substring(j, j+1) != ' ') {
						outputString += ' ';
					}
					i = j - 1;
				}
			}
			if (outputString != '') {
				return outputString;
			} else {
				return inputString;
			}
		} else {
			return inputString;
		}
    }
    
    
    private static void loadRecordTypes(){
        // 2009-12-28 jsmall@soliantconsulting.com made allRecordTypes a singleton
        if (Utilities.allRecordTypes.size() < 1){
            Utilities.allRecordTypes = new Map<Id, RecordType>([select Id,Name from RecordType]);
            for (RecordType recType : Utilities.allRecordTypes.values()) {
                Utilities.allRecordTypesByName.put(recType.Name, recType);
            }
        }
    }
    
    
    
    
    static testmethod void UtilitiesTest(){
        test.startTest();
            RecordType theRecordType = Utilities.getRecordType('Subcontractor Change Order'); 
        test.stopTest();
        System.assertNotEquals(null,theRecordType);
        
        String result = limitWordLength('thisisawordlenghttest', 4);
        system.assertEquals(result, 'this isaw ordl engh ttes t');
    }
    
     

}