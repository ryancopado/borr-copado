<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Next_True_Up_due_in_30_Days_Notification</fullName>
        <description>Next True Up due in 30 Days Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>psundarajan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Next_True_Up_Report_Due_to_Client_in_30_Days</template>
    </alerts>
    <alerts>
        <fullName>Performance_Guarantee_has_been_created_alert_to_SPG_group</fullName>
        <description>Performance Guarantee has been created alert to SPG group</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>psundarajan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Performance_Guarantee_Created</template>
    </alerts>
    <fieldUpdates>
        <fullName>Date_for_Next_Analysis</fullName>
        <field>Date_for_Next_Analysis__c</field>
        <formula>Most_Recent_Analysis_Date__c</formula>
        <name>Date for Next Analysis</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Next_Analysis_Date</fullName>
        <field>Date_for_Next_Analysis__c</field>
        <formula>IF(ISPICKVAL(Analysis_Interval__c, &quot;365 Days&quot;), Most_Recent_Analysis_Date__c + 365,
IF(ISPICKVAL(Analysis_Interval__c, &quot;120 Days&quot;),  Most_Recent_Analysis_Date__c  + 120,
IF(ISPICKVAL(Analysis_Interval__c, &quot;90 Days&quot;), Most_Recent_Analysis_Date__c  + 90,
IF(ISPICKVAL(Analysis_Interval__c, &quot;60 Days&quot;), Most_Recent_Analysis_Date__c  + 60, 
IF(ISPICKVAL(Analysis_Interval__c, &quot;60 Days&quot;), Most_Recent_Analysis_Date__c  + 30,
Null)))))</formula>
        <name>Next Analysis Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Next_Analysis_Date_Update</fullName>
        <field>Next_Analysis_Date_2__c</field>
        <formula>IF(ISPICKVAL(Analysis_Interval__c, &quot;365 Days&quot;), Most_Recent_Analysis_Date__c + 365, 
IF(ISPICKVAL(Analysis_Interval__c, &quot;120 Days&quot;), Most_Recent_Analysis_Date__c + 120, 
IF(ISPICKVAL(Analysis_Interval__c, &quot;90 Days&quot;), Most_Recent_Analysis_Date__c + 90, 
IF(ISPICKVAL(Analysis_Interval__c, &quot;60 Days&quot;), Most_Recent_Analysis_Date__c + 60, 
IF(ISPICKVAL(Analysis_Interval__c, &quot;60 Days&quot;), Most_Recent_Analysis_Date__c + 30, 
NULL)))))</formula>
        <name>Next Analysis Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Next Analysis Date Update</fullName>
        <actions>
            <name>Next_Analysis_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto calculates a recommended date for next analysis based on interval selected</description>
        <formula>ISCHANGED( Date_for_Next_Analysis__c ) &amp;&amp; 
ISPICKVAL( Analysis_Interval__c , &quot;30 Days&quot;) || 
ISPICKVAL( Analysis_Interval__c , &quot;60 Days&quot;) || 
ISPICKVAL( Analysis_Interval__c , &quot;90 Days&quot;) || 
ISPICKVAL( Analysis_Interval__c , &quot;120 Days&quot;) || 
ISPICKVAL( Analysis_Interval__c , &quot;365 Days&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Next True Up Report Due to Client in 30 Days</fullName>
        <actions>
            <name>True_Up_Report_Due</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Performance_Guarantee__c.Next_True_up_Report_Due_Client__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>sends email alert and creates task 30 days prior to Next True Up report being due</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Next_True_Up_due_in_30_Days_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Performance_Guarantee__c.Next_True_up_Report_Due_Client__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Performance Guarantee Created</fullName>
        <actions>
            <name>Performance_Guarantee_has_been_created_alert_to_SPG_group</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>email alert to RG when PG is included</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>True_Up_Report_Due</fullName>
        <assignedTo>bradley@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Please prepare True Up Report.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Performance_Guarantee__c.Next_True_up_Report_Due_Client__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>True Up Report Due</subject>
    </tasks>
</Workflow>
