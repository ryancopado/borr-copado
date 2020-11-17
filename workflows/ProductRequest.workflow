<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Field_Purchase_24_Hour_Reminder</fullName>
        <description>Field Purchase 24 Hour Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Field_Purchase_24_Hour_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Field_Purchase_Request_Notification</fullName>
        <description>Field Purchase Request Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>rallen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Field_Purchase_Request_Notification</template>
    </alerts>
    <alerts>
        <fullName>Inventory_Request_Approved</fullName>
        <description>Inventory Request Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_to_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Inventory_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Inventory_Request_Rejected</fullName>
        <description>Inventory Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_to_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Inventory_Request_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Inventory_Requested_En_Route_Mass_Transfer</fullName>
        <description>Inventory Requested En Route - Mass Transfer</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_to_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Inventory_Requested_En_Route</template>
    </alerts>
    <alerts>
        <fullName>PR_Inventory_Requested_En_Route</fullName>
        <description>PR Inventory Requested En Route</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_to_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/PR_Inventory_Requested_En_Route</template>
    </alerts>
    <alerts>
        <fullName>Product_Request_Rejected</fullName>
        <description>Product Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Product_Request_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Inventory_Request_Status_Completed</fullName>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Inventory Request Status Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inventory_Request_Status_IM_Review</fullName>
        <field>Status</field>
        <literalValue>IM Review</literalValue>
        <name>Inventory Request Status IM Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inventory_Request_Status_Rejected</fullName>
        <field>Status</field>
        <literalValue>Rejected</literalValue>
        <name>Inventory Request Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inventory_Request_Status_Submitted</fullName>
        <field>Status</field>
        <literalValue>Submitted</literalValue>
        <name>Inventory Request Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Request_Rejected</fullName>
        <field>Customer_Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Product Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Request_Status_to_Approved</fullName>
        <field>Request_Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Set Request Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Approved</fullName>
        <field>Customer_Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Set Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Customer_Approval_Status_to_Pendi</fullName>
        <field>Customer_Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Update Customer Approval Status to Pendi</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Field Purchase 24 Hour Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>ProductRequest.Request_Type__c</field>
            <operation>equals</operation>
            <value>Field Purchase</value>
        </criteriaItems>
        <criteriaItems>
            <field>ProductRequest.Status</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Field_Purchase_24_Hour_Reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>ProductRequest.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Request is billable</fullName>
        <actions>
            <name>Update_Customer_Approval_Status_to_Pendi</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>ProductRequest.Billable__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
