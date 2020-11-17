<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ED_Tracker_Goals_Approved</fullName>
        <description>ED Tracker - Goals Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Development_Goals_Approved</template>
    </alerts>
    <alerts>
        <fullName>Employee_Goals_Rejected</fullName>
        <description>Employee Goals Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Employee_Goals_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Submit_New_Quarter_Goals</fullName>
        <description>Submit New Quarter Goals</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Submit_New_Quarter_Goals</template>
    </alerts>
    <alerts>
        <fullName>X15_Days_Since_Goals_Created_but_Not_Submitted</fullName>
        <description>5 Days Since Goals Created but Not Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X15_Days_Since_Goals_Created_but_Not_Submitted</template>
    </alerts>
    <alerts>
        <fullName>X15_Days_Since_Goals_Submitted_for_Approval</fullName>
        <description>5 Days Since Goals Submitted for Approval</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X15_Days_Since_Goals_Submitted_for_Approval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Date</fullName>
        <field>Approval_Date__c</field>
        <formula>NOW()</formula>
        <name>Approval Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <description>when manager approves the goals, updates status to Approved</description>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_New_Goals</fullName>
        <description>Sets the Status to Ready for New Goals</description>
        <field>Status__c</field>
        <literalValue>Ready for New Goals</literalValue>
        <name>Ready for New Goals</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recall_Cancel</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Recall/Cancel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejection</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Ready_for_New_Goals</fullName>
        <description>updates the status</description>
        <field>Status__c</field>
        <literalValue>Ready for New Goals</literalValue>
        <name>Status: Ready for New Goals</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Goals Still Need to be Approved</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employee_Development_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending Approval</value>
        </criteriaItems>
        <description>send email reminder for approval after 5 days of pending status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X15_Days_Since_Goals_Submitted_for_Approval</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Goals Still Need to be Submitted</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Employee_Development_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>send email reminder for approval after 5 days of New status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X15_Days_Since_Goals_Created_but_Not_Submitted</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Ready for New Goals</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employee_Development_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>changes the status of the EGT to Ready for New Goals after a period of time</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Status_Ready_for_New_Goals</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Development_Tracker__c.Approval_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Reset EGT to New</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Employee_Development_Tracker__c.Initiate_Time_Based_WF__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employee_Development_Tracker__c.Status__c</field>
            <operation>notEqual</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Submit_New_Quarter_Goals</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Ready_for_New_Goals</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Development_Tracker__c.Q2__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Ready_for_New_Goals</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Development_Tracker__c.Q1__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Submit_New_Quarter_Goals</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Ready_for_New_Goals</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Development_Tracker__c.Q4__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Submit_New_Quarter_Goals</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Ready_for_New_Goals</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Development_Tracker__c.Q3__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
