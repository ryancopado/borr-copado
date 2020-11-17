global class servicecontractrenewal implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    renewcontractsbatch b = new renewcontractsbatch(); //ur batch class
      database.executebatch(b);
    }
}