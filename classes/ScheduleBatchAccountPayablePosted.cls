global class ScheduleBatchAccountPayablePosted implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchAccountPayablePosted batch = new BatchAccountPayablePosted(); 
        Database.executeBatch(batch, batch.AccountPayablePostedBatchSize);
    }
}