<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Product_Item_Adjusted_by_Technician</fullName>
        <ccEmails>oandmpurchasing@borregosolar.com</ccEmails>
        <description>Product Item Adjusted by Technician</description>
        <protected>false</protected>
        <senderAddress>oandmpurchasing@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Inventory_Email_Templates/Product_Item_Adjusted_by_Technician</template>
    </alerts>
    <alerts>
        <fullName>Products_Manually_Adjusted</fullName>
        <description>Products Manually Adjusted</description>
        <protected>false</protected>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Products_Manually_Adjusted</template>
    </alerts>
    <rules>
        <fullName>Products Manually Adjusted</fullName>
        <actions>
            <name>Products_Manually_Adjusted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ProductItemTransaction.TransactionType</field>
            <operation>equals</operation>
            <value>Adjusted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
