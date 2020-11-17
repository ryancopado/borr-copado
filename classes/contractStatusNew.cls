public class contractStatusNew {
   public static void addStatusNew(Contract[] contracts){

      for (Contract c:contracts){
         if (c.Contract_Status__c != 'New') {
            c.Contract_Status__c = 'New';
         }
      }
   }

}