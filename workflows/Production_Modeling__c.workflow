<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Create_a_Guarantee_Model</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Create a Guarantee Model</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofTechnology</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Engineering_Resource_Group</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Create_a_Guarantee_Model</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_production_modeling_request_has_been_completed</fullName>
        <description>Email alert when production modeling request has been completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_Request_Complete</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_production_modeling_request_has_been_submitted</fullName>
        <description>Email alert when production modeling request has been submitted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>NonPPA_Production_Model_Current_Approved_As_Built_and_IE</fullName>
        <description>non-PPA Production Model Current Approved- As Built and IE</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_asbuilt_Approved</template>
    </alerts>
    <alerts>
        <fullName>Performance_Test_production_modeling_approval_Email_notification</fullName>
        <description>Performance Test production modeling approval Email notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Performance_Test_Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Guarantee_Notification</fullName>
        <description>Production Guarantee Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Guarantee_Notification</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved</fullName>
        <description>Production Model Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/nonPPAProduction_Model_approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved_East</fullName>
        <description>Production Model Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>asachdeva@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>logren@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved_Gary_Notification</fullName>
        <description>Production Model Approved_Gary Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_Approved_Gary</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved_Notify_PM</fullName>
        <description>Production Model Approved Notify PM</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pdelmar@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved_PM_Notification</fullName>
        <description>Production Model Approved PM Notification</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_Approved_Gary</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Approved_West</fullName>
        <description>Production Model Approved West</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>jsmith@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Bradley_Approved</fullName>
        <description>Production Model Current Approved- West</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Current_ApprovedEast</fullName>
        <description>Production Model Current Approved- EAST</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Current_ApprovedWest</fullName>
        <description>Production Model Current Approved- West</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fmatin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Current_Approved_As_Built_and_IE</fullName>
        <description>Production Model Current Approved- As Built and IE</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wbush@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Production_Model_asbuilt_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_First_Approved_East</fullName>
        <description>Production Model First Approved East</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>jtai@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_First_Approved_West</fullName>
        <description>Production Model First Approved West</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Approved</template>
    </alerts>
    <alerts>
        <fullName>Production_Model_Rejected</fullName>
        <description>Production Model Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>asachdeva@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>logren@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Production_Model_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Turnkey_Production_Modeling_Approved</fullName>
        <description>Turnkey Production Modeling Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Turnkey_Production_Modeling_Approved</template>
    </alerts>
    <alerts>
        <fullName>Turnkey_Production_Modeling_Rejected</fullName>
        <description>Turnkey Production Modeling Rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Turnkey_Production_Modeling_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Turnkey_Production_Modeling_Submitted</fullName>
        <description>Turnkey Production Modeling Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Turnkey_Production_Modeling_Submitted</template>
    </alerts>
    <alerts>
        <fullName>email_notification_when_production_guarantee_production_model_has_been_approved</fullName>
        <description>email notification when production guarantee production model has been approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Performance_Guarantee_Production_Model_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_for_CC</fullName>
        <field>Status__c</field>
        <literalValue>Approved for CC</literalValue>
        <name>Approved for CC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_Apps_Engineer_Email_Update</fullName>
        <field>Assigned_Apps_Engineer_Email__c</field>
        <formula>Opportunity__r.Assigned_Apps_Engineer__r.Email</formula>
        <name>Assigned Apps Engineer Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cancel_request_Checkbox_Uncheck</fullName>
        <description>unchecks the checkbox cancel request to be used again</description>
        <field>Cancel_Request__c</field>
        <literalValue>0</literalValue>
        <name>Cancel request Checkbox Uncheck</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ChangeFlagForApprovalProcess</fullName>
        <description>This is used to find out approval update action in trigger</description>
        <field>IsSubmittedForApproval__c</field>
        <literalValue>1</literalValue>
        <name>ChangeFlagForApprovalProcess</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_PM_Request_Date</fullName>
        <description>auto date stamps completed date</description>
        <field>Date_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Completed PM Request Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_PM_Request_Status</fullName>
        <description>auto updates request status to Completed</description>
        <field>Request_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Completed PM Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Current_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Current Approved</literalValue>
        <name>Current Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Created_for_Workflow_update</fullName>
        <field>Date_Created_for_Workflows__c</field>
        <formula>TODAY()</formula>
        <name>Date Created for Workflow update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Financing_Source</fullName>
        <description>brings over value from opportunity at time of creation of modeling request</description>
        <field>Financing_Source__c</field>
        <formula>Case( Opportunity__r.Financing__c, 
&quot;Cash&quot;, &quot;Cash&quot;, 
&quot;PPA&quot;,&quot;PPA&quot;, 
&quot;Lease&quot;, &quot;Lease&quot;, 
&quot;PACE&quot;,&quot;PACE&quot;,
&quot;GO Bond&quot;, &quot;GO Bond&quot;,
&quot;Other&quot;)</formula>
        <name>Financing Source</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>First_Approved</fullName>
        <field>Status__c</field>
        <literalValue>First Approved</literalValue>
        <name>First Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PM_Submitted_Date_Update</fullName>
        <field>Date_Submitted__c</field>
        <formula>TODAY()</formula>
        <name>PM Submitted Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Performance_Guarantee_Included</fullName>
        <description>brings over value of this field from the Oppty upon creation only</description>
        <field>Production_Guarantee_Included__c</field>
        <formula>Case( Opportunity__r.Performance_Guarantee_Included__c, 
&quot;Yes&quot;,&quot;Yes&quot;, 
&quot;No&quot;, &quot;No&quot;, 
Null)</formula>
        <name>Performance Guarantee Included</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Production_Model_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Production Model Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Production_Model_Request_Submitted</fullName>
        <description>updates request status field when request submitted button is selected</description>
        <field>Request_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Production Model Request Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RG_Approved</fullName>
        <field>Status__c</field>
        <literalValue>RG Approved</literalValue>
        <name>RG Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalled</fullName>
        <field>Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Status_Cancelled</fullName>
        <description>sets the Status of Request Status field to Cancelled</description>
        <field>Request_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Request Status Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Specific_Yield_PM_to_Opportunity</fullName>
        <field>Most_Recent_Specific_Yield_from_PM__c</field>
        <formula>Specific_Yield_kWh_kWp__c</formula>
        <name>Specific Yield PM to Opportunity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Opportunity__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Cancelled</fullName>
        <description>sets the Status field to Cancelled</description>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Status Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Assigned Apps Engineer Email Update</fullName>
        <actions>
            <name>Assigned_Apps_Engineer_Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>pulls over email address from related opportunity assigned apps engineer field so they can be included in related communications</description>
        <formula>Opportunity__r.Assigned_Apps_Engineer__c &lt;&gt; null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Cancel PM Request</fullName>
        <actions>
            <name>Cancel_request_Checkbox_Uncheck</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Request_Status_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Status_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Cancel_Request__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Completed Production Modeling Request</fullName>
        <actions>
            <name>Email_alert_when_production_modeling_request_has_been_completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Completed_PM_Request_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Completed_PM_Request_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Create a Guarantee Model</fullName>
        <actions>
            <name>Create_a_Guarantee_Model</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>email alert to SPG team</description>
        <formula>AND( ISPICKVAL(Opportunity__r.Performance_Guarantee_Included__c, &quot;Yes&quot;), ISPICKVAL(Production_Modeling_Stage__c , &quot;Record Drawing&quot;), ISPICKVAL(Status__c, &quot;Approved&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Date Created</fullName>
        <actions>
            <name>Date_Created_for_Workflow_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>date stamps when created to be used for date needed by validation rule</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Financing Request</fullName>
        <actions>
            <name>Financing_Source</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>brings over value from opportunity upon creation only</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Performance Guarantee Included</fullName>
        <actions>
            <name>Performance_Guarantee_Included</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>brings over value from opportunity upon creation only</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Production Model Approved_ Gary</fullName>
        <actions>
            <name>Production_Model_Approved_Gary_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Production_Modeling__c.Production_Modeling_Stage__c</field>
            <operation>equals</operation>
            <value>Performance Test,Performance Guarantee,CD IFR,CD IFC,Record Drawing</value>
        </criteriaItems>
        <description>Rule executes when a Production Model has been Approved and the Stage is As Built, Performance Test or Performance Guarantee</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Production Model Approved_ PM</fullName>
        <actions>
            <name>Production_Model_Approved_PM_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Production_Modeling__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Production_Modeling__c.Production_Modeling_Stage__c</field>
            <operation>equals</operation>
            <value>Design</value>
        </criteriaItems>
        <description>Rule executes when a Production Model has been Approved and the Stage is Design</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Production Modeling Request Submitted</fullName>
        <actions>
            <name>Email_alert_when_production_modeling_request_has_been_submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PM_Submitted_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Production_Model_Request_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>updates request status to submitted when submit request button is selected</description>
        <formula>ISPICKVAL(Request_Status__c, &quot;Submitted&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Opportunity fields once approved</fullName>
        <actions>
            <name>Specific_Yield_PM_to_Opportunity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Production_Modeling__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>When Production Modeling Approval Status is changed to Approved, update opportunity fields with most recent data</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
