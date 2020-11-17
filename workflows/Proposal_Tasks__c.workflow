<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Proposal_Request_Status_Completed</fullName>
        <description>Proposal Request Status: Completed</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Complete</template>
    </alerts>
    <alerts>
        <fullName>Proposal_Request_Status_Draft_Posted</fullName>
        <description>Proposal Request Status: Draft Posted</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Ready_for_Review</template>
    </alerts>
    <alerts>
        <fullName>Proposal_Request_Status_Review_Session_Ended</fullName>
        <description>Proposal Request Status: Review Session Ended</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Review_SEssion_Ended</template>
    </alerts>
    <alerts>
        <fullName>Proposal_Task_Assigned</fullName>
        <description>Proposal Task Assigned</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Task_Created</template>
    </alerts>
    <alerts>
        <fullName>Proposal_Task_Complete</fullName>
        <description>Proposal Task Complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Task_Complete</template>
    </alerts>
    <alerts>
        <fullName>Proposal_task_1_day</fullName>
        <description>Proposal task 1 day</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Task_due_in_1_days</template>
    </alerts>
    <alerts>
        <fullName>Proposal_task_5_days</fullName>
        <description>Proposal task 5 days</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Task_due_in_5_days</template>
    </alerts>
    <fieldUpdates>
        <fullName>Clear_ProposalTaskWorkflow</fullName>
        <field>ProposalTaskWorkflow__c</field>
        <literalValue>0</literalValue>
        <name>Clear ProposalTaskWorkflow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>New Task Assigned</fullName>
        <actions>
            <name>Proposal_Task_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.Person_Responsible__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>emails the Person responsible when a new task is created for them</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Request Status%3A Completed</fullName>
        <actions>
            <name>Proposal_Request_Status_Completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Clear_ProposalTaskWorkflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.ProposalTaskWorkflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Proposal_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Execute actions if the Status field of the related Proposal Request is &quot;Completed&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Request Status%3A Draft Posted</fullName>
        <actions>
            <name>Proposal_Request_Status_Draft_Posted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Clear_ProposalTaskWorkflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.ProposalTaskWorkflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Proposal_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft Posted</value>
        </criteriaItems>
        <description>Execute actions if the Status field of the related Proposal Request is &quot;Draft Posted&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Request Status%3A Review Session Ended</fullName>
        <actions>
            <name>Proposal_Request_Status_Review_Session_Ended</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Clear_ProposalTaskWorkflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.ProposalTaskWorkflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Proposal_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Review Session Ended</value>
        </criteriaItems>
        <description>Execute actions if the Status field of the related Proposal Request is &quot;Review Session Ended&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Task Complete</fullName>
        <actions>
            <name>Proposal_Task_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Email alert to SA when Proposal Task is marked Complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reminder- Proposal Task Due</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Proposal_Tasks__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Complete</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Proposal_task_5_days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Proposal_Tasks__c.Due_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Proposal_task_1_day</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Proposal_Tasks__c.Due_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
