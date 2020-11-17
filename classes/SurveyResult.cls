public class SurveyResult {
    public static void ratingNumber(MWA1_Answer__c[] ans) {
        for (MWA1_Answer__c a:ans) {
            MWA1_Entry__c question = [select Id, Position__c from MWA1_Entry__c where Id = :a.MWAQuestion__c];
            if (question.Position__c == 1.00) {
                try {
                a.NR__c = Double.valueOf(a.SVR__c);
                }
                catch(System.TypeException e){
                    System.assert(e.getMessage().contains('Invalid double:'), 
                     e.getMessage());
                     a.Failed__c = true;
                }   
            }
        }
    }
    public static testMethod void SurveyTest(){
        Contact Contact=new contact(FirstName='System', LastName='User'); Insert Contact;
        //Contact contact = [select Id from Contact where Name = 'System User'];
        MWA1_Survey__c survey = new MWA1_Survey__c(Active__c = true); insert survey;
        MWA1_Entry__c question = new MWA1_Entry__c(MWASurvey__c = survey.Id, Position__c = 1.00, EType__c = 'Satisfaction Survey', Entry_Text__c = 'Je mange de fromage'); insert question;
        MWA1_Submission__c submission = new MWA1_Submission__c(MWASurvey__c = survey.Id, Contact__c = contact.Id); insert submission;   
        MWA1_Answer__c answer = new MWA1_Answer__c(Submission__c = submission.Id, MWAQuestion__c = question.Id, SVR__c = '9'); insert answer;
        
        answer.SVR__c = '10';
        update answer;
        answer.SVR__c = 'Ten';
        update answer;
    }
}