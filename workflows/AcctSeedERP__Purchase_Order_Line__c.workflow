<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AP_Line_Total_exceeded_the_PO_Line_total</fullName>
        <description>AP Line Total exceeded the PO Line total</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AP_Line_Total_Exceeded_PO_Line_Total</template>
    </alerts>
    <alerts>
        <fullName>Create_a_check_request</fullName>
        <description>Create a check request</description>
        <protected>false</protected>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Create_a_check_request</template>
    </alerts>
    <alerts>
        <fullName>PM_Approved_Inverter_PO</fullName>
        <description>PM Approved Inverter PO</description>
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
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PM_Approved</template>
    </alerts>
    <alerts>
        <fullName>Vendor_Confirmed_Ship_Date_Notification</fullName>
        <description>Vendor Confirmed Ship Date Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Vendor_Confirmed_Ship_Date_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Material_PO_Checkbox</fullName>
        <field>AcctSeedERP__Type__c</field>
        <literalValue>Material</literalValue>
        <name>Material PO Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AcctSeedERP__Purchase_Order__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>POL_Sales_Tax_Rate</fullName>
        <field>Sales_Tax_Rate_Percent__c</field>
        <formula>AcctSeedERP__Project__r.TaxGroup__r.Tax_Group_Percent__c</formula>
        <name>POL Sales Tax Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>POL_Status_Change_Date</fullName>
        <field>POLStatusChangeDate__c</field>
        <formula>TODAY()</formula>
        <name>POL Status Change Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Manager_Email</fullName>
        <field>Project_Manager_Email__c</field>
        <formula>AcctSeedERP__Project__r.Owner:User.Email</formula>
        <name>Project Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Tax_Rate_POL</fullName>
        <field>Sales_Tax_Rate_Percent__c</field>
        <formula>IF( OR(Cost_Code__c= &quot;Racking - Materials&quot;, Cost_Code__c= &quot;Electrical Materials&quot;, Cost_Code__c= &quot;DAS - Materials&quot;,Cost_Code__c= &quot;Solar Modules&quot;,Cost_Code__c= &quot;Inverters&quot;,Cost_Code__c= &quot;Other Materials&quot;,Cost_Code__c= &quot;Utility Costs-Material&quot;,Cost_Code__c= &quot;Carport Material&quot;,Cost_Code__c= &quot;DC Electrical- Material- Borrego&quot;,Cost_Code__c= &quot;AC Electrical- Material- Borrego&quot;,Cost_Code__c= &quot;Racking - Material&quot;,Cost_Code__c= &quot;Foundations - Material&quot;,Cost_Code__c= &quot;Steel Structures - Material&quot;,Cost_Code__c= &quot;Roofing/Waterproofing - Material&quot;,Cost_Code__c= &quot;Inverter&quot;,Cost_Code__c= &quot;Modules - Material&quot;,Cost_Code__c= &quot;DC Electrical - Material&quot;,Cost_Code__c= &quot;AC Electrical - Material&quot;,Cost_Code__c= &quot;Utility Costs - Material&quot;,Cost_Code__c= &quot;DAS - Material&quot;,Cost_Code__c= &quot;Electrical Other - Material&quot;), 
AcctSeedERP__Project__r.AcctSeed__Opportunity__r.Tax_Group__r.Tax_Group_Percent__c,0)</formula>
        <name>Set Tax Rate POL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sales_Tax_Rate_On_POLine</fullName>
        <field>Sales_Tax_Rate_Percent__c</field>
        <formula>Construction_Req__r.Sales_Tax_Rate_Percent__c</formula>
        <name>Update Sales Tax Rate On POLine</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Volume_Purchase_Roll_Up_field_Update</fullName>
        <field>Volume_Purchased_Roll_Up__c</field>
        <formula>Volume_Purchased__c</formula>
        <name>Volume Purchase Roll Up field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Volume_Purchase_Total_Field_Update</fullName>
        <field>Volume_Purchase_Total__c</field>
        <formula>IF(
AND( ISPICKVAL( Volume_PO_Line__c, &quot;Yes&quot;), AcctSeedERP__Product__r.RecordTypeId = &quot;01230000000944T&quot; ), AcctSeedERP__Quantity__c * AcctSeedERP__Product__r.Watts_STC__c /1000, 
IF(
AND( ISPICKVAL( Volume_PO_Line__c, &quot;Yes&quot;), AcctSeedERP__Product__r.RecordTypeId = &quot;01230000000944Y&quot;), 
AcctSeedERP__Quantity__c * AcctSeedERP__Product__r.Watts_Rated_Inverter__c /1000,
IF( 
AND( ISPICKVAL( Volume_PO_Line__c, &quot;Yes&quot;), AcctSeedERP__Product__r.RecordTypeId = &quot;01234000000BnFo&quot;), 
AcctSeedERP__Quantity__c * AcctSeedERP__Product__r.BOL_Energy_Capacity_Wh__c/1000, 
IF ( ISPICKVAL( Volume_PO_Line__c, &quot;No&quot;), 0,
NULL))))</formula>
        <name>Volume Purchase Total Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>POL Status Change</fullName>
        <actions>
            <name>POL_Status_Change_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto fills Status Change Date field whenever POL status field is changed</description>
        <formula>ISCHANGED(  PO_Line_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Tax Rate POLine</fullName>
        <actions>
            <name>Update_Sales_Tax_Rate_On_POLine</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populate Sales Tax Rate on the POLine</description>
        <formula>NOT(ISBLANK(Construction_Req__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Manager Email</fullName>
        <actions>
            <name>Project_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(CreatedDate))  || 
 ISCHANGED( Vendor_Confirmed_Ship_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Vendor Confirmed Ship Date Change</fullName>
        <actions>
            <name>Vendor_Confirmed_Ship_Date_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISPICKVAL(AcctSeedERP__Purchase_Order__r.AcctSeedERP__Type__c,&quot;Material&quot;), 
PO_Vendor__c &lt;&gt; &quot;Yingli Green Energy Americas, Inc.&quot;, 
NOT(ISBLANK(PRIORVALUE(Vendor_Confirmed_Ship_Date__c))), 
ISCHANGED(Vendor_Confirmed_Ship_Date__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Volume Purchase Roll Up field Update</fullName>
        <actions>
            <name>Volume_Purchase_Roll_Up_field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR (ISNEW(), ISCHANGED( Volume_Purchased__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Volume Purchase Total</fullName>
        <actions>
            <name>Volume_Purchase_Total_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Volume Purchase Total when the Quantity and/or Volume PO Line field is toggled</description>
        <formula>OR( ISCHANGED( AcctSeedERP__Quantity__c ), ISCHANGED(  Volume_PO_Line__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
