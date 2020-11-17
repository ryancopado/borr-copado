public class RollUpQueueable implements Queueable {
    
    /*
     *  Performs custom rollup summaries asynchronously using RollUpSummaryUtility.cls
     */
    
    List<RollUpSummaryUtility.fieldDefinition> fieldDefinitions;
    List<SObject> records;
    String childObject;
    String childParentLookupField;
    String parentObject;
    String queryFilter;
    
    public RollUpQueueable(List<RollUpSummaryUtility.fieldDefinition> fieldDefinitions, List<SObject> records, String childObject, String childParentLookupField, String parentObject, String queryFilter) {
        this.fieldDefinitions = fieldDefinitions;
        this.records = records;
        this.childObject = childObject;
        this.childParentLookupField = childParentLookupField;
        this.parentObject = parentObject;
        this.queryFilter = queryFilter;
    }
    
    public void execute(QueueableContext context) {
        
        if (!records.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, records, childObject, childParentLookupField, parentObject, queryFilter);
        }
    }
}