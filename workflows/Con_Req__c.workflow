<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AaronPurchasing</fullName>
        <description>Aaron - Purchasing</description>
        <protected>false</protected>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Major_Comp_Approved</template>
    </alerts>
    <alerts>
        <fullName>ApprovedMajor</fullName>
        <description>Approved - Major</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Purchase_Approved_Major</template>
    </alerts>
    <alerts>
        <fullName>ApprovedMinor</fullName>
        <description>Purchase Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Project_PM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Purchase_Approved_Minor_Sub</template>
    </alerts>
    <alerts>
        <fullName>CO_Needs_Customer_Approval</fullName>
        <description>CO - Needs Customer Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>elaramee@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Project_PM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Order_Approve_by_Customer</template>
    </alerts>
    <alerts>
        <fullName>ChangeOrderApproved</fullName>
        <description>Change Order - Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Project_PM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>ChangeOrderSentforSignature</fullName>
        <description>Change Order - Sent for Signature</description>
        <protected>false</protected>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_Order_Sent_For_Signature</template>
    </alerts>
    <alerts>
        <fullName>Change_Order_Approved_by_Customer</fullName>
        <description>Change Order - Approved by Customer</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>lwikholm@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_Order_Approved_by_Customer</template>
    </alerts>
    <alerts>
        <fullName>Customer_Change_Order_Approved</fullName>
        <description>Customer Change Order Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>jhetzel@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lwikholm@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tmatsuo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Customer_Change_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_procurement_when_Material_PO_Change_Order_is_approved</fullName>
        <description>Email alert to procurement when Material PO Change Order is approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Expeditor</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>Material_PO_Change_Order_Approved</fullName>
        <description>Material PO Change Order Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Expeditor</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sosterling@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>Rejected</fullName>
        <description>Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Project_PM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Rejected</template>
    </alerts>
    <alerts>
        <fullName>Subcontractor_CO_Approved</fullName>
        <description>Subcontractor CO Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Project_PM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Approved_Granted_Sub_CO</template>
    </alerts>
    <alerts>
        <fullName>Subcontractor_change_order_has_been_approved</fullName>
        <description>Subcontractor change order has been approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lverdone@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Sub_Change_Order_Approved</template>
    </alerts>
    <alerts>
        <fullName>Vendor_Status_Update</fullName>
        <description>Vendor Status Update</description>
        <protected>false</protected>
        <recipients>
            <recipient>Project Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Vendor_Status_Change</template>
    </alerts>
    <fieldUpdates>
        <fullName>Adjusted_System_Size</fullName>
        <field>Adjusted_System_SizeCOConReq__c</field>
        <formula>IF( AND( RecordType.Name &lt;&gt; &quot;Subcontractor Change Order&quot;, NOT( ISPICKVAL( Change_Order_Type__c , &quot;Contract Price Change&quot;)), NOT( ISBLANK( Product__c ) ), NOT( ISBLANK( New_QuantityCOConReq__c ) ), NOT( ISBLANK( Product__r.Watts_STC__c ) ) ) , Product__r.Watts_STC__c * New_QuantityCOConReq__c, null)</formula>
        <name>Adjusted System Size</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Amount_Requested</fullName>
        <description>Populates the unit price * quantity on the material change order. Allows the Amount Requested field to work independently across record types</description>
        <field>Amount_Requested__c</field>
        <formula>Unit_Price2__c * New_Quantity__c</formula>
        <name>Amount Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ApprovalPending</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved_by_customer</fullName>
        <field>Status__c</field>
        <literalValue>Approved By Customer</literalValue>
        <name>Approved by customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Borrego_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Borrego Approved</literalValue>
        <name>Borrego Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CO_Status_Change_Update</fullName>
        <field>COStatusDateChange__c</field>
        <formula>TODAY()</formula>
        <name>CO Status Change Update</name>
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
        <fullName>Date_Submitted_for_Approval</fullName>
        <field>Date_Submitted_for_Approval__c</field>
        <formula>TODAY()</formula>
        <name>Date Submitted for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <literalValue>X - Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetApprovedCOTotal</fullName>
        <field>Approved_Change_Order_Total__c</field>
        <formula>Original_Unit_Price__c + Amount_Requested__c +  Budget_Line_Item__r.Approved_Sub_Change_Order_Amount__c</formula>
        <name>Set Approved CO Total</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SetDateRequested</fullName>
        <field>Date_Requested__c</field>
        <formula>Today()</formula>
        <name>Set Date Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Approved_CO_Total</fullName>
        <field>Approved_Change_Order_Total__c</field>
        <formula>Original_Unit_Price__c + Amount_Requested__c</formula>
        <name>Set Approved CO Total</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Requested</fullName>
        <field>Date_Requested__c</field>
        <formula>Today()</formula>
        <name>Set Date Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Lock_For_ChangeOrder</fullName>
        <field>IsLocked__c</field>
        <literalValue>1</literalValue>
        <name>Set Lock For ChangeOrder</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Unit_Price</fullName>
        <field>Original_Unit_Price__c</field>
        <formula>Purchase_Order__r.Unit_Price__c</formula>
        <name>Set Unit Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UnLock_ChangeOrder</fullName>
        <field>IsLocked__c</field>
        <literalValue>0</literalValue>
        <name>UnLock ChangeOrder</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_IsSubmitted_Flag</fullName>
        <description>This flag is set and used during approval process for raise error while vendor account type is not &quot;Business&quot;</description>
        <field>IsSubmitted__c</field>
        <literalValue>1</literalValue>
        <name>Update IsSubmitted Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Amount Requested</fullName>
        <actions>
            <name>Amount_Requested</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When New Quantity or Unit Price are changed, the Amount Requested field is updated</description>
        <formula>AND( RecordTypeId = &quot;012800000007gum&quot;, OR( ISNEW(), OR( ISCHANGED( New_Quantity__c ), ISCHANGED( Unit_Price2__c ))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CO - Approval Reminder</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req__c.Status__c</field>
            <operation>equals</operation>
            <value>Borrego Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Con_Req__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer Change Order</value>
        </criteriaItems>
        <description>Sets the date to remind PM if a Cust CO still needs to be marked Approved by Customer</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CO_Needs_Customer_Approval</name>
                <type>Alert</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>CO_Needs_Customer_Approval</name>
                <type>Alert</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>CO_Needs_Customer_Approval</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CO Status Change Date</fullName>
        <actions>
            <name>CO_Status_Change_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto fills status change date when CO Status field is updated</description>
        <formula>ISCHANGED ( Change_Order_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Order - Adjusted System Size</fullName>
        <actions>
            <name>Adjusted_System_Size</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Approved By Customer</value>
        </criteriaItems>
        <description>Set the field &quot;Adjusted System Size&quot; under certain conditions (see the field update formula).</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Order - Approved</fullName>
        <actions>
            <name>ChangeOrderApproved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Order - Approved Material PO</fullName>
        <actions>
            <name>Email_alert_to_procurement_when_Material_PO_Change_Order_is_approved</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Material_PO_Change_Order_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Excludes O&amp;M</description>
        <formula>AND(  OR(   ISPICKVAL( Status__c , &quot;Approved&quot; ),   ISPICKVAL( Status__c , &quot;Borrego Approved&quot; )   ),  RecordTypeId = &quot;012800000007gum&quot; ,  ASProject__r.RecordTypeId &lt;&gt; &quot;012340000007kca&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Purchase Order Selected</fullName>
        <actions>
            <name>Set_Unit_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>trigger when a PO is newly selected or different from before</description>
        <formula>OR ( Purchase_Order__c  &lt;&gt; PRIORVALUE (  Purchase_Order__c) ,           Original_Unit_Price__c  &lt;&gt; PRIORVALUE (  Original_Unit_Price__c),          ISBLANK ( Original_Unit_Price__c )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
