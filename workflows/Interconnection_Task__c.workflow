<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Interconnection_Task_Assigned_to_You</fullName>
        <description>Interconnection Task Assigned to You</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_to__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Interconnection_Task_Assigned_to_You</template>
    </alerts>
    <alerts>
        <fullName>Interconnection_Task_Complete</fullName>
        <description>Interconnection Task Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Assigned_to__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Interconnection_Task_Complete</template>
    </alerts>
    <fieldUpdates>
        <fullName>Date_Complete</fullName>
        <description>time stamps when the Status moves to Complete</description>
        <field>Date_Complete__c</field>
        <formula>TODAY()</formula>
        <name>Date Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Comments_History</fullName>
        <description>Auto populates values from Comments field and date stamps and initial stamps to build historical trail in Comments History field</description>
        <field>Comments_History__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; 
+ LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot; 
+  Comments__c  + BR() + 
BR() + PRIORVALUE(  Comments_History__c  )</formula>
        <name>Update Comments History</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Interconnection Task Assigned to You</fullName>
        <actions>
            <name>Interconnection_Task_Assigned_to_You</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Emails assignee when an interconnection task has been assigned to them</description>
        <formula>OR(
ISCHANGED(Assigned_to__c ),
 ISNEW() 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Interconnection Task Complete</fullName>
        <actions>
            <name>Interconnection_Task_Complete</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Task__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Sends out email when the status of the Interconnection Task is Complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Comments History</fullName>
        <actions>
            <name>Update_Comments_History</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto populates comments field into historical tracking field Comments History</description>
        <formula>ISCHANGED( Comments__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
