<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <alerts>
        <fullName>Email_alert_to_external_candidate_NO_PHONE_SCREEN</fullName>
        <description>Email alert to external candidate - NO PHONE SCREEN</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>lweingarten@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/No_Phone_Screen</template>
    </alerts>
    <alerts>
        <fullName>Email_notification_to_interview_candidate_POST_IN_PERSON_INTERVIEW</fullName>
        <description>Email notification to interview candidate - POST IN PERSON INTERVIEW</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>lweingarten@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/Post_in_person_interview</template>
    </alerts>
    <alerts>
        <fullName>Email_notification_to_interview_candidate_POST_PHONE_SCREEN</fullName>
        <description>Email notification to interview candidate - POST PHONE SCREEN</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>lweingarten@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/Post_Phone_Screen</template>
    </alerts>
    <alerts>
        <fullName>Lead_Email_notification_to_Jon_that_lead_has_been_assigned_to_specific_Queue</fullName>
        <description>Lead Email notification to Jon that lead has been assigned to specific Queue</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>X1_Lead_Management/Lead_Queue_Notification_to_Jon</template>
    </alerts>
    <alerts>
        <fullName>Phone_Screen_Lead_Status</fullName>
        <description>Phone Screen Lead Next Step</description>
        <protected>false</protected>
        <recipients>
            <recipient>Recruiter</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Phone_Screen_Lead_Status</template>
    </alerts>
    <alerts>
        <fullName>ReferencesOfferNotice</fullName>
        <description>References/Offer Notice</description>
        <protected>false</protected>
        <recipients>
            <field>Hiring_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ReferencesOfferNotice</template>
    </alerts>
    <fieldUpdates>
        <fullName>Clean_Status_Skipped_for_New_Employmen</fullName>
        <field xsi:nil="true"/>
        <literalValue>Skipped</literalValue>
        <name>Clean Status - Skipped for New Employmen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Stage_1_on_email</fullName>
        <field>Status</field>
        <literalValue>Contact Stage 1</literalValue>
        <name>Contact Stage 1 on email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Disposition_Letter_Sent_Checkobox</fullName>
        <description>used to record that a disposition letter was sent out</description>
        <field>Disposition_Letter_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Disposition Letter Sent Checkobox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Employment_Leads_Email_Opt_Out</fullName>
        <field>HasOptedOutOfEmail</field>
        <literalValue>1</literalValue>
        <name>Employment Leads Email Opt Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Conversion_Status_Auto_Populate</fullName>
        <description>used to replicate value in lead status field so it can be mapped to contact status upon conversion</description>
        <field>Lead_Conversion_Status__c</field>
        <formula>CASE(Status, 
&quot;No contact attempted&quot;, &quot;No contact attempted&quot;,
&quot;Open&quot;,&quot;Open&quot;,
&quot;Wrong Person With Company&quot;, &quot;Wrong Person With Company&quot;, 
&quot;Contact attempted, unreached&quot;, &quot;Contact attempted, unreached&quot;, 
&quot;Contact attempted, abandoned&quot;,&quot;Contact attempted, abandoned&quot;, 
&quot;Contacted, Long Term&quot;,&quot;Contacted, Long Term&quot;, 
&quot;Closed/Lost&quot;,&quot;Closed/Lost&quot;, 
&quot;Contacted, ongoing&quot;,&quot;Contacted, ongoing&quot;, 
&quot;Company Unqualified&quot;,&quot;Company Unqualified&quot;, 
&quot;PD will not call&quot;,&quot;PD will not call&quot;, 
&quot;Other&quot;)</formula>
        <name>Lead Conversion Status Auto Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Owner_OOM_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Out_of_Market_Leads_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Lead Owner OOM Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Queue_Reassignment_to_MQL_Queue</fullName>
        <description>when leads hit specific pardot score a lead is reassigned from regular leads queue to MQL Queue</description>
        <field>OwnerId</field>
        <lookupValue>MQL_Leads</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Lead Queue Reassignment to MQL Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Status_Update_for_Employment_Applic</fullName>
        <description>auto updates lead status to NEW upon creation of a new employment application from web</description>
        <field>Status</field>
        <literalValue>New</literalValue>
        <name>Lead Status Update for Employment Applic</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Status_to_Eliminated</fullName>
        <description>When one of three Disposition Letter picklist values are selected, an email is send out and the Lead Status gets changed to Eliminated</description>
        <field>Status</field>
        <literalValue>Eliminated</literalValue>
        <name>Lead Status to Eliminated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Leads_Queue_Change</fullName>
        <field>OwnerId</field>
        <lookupValue>MQL_Leads</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Leads Queue Change</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MQL_Leads_Checkbox_update</fullName>
        <field>MQL_Lead__c</field>
        <literalValue>1</literalValue>
        <name>MQL Leads Checkbox update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MQL_Leads_Date</fullName>
        <description>auto updates date the lead was first assigned to MQL queue</description>
        <field>Date_1st_Assigned_to_MQL_Queue__c</field>
        <formula>NOW()</formula>
        <name>MQL Leads Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MQL_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>MQL_Leads</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>MQL Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NewEnglandBoston</fullName>
        <field>Branch__c</field>
        <literalValue>Boston</literalValue>
        <name>New England =&gt; Boston</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SanJoseSiliconValley</fullName>
        <field>Branch__c</field>
        <literalValue>Silicon Valley</literalValue>
        <name>San Jose =&gt; Silicon Valley</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Auto Update Lead Clean Status on Employment Apps</fullName>
        <actions>
            <name>Clean_Status_Skipped_for_New_Employmen</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employment Applicant,Affirmative Action</value>
        </criteriaItems>
        <description>auto update data.com clean status field to SKIPPED as new employment apps are being created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AutoCreation of Task Upon creation of new web lead</fullName>
        <actions>
            <name>Website_Follow_Up</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Emily Tam</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Inbound: Captured on borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Standard</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Employment Lead Email opt Out</fullName>
        <actions>
            <name>Employment_Leads_Email_Opt_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employment Applicant,Affirmative Action</value>
        </criteriaItems>
        <description>auto-populates email opt out on employment leads so they can be filtered out of marketing campaigns</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Lead %3D MQL Checkbox</fullName>
        <actions>
            <name>MQL_Leads_Checkbox_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MQL_Leads_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MQL_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.pi__grade__c</field>
            <operation>equals</operation>
            <value>C+,B-,B,B+,A-,A,A+</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.pi__score__c</field>
            <operation>greaterThan</operation>
            <value>80</value>
        </criteriaItems>
        <description>checks off MQL lead checkbox whenever a lead has been assigned to the MQL queue</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Conversion Status</fullName>
        <actions>
            <name>Lead_Conversion_Status_Auto_Populate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LastName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status Update for Employment Applicants</fullName>
        <actions>
            <name>Lead_Status_Update_for_Employment_Applic</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employment Applicant</value>
        </criteriaItems>
        <description>autopopulates Status to New upon creation from the web</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Leads Queue Owner Update</fullName>
        <actions>
            <name>Leads_Queue_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MQL_Leads_Checkbox_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MQL_Leads_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Lead.pi__score__c</field>
            <operation>greaterOrEqual</operation>
            <value>85</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.pi__grade__c</field>
            <operation>equals</operation>
            <value>C+,B-,B,B+,A-,A,A+</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.OwnerId</field>
            <operation>equals</operation>
            <value>Out-of-Market Leads Queue,Leads Queue,DQL Queue</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstName</field>
            <operation>equals</operation>
            <value>Bettina,Amanda</value>
        </criteriaItems>
        <description>Updates owner to MQL Queue if the lead has BOTH a score of 85 or higher AND a grade of C+ or better.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Phone Screen</fullName>
        <actions>
            <name>Phone_Screen_Lead_Status</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employment Applicant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Next_Step__c</field>
            <operation>equals</operation>
            <value>Phone Screen</value>
        </criteriaItems>
        <description>Email alert when &quot;Next Step&quot; is changed to &quot;Phone Screen&quot;. Vin requested to stop receiving these on 8/7/2018.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Follow Up - No Phone Screen</fullName>
        <actions>
            <name>Email_alert_to_external_candidate_NO_PHONE_SCREEN</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Disposition_Letter_Sent_Checkobox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead_Status_to_Eliminated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Disposition Letter No Phone Screen (SENDS EMAIL)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>selecting one of these options automatically sends email to candidate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Follow Up - Post Phone Screen</fullName>
        <actions>
            <name>Email_notification_to_interview_candidate_POST_PHONE_SCREEN</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Disposition_Letter_Sent_Checkobox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead_Status_to_Eliminated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Disposition Letter Post Phone Screen (SENDS EMAIL)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LastName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>selecting one of these options automatically sends email to candidate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Follow Up - Post in person Interview</fullName>
        <actions>
            <name>Email_notification_to_interview_candidate_POST_IN_PERSON_INTERVIEW</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Disposition_Letter_Sent_Checkobox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead_Status_to_Eliminated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Disposition Letter Post in person interview (SENDS EMAIL)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>selecting one of these options automatically sends email to candidate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Follow_Up_with_MQL</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.Date_1st_Assigned_to_MQL_Queue__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up with MQL</subject>
    </tasks>
    <tasks>
        <fullName>Follow_Up_with_MQL_Lead</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.Date_1st_Assigned_to_MQL_Queue__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up with MQL Lead</subject>
    </tasks>
    <tasks>
        <fullName>Website_Follow_Up</fullName>
        <assignedTo>acain@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>This lead record was created via our website please follow up and update this task accordingly.</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Website Follow Up</subject>
    </tasks>
</Workflow>
