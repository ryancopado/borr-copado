<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Locked_Product_Change</fullName>
        <description>Locked Product Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Locked_Product_Change</template>
    </alerts>
    <alerts>
        <fullName>Project_Product_Change_Notification</fullName>
        <description>Project Product Change Notification</description>
        <protected>false</protected>
        <recipients>
            <field>APM_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Internal_CE_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Internal_EE_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Internal_SE_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>PE_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Project_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>SDE_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Product_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Quantity_change_requires_follow_up</fullName>
        <description>Quantity change requires follow up</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Product_Quantity_Changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>APM_Email_Update</fullName>
        <field>APM_Email__c</field>
        <formula>Site__r.Project_Coordinator_APM__r.Email</formula>
        <name>APM Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Internal_CE_Email</fullName>
        <field>Internal_CE_Email__c</field>
        <formula>Site__r.Internal_Civil_Engineer__r.Email</formula>
        <name>Internal CE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Internal_EE_Email</fullName>
        <field>Internal_EE_Email__c</field>
        <formula>Site__r.Electrical_Engineer__r.Email</formula>
        <name>Internal EE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Internal_SE_Email</fullName>
        <field>Internal_SE_Email__c</field>
        <formula>Site__r.Structural_Engineer__r.Email</formula>
        <name>Internal SE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PE_Email_Address</fullName>
        <field>PE_Email__c</field>
        <formula>Site__r.Civil_Engineer__r.Email</formula>
        <name>PE Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PM_Email</fullName>
        <field>Project_Manager_Email__c</field>
        <formula>Site__r.Project_Manager__r.Email</formula>
        <name>PM Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDE_Email</fullName>
        <field>SDE_Email__c</field>
        <formula>Site__r.Development_SDE__r.Email</formula>
        <name>SDE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Locked Product Changed</fullName>
        <actions>
            <name>Locked_Product_Change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED( Product__c ),  AND(OR(  AND ( RecordTypeId = &quot;012340000007kcc&quot;, OR( ISPICKVAL (Site__r.Modules_Status__c, &quot;Product Locked&quot;), ISPICKVAL (Site__r.Modules_Status__c, &quot;PO Placed&quot;),ISPICKVAL (Site__r.Modules_Status__c, &quot;Borrego Received&quot;))),  AND ( RecordTypeId = &quot;012340000007kcd&quot;, OR( ISPICKVAL (Site__r.Inverter_Status__c, &quot;Product Locked&quot;), ISPICKVAL (Site__r.Inverter_Status__c, &quot;PO Placed&quot;),ISPICKVAL (Site__r.Inverter_Status__c, &quot;Borrego Received&quot;))),  AND ( RecordTypeId = &quot;012340000007kcf&quot; ,OR( ISPICKVAL (Site__r.Racking_Status__c, &quot;Product Locked&quot;), ISPICKVAL (Site__r.Racking_Status__c, &quot;PO Placed&quot;),ISPICKVAL (Site__r.Racking_Status__c, &quot;Borrego Received&quot;))))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Product%2FQuantity Change Notification</fullName>
        <actions>
            <name>Project_Product_Change_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>When Product or Quantity Changes (not set for the first time, but changes from X to Y), send an email alert to Project team on the site + Anita (the PP are related to a site)</description>
        <formula>AND(  NOT( ISNEW()),   OR( Project__r.Opportunity_Stage__c = &quot;Contract Signed&quot;, Project__r.Opportunity_Stage__c = &quot;EPC Signed&quot;), OR(ISCHANGED( Quantity__c ),  ISCHANGED (Product__c )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Quantity Changed</fullName>
        <actions>
            <name>Quantity_change_requires_follow_up</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an email alert when product quality changes when Site component status is Product Locked, PO Placed or Borrego Received</description>
        <formula>AND( ISCHANGED( Quantity__c ),  OR( AND( RecordTypeId = &quot;012340000007kcd&quot;,OR( ISPICKVAL( Site__r.Modules_Status__c, &quot;PO Placed&quot; ), ISPICKVAL( Site__r.Modules_Status__c, &quot;Product Locked&quot; ), ISPICKVAL( Site__r.Modules_Status__c, &quot;Borrego Received&quot; ))), AND( RecordTypeId = &quot;012340000007kcc&quot;, OR( ISPICKVAL( Site__r.Inverter_Status__c, &quot;PO Placed&quot; ), ISPICKVAL( Site__r.Inverter_Status__c, &quot;Product Locked&quot; ), ISPICKVAL( Site__r.Inverter_Status__c, &quot;Borrego Received&quot; )))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Project Team Email addresses</fullName>
        <actions>
            <name>APM_Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Internal_CE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Internal_EE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Internal_SE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PE_Email_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PM_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SDE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto fills email address of team members on related site for the purpose of email notification about changes to Qty and Product</description>
        <formula>OR( ISNEW(),  ISCHANGED(Quantity__c) || ISCHANGED( Product__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
