<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_alert_to_contact_owner_that_contact_has_been_marked_as_marketing_qualfied</fullName>
        <description>Email alert to contact owner that contact has been marked as marketing -qualfied</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Contact_marked_as_Marketing_Qualfieid</template>
    </alerts>
    <alerts>
        <fullName>Employee_Contact_Record_Department_Has_Changed</fullName>
        <description>Employee Contact Record Department Has Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Contact_record_Department_Changed</template>
    </alerts>
    <alerts>
        <fullName>Employee_Contact_Record_Manager_Has_Changed</fullName>
        <description>Employee Contact Record Manager Has Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbarbosa@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rdaniels@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Contact_record_Manager_Changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>Marketing_Qualified_Contact_Date</fullName>
        <field>First_date_marketing_qualified__c</field>
        <formula>TODAY()</formula>
        <name>Marketing Qualified Contact Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Qualified_Contact_MQL_Checkbox</fullName>
        <field>MQL_Lead__c</field>
        <literalValue>1</literalValue>
        <name>Marketing Qualified Contact MQL Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Primary_COtnact_Checkbox</fullName>
        <description>checks off primacy contact checkbox on contact page (not visible) so that it can be easily displayed and sorted on Account Related list.</description>
        <field>Primary_Contact__c</field>
        <literalValue>Yes</literalValue>
        <name>Primary COtnact Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Marketing Qualified Contact</fullName>
        <actions>
            <name>Email_alert_to_contact_owner_that_contact_has_been_marked_as_marketing_qualfied</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Marketing_Qualified_Contact_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Marketing_Qualified_Contact_MQL_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.pi__score__c</field>
            <operation>greaterOrEqual</operation>
            <value>80</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.pi__grade__c</field>
            <operation>equals</operation>
            <value>C+,B-,B,B+,A-,A,A+</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.EPC_Active_Opportunities__c</field>
            <operation>lessOrEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>auto-checks off MQL when pardot score of 85 and a pardo grade of C+ or better is reached</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify IT when Department is updated</fullName>
        <actions>
            <name>Employee_Contact_Record_Department_Has_Changed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>sends email alert to members of IT team when the Department  is updated on an employee contact record</description>
        <formula>ISCHANGED ( Department )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify IT when Manager is updated</fullName>
        <actions>
            <name>Employee_Contact_Record_Manager_Has_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert to members of IT team when the Manager is updated on an employee contact record</description>
        <formula>AND(
ISCHANGED( SFManagerUserRecord__c ),
Active__c = TRUE,
NOT( ISNEW() )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Follow_Up_with_MQL</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.First_date_marketing_qualified__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up with MQL</subject>
    </tasks>
</Workflow>
