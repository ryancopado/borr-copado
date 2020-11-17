trigger CloneRecurringExpenseController on AcctSeed__Scheduled_Revenue_Expense__c (before insert, after insert) {                                                              
    if (Trigger.isInsert && Trigger.isBefore) {
      CloneRevExpActions.checkAccountPeriodsExist(Trigger.new);
      CloneRevExpActions.setProrateAmount(Trigger.new);
      
      /*Added By Madan - Jun 6, 2017(To populate few fields on New Record Create)*/
      CloneRevExpActions.populateFields(trigger.new);
    }
    else if (Trigger.isInsert && Trigger.isAfter) {
      CloneRevExpActions.cloneScheduledRevenueExpense(Trigger.new);
    }
}