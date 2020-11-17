global class serviceescalatorrenewal implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    UpdateContractfieldBatch b = new UpdateContractfieldBatch(); //ur batch class
      database.executebatch(b);
    }
}