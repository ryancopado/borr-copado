/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class TokenGeneration {
    global TokenGeneration() {

    }
    @InvocableMethod
    global static void createToken(List<sharinpix.TokenGeneration.Parameters> paramsList) {

    }
global class Parameters {
    @InvocableVariable(label='Field API Name(s)' description='API name(s) of field(s) to store the token.' required=true)
    global String fieldname;
    @InvocableVariable(label='Record Name' description='Name of the current record.' required=false)
    global String name;
    @InvocableVariable(label='Hours Before Token Expires' description='Number of hours before expiring' required=false)
    global Integer numberOfHours;
    @InvocableVariable(label='Record ID' description='ID of record to be updated.' required=true)
    global Id recordId;
    global Parameters() {

    }
}
}
