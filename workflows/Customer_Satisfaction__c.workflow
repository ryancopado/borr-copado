<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Customer_Feedback_Accepted</fullName>
        <description>Customer Feedback Accepted</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Customer_Feedback_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Customer_Feedback_Rejected</fullName>
        <description>Customer Feedback Rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Customer_Feedback_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Customer_Satisfaction_Survey_Complete</fullName>
        <description>Customer Satisfaction Survey Complete</description>
        <protected>false</protected>
        <recipients>
            <field>Operations_Manager_Emails__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Opportunity_Owner_Emails__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Project_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Sales_Manager_Emails__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Senior_Design_Engineer_Emails__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Site_Super_Emails__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtea@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Customer_Satisfaction_Survey_Complete</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_Boston_ROD_when_Customer_Sat_is_complete_for_East_Coast_projects</fullName>
        <description>Email alert to Boston ROD when Customer Sat is complete for East Coast projects</description>
        <protected>false</protected>
        <recipients>
            <recipient>nchaney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Customer_Satisfaction_Survey_Complete</template>
    </alerts>
    <alerts>
        <fullName>Status_Assigned_Customer_Feedback</fullName>
        <description>Status Assigned - Customer Feedback</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Status_Assigned_Customer_Feedback</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assigned_Status</fullName>
        <description>update Status to Assigned when a new Assigned To is filled out</description>
        <field>Status__c</field>
        <literalValue>Assigned</literalValue>
        <name>Assigned Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Feedback_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Customer Feedback Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Accepted</literalValue>
        <name>Status Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Assigned</fullName>
        <field>Status__c</field>
        <literalValue>Assigned</literalValue>
        <name>Status Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Operations_Manager_Email</fullName>
        <field>Operations_Manager_Emails__c</field>
        <formula>ASProject__r.Owner:User.Manager.Email</formula>
        <name>Update Operations Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Owner_Email</fullName>
        <field>Opportunity_Owner_Emails__c</field>
        <formula>ASProject__r.EC__r.Email</formula>
        <name>Update Opp Owner Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Project_Owner_Email</fullName>
        <field>Project_Owner_Email__c</field>
        <formula>ASProject__r.Owner:User.Email</formula>
        <name>Update Project Owner Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SDE_Email</fullName>
        <field>Senior_Design_Engineer_Emails__c</field>
        <formula>ASProject__r.Senior_Design_Engineer_L__r.Email</formula>
        <name>Update SDE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sales_Manager_Email</fullName>
        <field>Sales_Manager_Emails__c</field>
        <formula>ASProject__r.EC__r.Manager.Email</formula>
        <name>Update Sales Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Site_Super_Email</fullName>
        <field>Site_Super_Emails__c</field>
        <formula>ASProject__r.Foreman__r.Email</formula>
        <name>Update Site Super Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Assigned To Notification</fullName>
        <actions>
            <name>Status_Assigned_Customer_Feedback</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Assigned_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Email will go to the person listed in the Assigned To field. Status will be updated to Assigned.</description>
        <formula>ISCHANGED( Assigned_To__c )
&amp;&amp;
ISBLANK(PRIORVALUE(Assigned_To__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Customer Satisfaction Survey Complete</fullName>
        <actions>
            <name>Customer_Satisfaction_Survey_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Customer_Satisfaction__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Alert the project team that a customer survey has been completed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Customer Satisfaction Survey Complete EAST</fullName>
        <actions>
            <name>Email_alert_to_Boston_ROD_when_Customer_Sat_is_complete_for_East_Coast_projects</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alert the ROD that a customer survey has been completed on east coast.</description>
        <formula>ISPICKVAL(Status__c, &quot;Completed&quot;) &amp;&amp; ISPICKVAL ( ASProject__r.Branch__c , &quot;Boston&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Emails Adresses</fullName>
        <actions>
            <name>Update_Operations_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Opp_Owner_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Project_Owner_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_SDE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sales_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Site_Super_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Customer_Satisfaction__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This updates all of the email addresses for the project team email fields.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
