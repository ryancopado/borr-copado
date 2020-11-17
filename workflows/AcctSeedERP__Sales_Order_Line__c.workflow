<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AP_Admin_Notice2</fullName>
        <description>AP Admin Notice</description>
        <protected>false</protected>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/AP_Admin_Service_Req</template>
    </alerts>
    <alerts>
        <fullName>AP_Admin_notice</fullName>
        <description>AP Admin notice</description>
        <protected>false</protected>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Con_Req_Approved_Email_notification_Tanya_specific_project_names</fullName>
        <description>Con Req Approved Email notification Tanya specific project names</description>
        <protected>false</protected>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Const_Req_Approved_1</template>
    </alerts>
    <alerts>
        <fullName>Construction_Req_Approved_Affiliate_Fees</fullName>
        <description>Construction Req Approved - Affiliate Fees</description>
        <protected>false</protected>
        <recipients>
            <recipient>tmatsuo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Construction_Req_Approved_Affiliate_Fees</template>
    </alerts>
    <alerts>
        <fullName>Development_Cost_Approved</fullName>
        <description>Development Cost Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Senior_Treasury_Analyst</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Purchase_Approved_Development</template>
    </alerts>
    <alerts>
        <fullName>Material_Purchase_Approved</fullName>
        <description>Material Purchase Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Expeditor</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Purchase_Approved_Major_ConReq</template>
    </alerts>
    <alerts>
        <fullName>Modules_Inverters_CR_approved</fullName>
        <description>Modules/Inverters CR approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Purchase_Approved_ConReq</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved</fullName>
        <description>Purchase Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Purchase_Approved_ConReq</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_BSS_Projects</fullName>
        <description>Purchase Approved BSS Projects</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Purchase_Approved_ConReq</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_Sub</fullName>
        <description>Purchase Approved-Sub</description>
        <protected>false</protected>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marlise@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Purchase_Approved_Sub_OtherConReq</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_Sub_BSS_Projects</fullName>
        <description>Purchase Approved-Sub BSS Projects</description>
        <protected>false</protected>
        <recipients>
            <recipient>asandonato@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marlise@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Purchase_Approved_Sub_OtherConReq</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Rejected</fullName>
        <description>Purchase Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseRejected</template>
    </alerts>
    <alerts>
        <fullName>Svc_Con_Req_Approved</fullName>
        <description>Svc Con Req Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Con_Req_Approved</template>
    </alerts>
    <alerts>
        <fullName>Svc_Con_Req_Approved2</fullName>
        <description>Svc Con Req Approved2</description>
        <protected>false</protected>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Con_Req_Approved</template>
    </alerts>
    <alerts>
        <fullName>Svc_Con_Req_Rejected</fullName>
        <description>Svc Con Req Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Con_Req_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Status_ConReq_Update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status Con Req Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_Con_Req_Recall</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Approval Status Con Req Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ConReq_Creator_ID</fullName>
        <field>Con_Req_Creator_ID__c</field>
        <formula>$User.Id</formula>
        <name>ConReq Creator ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Approved</fullName>
        <field>Date_Approved__c</field>
        <formula>TODAY()</formula>
        <name>Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Locked_update</fullName>
        <field>Locked__c</field>
        <literalValue>1</literalValue>
        <name>Locked update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending Approval</name>
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
        <fullName>Sales_Order_Line_APPROVED</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Sales Order Line APPROVED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Order_Line_REJECTED</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Sales Order Line REJECTED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Tax_Rate_CR</fullName>
        <field>Sales_Tax_Rate_Percent__c</field>
        <formula>AcctSeedERP__Project__r.TaxGroup__r.Tax_Group_Percent__c</formula>
        <name>Set Tax Rate CR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status to approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Dev_Cost_Checkbox</fullName>
        <field>Development_Cost__c</field>
        <literalValue>1</literalValue>
        <name>Update Dev Cost Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sales_Tax_Rate</fullName>
        <field>Sales_Tax_Rate_Percent__c</field>
        <formula>Tax_Group__r.Tax_Group_Percent__c</formula>
        <name>Update Sales Tax Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_to_rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>status to rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Con Req Approval Status Update</fullName>
        <actions>
            <name>Approval_Status_ConReq_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Sales_Order_Line__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Updates the &quot;Approval Status&quot; when the Status is &quot;Approved&quot; 
Used for creating POs</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Con Req Approval Status Update- Recall</fullName>
        <actions>
            <name>Approval_Status_Con_Req_Recall</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Sales_Order_Line__c.Status__c</field>
            <operation>equals</operation>
            <value>Recalled</value>
        </criteriaItems>
        <description>Updates the &quot;Approval Status&quot; when the Status is &quot;Recalled&quot; 
Used for creating POs</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Con Req Approved Notification for Tanya on BSS Campbell</fullName>
        <actions>
            <name>Con_Req_Approved_Email_notification_Tanya_specific_project_names</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>BSS-Campbell Carport Reinforcing</description>
        <formula>ISPICKVAL(Status__c,&quot;Approved&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Con Req Approved Notification for Tanya on BSS WCI</fullName>
        <actions>
            <name>Con_Req_Approved_Email_notification_Tanya_specific_project_names</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>BSS- West Coast Iron Carport Reinforcing</description>
        <formula>ISPICKVAL(Status__c,&quot;Approved&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Construction Req Approved - Affiliate Fees</fullName>
        <actions>
            <name>Construction_Req_Approved_Affiliate_Fees</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify accounting if a construction requisition with the affiliate/referral fee line item was approved.</description>
        <formula>AND(RecordTypeId = &quot;012800000007gwc&quot;,ISPICKVAL( Status__c,&quot;Approved&quot;), CONTAINS(AcctSeedERP__Project_Task__r.Name,&quot;Affiliate&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Dev Cost Checkbox</fullName>
        <actions>
            <name>Update_Dev_Cost_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISPICKVAL(AcctSeedERP__Project__r.WIP_Status__c , &quot;On WIP&quot;))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Email Tanya to create PO2</fullName>
        <actions>
            <name>Svc_Con_Req_Approved2</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ISPICKVAL(Status__c , &quot;Approved&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Locked</fullName>
        <actions>
            <name>Locked_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Sales_Order_Line__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeedERP__Sales_Order_Line__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Tax Rate CR</fullName>
        <actions>
            <name>Set_Tax_Rate_CR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Sales_Order_Line__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Major Component,Minor Component</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update ConReq Creator ID</fullName>
        <actions>
            <name>ConReq_Creator_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>populates with the conreq creator ID upon creation</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
