<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>X5_Days_Since_Goals_Created_but_Not_Submitted</fullName>
        <description>5 Days Since Goals Created but Not Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>EGT_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X15_Days_Since_Goals_Created_but_Not_Submitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>Clear_out_Approved_Date</fullName>
        <field>Approval_Date__c</field>
        <name>Clear out Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EGT_Email</fullName>
        <description>fills in the EGT email</description>
        <field>EGT_Email__c</field>
        <formula>EmployeeDevelopmentTracker__r.Employee_Contact__r.Email</formula>
        <name>EGT Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Clear out Approved Date</fullName>
        <actions>
            <name>Clear_out_Approved_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EGT_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Goals__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>clears out approved date upon record creation</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Goals still need to be submitted</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Goals__c.Goal_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>fire email alert 5 days after a goal was created but not submitted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X5_Days_Since_Goals_Created_but_Not_Submitted</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
