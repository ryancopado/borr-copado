global class ScheduleBatchJournalEntryPosted implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchJournalEntryPosted batch = new BatchJournalEntryPosted(); 
        Database.executeBatch(batch, batch.JournalEntryPostedBatchSize);
    }
}