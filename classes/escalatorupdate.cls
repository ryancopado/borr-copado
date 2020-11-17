global class escalatorupdate implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    UpdateLaborfieldBatch b = new UpdateLaborfieldBatch(); //ur batch class
      database.executebatch(b);
    }
}