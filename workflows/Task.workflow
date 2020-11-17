<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Interconnection_App_Task_Complete</fullName>
        <description>Interconnection App Task Complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_App_Task_Complete</template>
    </alerts>
    <alerts>
        <fullName>Respond_to_Scheduling_Meeting_Output_Email</fullName>
        <description>Respond to Scheduling Meeting Output Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Respond_to_Scheduling_Meeting_Output_Email</template>
    </alerts>
    <alerts>
        <fullName>Schedule_Pricing_Meeting_Alert_to_AE</fullName>
        <description>Schedule Pricing Meeting Alert to AE</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Schedule_Pricing_Meeting_Alert_to_AE</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_re_Scheduling_Meeting_Output</fullName>
        <description>Send Email to AE re: Scheduling Meeting Output</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Send_Email_re_Scheduling_Meeting_Output</template>
    </alerts>
    <fieldUpdates>
        <fullName>Activity_Type_NEW_Auto_Fill</fullName>
        <description>auto fills upon creation the value that is in the TYPE field</description>
        <field>Activity_Type_NEW__c</field>
        <literalValue>Email</literalValue>
        <name>Activity Type NEW Auto Fill</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_Date</fullName>
        <field>Completed_Date__c</field>
        <formula>TODAY()</formula>
        <name>Completed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_Date_Auto_Updated</fullName>
        <field>Completed_Date__c</field>
        <formula>Today()</formula>
        <name>Completed Date Auto Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_Completed_Update_Checkbox</fullName>
        <field>Completed__c</field>
        <literalValue>1</literalValue>
        <name>Task Completed Update Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_Type_Field_Auto_Update_Email</fullName>
        <field>Activity_Type_NEW__c</field>
        <literalValue>Email</literalValue>
        <name>Task Type Field Auto Update Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Auto Update Activity Task NEW</fullName>
        <actions>
            <name>Activity_Type_NEW_Auto_Fill</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <description>auto updates Activity Task New field with value Email whenever old Activity Type field is equal to EMAIL</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Completed Date</fullName>
        <actions>
            <name>Completed_Date_Auto_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Eng%2FOps Task Complete</fullName>
        <actions>
            <name>Interconnection_App_Task_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Used in email notification when a task is completed for engineering/ ops interconnection app</description>
        <formula>AND(   RecordType.Id = &quot;01234000000GGfk&quot;,   ISPICKVAL( Status , &quot;Completed&quot;),  ((DATEVALUE( CreatedDate )) &gt; DATE(2016,12,12))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Respond to Scheduling Meeting Output Email</fullName>
        <actions>
            <name>Respond_to_Scheduling_Meeting_Output_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Respond to Scheduling Meeting Output Email</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Activity_Type_NEW__c</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <description>alerts AE that a Task to Respond to Scheduling Meeting Output Email has been assigned to them</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Schedule Pricing Meeting Alert to AE</fullName>
        <actions>
            <name>Schedule_Pricing_Meeting_Alert_to_AE</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Schedule Pricing Meeting</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Activity_Type_NEW__c</field>
            <operation>equals</operation>
            <value>Initial meeting</value>
        </criteriaItems>
        <description>alerts AE that a Task to Schedule a Pricing Meeting has been assigned to them</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Email re%3A Scheduling Meeting Output</fullName>
        <actions>
            <name>Send_Email_re_Scheduling_Meeting_Output</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Send Email re: Scheduling Meeting Output</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Activity_Type_NEW__c</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <description>alerts AE that a Task to Send Email re: Scheduling Meeting Output has been assigned to them</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Task Activity Type NEW Email update</fullName>
        <actions>
            <name>Task_Type_Field_Auto_Update_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>contains</operation>
            <value>Email</value>
        </criteriaItems>
        <description>automatically updates the Acitivty Type field to Email whenever email is used in the subject</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Updates Completed Date upon</fullName>
        <actions>
            <name>Completed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ops/Engineering</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
