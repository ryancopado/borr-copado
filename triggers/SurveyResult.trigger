trigger SurveyResult on MWA1_Answer__c bulk(before insert, before update) {
	MWA1_Answer__c[] answers = System.Trigger.new;
      SurveyResult.ratingNumber(Trigger.new);  
}