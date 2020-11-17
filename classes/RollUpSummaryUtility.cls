/**
* RollUp Utility Class based on the code at: http://www.anthonyvictorio.com/salesforce/roll-up-summary-utility/
*/
public class RollUpSummaryUtility {
     
    //the following class will be used to house the field names
    //and desired operations
    public class fieldDefinition {
        public String operation {get;set;}
        public String childField {get;set;}
        public String parentField {get;set;}
         
        public fieldDefinition (String o, String c, String p) {
            operation = o;
            childField = c;
            parentField = p;
        }
    }
     
    public static void rollUpTrigger(list<fieldDefinition> fieldDefinitions,
    list<sObject> records, String childObject, String childParentLookupField, 
    String parentObject, String queryFilter) {
         
        //Limit the size of list by using Sets which do not contain duplicate
        //elements prevents hitting governor limits
        set<Id> parentIds = new set<Id>();
         
        for(sObject s : records) {
            if ((Id)s.get(childParentLookupField) != NULL) {
            	parentIds.add((Id)s.get(childParentLookupField));
            }
        }
        
        system.debug('Total number of parentIds = ' + parentIds.size() + ' parentIds = ' + parentIds);
         
        //populate query text strings to be used in child aggregrator and 
        //parent value assignment
        String fieldsToAggregate = '';
        String parentFields = '';
         
        for(fieldDefinition d : fieldDefinitions) {
            fieldsToAggregate += d.operation + '(' + d.childField + ') ' + 
            ', ';
            parentFields += d.parentField + ', ';
        }
         
        //Using dynamic SOQL with aggergate results to populate parentValueMap
        String aggregateQuery = 'Select ' + fieldsToAggregate + 
        childParentLookupField + ' from ' + childObject + ' where  ' + 
        childParentLookupField + ' IN :parentIds ' + queryFilter + ' ' +
        ' group by ' + childParentLookupField;
        
        system.debug('aggregateQuery = ' + aggregateQuery);
         
        //Map will contain one parent record Id per one aggregate object
        map<Id, AggregateResult> parentValueMap = 
        new map <Id, AggregateResult>();
         
        for(AggregateResult q : Database.query(aggregateQuery)){
            parentValueMap.put((Id)q.get(childParentLookupField), q);
        }
         
        //list of parent object records to update
        list<sObject> parentsToUpdate = new list<sObject>();
        
        RollUpSettings__c rus = RollUpSettings__c.getOrgDefaults();
        String fu = (rus.ForUpdate__c) ? ' for update' : '';
        
        String parentQuery = 'select ' + parentFields + ' Id ' +
         ' from ' + parentObject + ' where Id IN :parentIds' + fu;
        
        system.debug('parentQuery = ' + parentQuery);
         
        //for each affected parent object, retrieve aggregate results and 
        //for each field definition add aggregate value to parent field
        for(sObject s : Database.query(parentQuery)) {
             
            Integer row = 0; //row counter reset for every parent record
            for(fieldDefinition d : fieldDefinitions) {
                String field = 'expr' + row.format();
                AggregateResult r = parentValueMap.get(s.Id);
                //r will be null if no records exist 
                //(e.g. last record deleted)
                if(r != null) { 
                    Decimal value = ((Decimal)r.get(field) == null ) ? 0 : 
                        (Decimal)r.get(field);
                    s.put(d.parentField, value);
                } else {
                    s.put(d.parentField, 0);
                }
                row += 1; //plus 1 for every field definition after first
            }
            parentsToUpdate.add(s);
        }
         
        //if parent records exist, perform update of all parent records 
        //with a single DML statement
        if(parentsToUpdate.Size() > 0) {
            update parentsToUpdate;
        }
         
    }
    
    public class costCodeIdFilters {
    	public String ohIdFilter {get; set;}
    	public String sgaIdFilter {get; set;}
    	public String moduleIdFilter {get; set;}
    	public String solarModuleIdFilter {get; set;}
    	
    	public costCodeIdFilters () {
    		
    		// Get the Cost Code record Ids we need to build the query filters
			List<Cost_Code__c> ccList = new List<Cost_Code__c>();
			ccList = [select Id, Category__c, Number__c from Cost_Code__c where Number__c in ('02-1425', '02-1535', '05-1535') or Category__c in ('OH', 'SGA')];
			
			List<Id> listOfOHId = new List<Id>();
			List<Id> listOfSGAId = new List<Id>();
			List<Id> listOfModuleId = new List<Id>();
			Id solarModuleId = null;
			String idString;
			
			for (Cost_Code__c cc :ccList) {
				if (cc.Category__c == 'OH') {
					listOfOHId.add(cc.id);
				}
				if (cc.Category__c == 'SGA') {
					listOfSGAId.add(cc.id);
				}
				if (cc.Number__c == '02-1535' || cc.Number__c == '05-1535') {
					listOfModuleId.add(cc.Id);
				}
				if (cc.Number__c == '02-1425') {
					solarModuleId = cc.Id;
				}
			}
			
			// Build the Cost Cost Id query filters
			idString = '(';
			for (Id currId :listOfOHId) {
				if (idString != '(') {
					idString = idString + ',';
				}
				idString = idString + '\'' + currId + '\'';
			}
			if (idString != '(') {
				ohIdFilter = idString + ')';
			} else {
				ohIdFilter = '(\'\')';
			}
			
			idString = '(';
			for (Id currId :listOfSGAId) {
				if (idString != '(') {
					idString = idString + ',';
				}
				idString = idString + '\'' + currId + '\'';
			}
			if (idString != '(') {
				sgaIdFilter = idString + ')';
			} else {
				sgaIdFilter = '(\'\')';
			}
			
			idString = '(';
			for (Id currId :listOfModuleId) {
				if (idString != '(') {
					idString = idString + ',';
				}
				idString = idString + '\'' + currId + '\'';
			}
			if (idString != '(') {
				moduleIdFilter = idString + ')';
			} else {
				moduleIdFilter = '(\'\')';
			}
			
			if (solarModuleId != null) {
				solarModuleIdFilter = '(\'' + solarModuleId + '\')';
			} else {
				solarModuleIdFilter = '(\'\')';
			}
    	}
    }
}