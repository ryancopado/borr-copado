<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_Non_Exempt_Employee_that_their_time_entry_has_been_approved</fullName>
        <description>Email Alert to Non-Exempt Employee that their time entry has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HR/Hourly_Time_Card_Entry_Approved</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_employee_that_hourly_time_entry_has_been_rejected</fullName>
        <description>Email alert to employee that hourly time entry has been rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HR/Hourly_Time_Card_Entry_Rejected</template>
    </alerts>
    <alerts>
        <fullName>email_alert_to_HR_that_hourly_time_card_has_been_submitted_to_manager</fullName>
        <description>email alert to HR that hourly time card has been submitted to manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HR/Hourly_Time_Card_Entry_Submission</template>
    </alerts>
    <fieldUpdates>
        <fullName>HR_Approval</fullName>
        <field>HR_Approved__c</field>
        <literalValue>1</literalValue>
        <name>HR Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Includes_Overtime_Checkbox</fullName>
        <field>Includes_Overtime__c</field>
        <literalValue>1</literalValue>
        <name>Includes Overtime Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Manager_Approval</fullName>
        <field>Manager_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Manager Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_OT_included_box</fullName>
        <field>Includes_Overtime__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck OT included box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Does Not Include Overtime</fullName>
        <actions>
            <name>Uncheck_OT_included_box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>unchecks off OT box whenever day total hours worked does not exceed 8 or week total does not exceed 40</description>
        <formula>AND(OR(ISPICKVAL(Employee_Name__r.Region__c, &quot;Northern CA&quot;)),(ISPICKVAL(Employee_Name__r.Region__c, &quot;Southern CA&quot;)), Monday_Total_Hours_Worked__c  &lt;=  8 || Tuesday_Total_Hours_Worked__c &lt;=8 || Wednesday_Total_Hours_Worked__c &lt;= 8 || Thursday_Total_Hours_Worked__c &lt;= 8 || Friday_Total_Hours_Worked__c &lt;= 8 || Saturday_Total_Hours_Worked__c &lt;= 8 || Sunday_Total_Hours_Worked__c &lt;= 8 || 
Total_Hours_for_Week__c &lt;= 40)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Includes Overtime</fullName>
        <actions>
            <name>Includes_Overtime_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>checks off OT box whenever day total hours worked exceeds 8 or week total exceeds 40</description>
        <formula>AND(OR(ISPICKVAL(Employee_Name__r.Region__c, &quot;Northern CA&quot;)),(ISPICKVAL(Employee_Name__r.Region__c, &quot;Southern CA&quot;)), Monday_Total_Hours_Worked__c &gt; 8  || Tuesday_Total_Hours_Worked__c &gt; 8 || Wednesday_Total_Hours_Worked__c &gt; 8 || Thursday_Total_Hours_Worked__c &gt; 8 || Friday_Total_Hours_Worked__c &gt; 8 || Saturday_Total_Hours_Worked__c &gt; 8 || Sunday_Total_Hours_Worked__c &gt; 8 || 
Total_Hours_for_Week__c &gt; 40)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
