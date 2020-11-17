/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/DVLSAssessment/*')
global class DVLSAssessmentResource {
    global DVLSAssessmentResource() {

    }
    @HttpGet
    global static DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView getQuizz() {
        return null;
    }
    @HttpDelete
    global static void resetTest() {

    }
    @HttpPost
    global static DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView submitAssessment(DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView a) {
        return null;
    }
global class DVLSAnswerOption {
}
global class DVLSAssessment {
}
global class DVLSAssessmentQuizzView {
}
global class DVLSAssessmentSummary {
    global DVLSAssessmentSummary() {

    }
}
global class DVLSQuestion {
}
global class DVLSScoreSummary {
    global DVLSScoreSummary() {

    }
}
global class NoSuchTestException extends Exception {
}
global class ScoreId {
}
global class TestAlreadyCompleteException extends Exception {
}
}
