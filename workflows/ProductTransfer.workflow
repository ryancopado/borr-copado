<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Inventory_Requested_En_Route</fullName>
        <description>Inventory Requested En Route</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_To_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Inventory_Requested_En_Route</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_for_Product_Transfer_Received</fullName>
        <description>Send Email for Product Transfer Received</description>
        <protected>false</protected>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Product_Transfer_Received</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_for_Product_Transfer_Received_Alert</fullName>
        <ccEmails>OandMpurchasing@borregosolar.com</ccEmails>
        <description>Send Email for Product Transfer Received</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Product_Transfer_Quantity_Mismatch</template>
    </alerts>
    <alerts>
        <fullName>Transfer_Received_Less_than_Sent</fullName>
        <ccEmails>oandmpurchasing@borregosolar.com</ccEmails>
        <description>Transfer Received Less than Sent</description>
        <protected>false</protected>
        <recipients>
            <recipient>rallen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Transfer_Received_Less_than_Sent</template>
    </alerts>
    <rules>
        <fullName>Product Transfer Quantity Mismatch</fullName>
        <actions>
            <name>Send_Email_for_Product_Transfer_Received_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>QuantityReceived  &lt;&gt;  QuantitySent &amp;&amp;  IsReceived = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email When Product Transfer Received</fullName>
        <actions>
            <name>Send_Email_for_Product_Transfer_Received</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>ProductTransfer.IsReceived</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
