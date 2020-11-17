/*
// Developed By : Kumar, Forcebrain
// Description : Schedule class ContactRollupCount to rollup opportunity contact role
*/

global class ContactRollupCountscheduler implements Schedulable {

   global void execute(SchedulableContext ctx) {
      ContactRollupCount p = new ContactRollupCount();
        database.executeBatch(p);
   }   
}