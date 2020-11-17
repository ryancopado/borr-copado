<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_User_Created</fullName>
        <ccEmails>salesforce@borregosolar.com</ccEmails>
        <description>New User Created</description>
        <protected>false</protected>
        <recipients>
            <field>SenderEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_User_Created</template>
    </alerts>
    <alerts>
        <fullName>User_Deactivated</fullName>
        <description>User Deactivated</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/User_Deactivated</template>
    </alerts>
    <alerts>
        <fullName>User_Update_Department_Title_Branch_Region</fullName>
        <description>User Update Department/Title/Branch/Region</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Contact_record_Department_Changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>Create_Contact_Record</fullName>
        <description>checks off create contact record checkbox which initiates a process builder to create a contact</description>
        <field>CreateContactRecord__c</field>
        <literalValue>1</literalValue>
        <name>Create Contact Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Report_Checkoff</fullName>
        <field>Test_Expense_Report_PB__c</field>
        <literalValue>1</literalValue>
        <name>Expense Report Checkoff</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Create Contact Record</fullName>
        <active>true</active>
        <criteriaItems>
            <field>User.ManagerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Checks off the &quot;Create Contact Record&quot; checkbox field (1 hour delay) which creates a new contact record. (hour delay is to avoid an error)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Create_Contact_Record</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Create Expense Report</fullName>
        <active>true</active>
        <criteriaItems>
            <field>User.ManagerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Checks off the &quot;Create Expense Report&quot; checkbox field (1 hour delay) which creates a new expense report. (hour delay is to avoid an error)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Expense_Report_Checkoff</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>User.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>New User Created</fullName>
        <actions>
            <name>New_User_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@borregosolar.com</value>
        </criteriaItems>
        <description>Sends an email alert when a new Borrego user is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify IT when Department%2FTitle%2FBranch is updated</fullName>
        <actions>
            <name>User_Update_Department_Title_Branch_Region</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an email alert to members of the IT team when Department, Title, or Branch are updated.</description>
        <formula>AND(

OR(
ISCHANGED(  Title  ),
ISCHANGED(  Department  ),
ISCHANGED(  Branch__c  )
),

IsActive  = TRUE,
NOT( ISNEW() )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>User Deactivated</fullName>
        <actions>
            <name>User_Deactivated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Email Alert when a user is deactivated</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
