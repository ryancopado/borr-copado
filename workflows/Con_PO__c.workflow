<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AaronApproved</fullName>
        <description>Aaron Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Aaron_Approved</template>
    </alerts>
    <alerts>
        <fullName>ChangeinPOAmount</fullName>
        <description>Change in PO Amount</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Change_in_PO_Amount</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Approved</fullName>
        <description>Invoice Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Invoice_Approved</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Attached</fullName>
        <description>Invoice Attached</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Invoice_AttachedtoPO</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Received_Email</fullName>
        <description>Invoice Received Email</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Invoice_Received</template>
    </alerts>
    <alerts>
        <fullName>PMApproved</fullName>
        <description>PM Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PM_Approved</template>
    </alerts>
    <alerts>
        <fullName>POFixed</fullName>
        <description>PO Fixed</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PO_Fixed</template>
    </alerts>
    <alerts>
        <fullName>PORejected</fullName>
        <description>PO Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PO_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Reminder_to_update_Material_Status</fullName>
        <description>Reminder to update Material Status</description>
        <protected>false</protected>
        <recipients>
            <recipient>Project Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Update_PO_Status_Material_Received</template>
    </alerts>
    <alerts>
        <fullName>Sunlink_PO_Approved_Alert_to_Anita</fullName>
        <description>Sunlink PO Approved- Alert to Anita</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PM_Approved_Sunlink</template>
    </alerts>
    <alerts>
        <fullName>Vendor_Confirmed_Delivery_Date_Update</fullName>
        <description>Vendor Confirmed Delivery Date Update</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Vendor_Confirmed_Delivery_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>Vendor_Shipped_Material_notification</fullName>
        <description>Vendor Shipped Material notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Project Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Vendor_Shipped_Material</template>
    </alerts>
    <fieldUpdates>
        <fullName>Zero_Tax_Rate</fullName>
        <description>Sets Tax Rate field to zero if Tax Exemption Status field is set to Exempt.</description>
        <field>Tax_Rate__c</field>
        <formula>0</formula>
        <name>Zero Tax Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
