<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Billing_Approved</fullName>
        <description>Billing Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Approved</template>
    </alerts>
    <alerts>
        <fullName>Billing_Rejected</fullName>
        <description>Billing Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_due_date</fullName>
        <field>AcctSeed__Due_Date2__c</field>
        <formula>AcctSeed__Due_Date2__c  + Service_Contract__r.Billing_Days_Due__c</formula>
        <name>Auto due date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__Update_Billing_Latitude</fullName>
        <field>AvaAcctSeed__Bi_Billing_Address_Latitude__c</field>
        <formula>AcctSeed__Customer__r.AvaAcctSeed__Ac_Billing_Address_Latitude__c</formula>
        <name>Update Billing Latitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__Update_Billing_Longitude</fullName>
        <field>AvaAcctSeed__Bi_Billing_Address_Longitude__c</field>
        <formula>AcctSeed__Customer__r.AvaAcctSeed__Ac_Billing_Address_Longitude__c</formula>
        <name>Update Billing Longitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__Update_Shipping_Latitude</fullName>
        <field>AvaAcctSeed__Bi_Shipping_Address_Latitude__c</field>
        <formula>AcctSeed__Customer__r.AvaAcctSeed__Ac_Shipping_Address_Latitude__c</formula>
        <name>Update Shipping Latitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__Update_Shipping_Longitude</fullName>
        <field>AvaAcctSeed__Bi_Shipping_Address_Longitude__c</field>
        <formula>AcctSeed__Customer__r.AvaAcctSeed__Ac_Shipping_Address_Longitude__c</formula>
        <name>Update Shipping Longitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Recalled</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Billing Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>New_Due_Date</fullName>
        <description>When the Billing Date changes, the Due Date is advanced based on the (Payment due (days)&apos; on the Contract.</description>
        <field>AcctSeed__Due_Date2__c</field>
        <formula>AcctSeed__Date__c  +  Service_Contract__r.Payment_due_days__c</formula>
        <name>New Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Payment_Due</fullName>
        <description>Updates field with Billing Total if Billing Status = Approved, for O&amp;M Format types</description>
        <field>PAyment_Due__c</field>
        <formula>AcctSeed__Total__c</formula>
        <name>Payment Due</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Payment_Due_Total</fullName>
        <field>PAyment_Due__c</field>
        <formula>AcctSeed__Total__c</formula>
        <name>Payment Due= Total</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_for_Approval</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Waiting for Approval</literalValue>
        <name>Submitted for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_Application_number</fullName>
        <field>Application_Number__c</field>
        <formula>Name</formula>
        <name>Update Billing Application number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_City</fullName>
        <field>AcctSeed__Shipping_City__c</field>
        <formula>Service_Contract__r.ASProject__r.Site_City__c</formula>
        <name>Update Shipping City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_State</fullName>
        <field>AcctSeed__Shipping_State__c</field>
        <formula>Service_Contract__r.ASProject__r.Site_State__c</formula>
        <name>Update Shipping State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_Street</fullName>
        <field>AcctSeed__Shipping_Street__c</field>
        <formula>Service_Contract__r.ASProject__r.Site_Address__c</formula>
        <name>Update Shipping Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Shipping_Zip</fullName>
        <field>AcctSeed__Shipping_PostalCode__c</field>
        <formula>Service_Contract__r.ASProject__r.Site_Zip__c</formula>
        <name>Update Shipping Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>mass_submit_false</fullName>
        <field>Mass_Submit_for_Approval__c</field>
        <literalValue>0</literalValue>
        <name>mass submit false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Automated Due Date</fullName>
        <actions>
            <name>Auto_due_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the due date based on the payment terms of the service contract</description>
        <formula>OR( $User.Id = &apos;00534000007nMqv&apos;, Service_Contract__r.CreatedBy.Department = &apos;O&amp;M&apos; )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Payment Due</fullName>
        <actions>
            <name>Payment_Due</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Payment Due field with the Billing Total upon Approval for O&amp;M Format Types.</description>
        <formula>AND( CONTAINS( AcctSeed__Billing_Format__r.Name, &quot;O&amp;M&quot;) , ISCHANGED( AcctSeed__Total__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Payment Due%3D Total</fullName>
        <actions>
            <name>Payment_Due_Total</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>sets the payment due tto the total for O&amp;M billings</description>
        <formula>(AcctSeed__Billing_Format__r.Name= &quot;O&amp;M Service&quot; 
|| 
AcctSeed__Billing_Format__r.Name= &quot;O&amp;M&quot;) 
&amp;&amp; 
ISCHANGED(AcctSeed__Total__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Mass Submit</fullName>
        <actions>
            <name>mass_submit_false</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Billing__c.Mass_Submit_for_Approval__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Uncheck Mass Submit on new records</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Billing Address with Site Address for O%26M</fullName>
        <actions>
            <name>Update_Shipping_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Shipping_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(AcctSeed__Billing_Format__r.Name= &quot;O&amp;M&quot; 
|| 
AcctSeed__Billing_Format__r.Name= &quot;O&amp;M Service&quot;) 
&amp;&amp; 
Service_Contract__c &lt;&gt; &quot;&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Billing Application number</fullName>
        <actions>
            <name>Update_Billing_Application_number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Billing__c.AcctSeed__Accounting_Year__c</field>
            <operation>notEqual</operation>
            <value>1999</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Due Date</fullName>
        <actions>
            <name>New_Due_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>When the Billing Data is changed, the Due Date is advanced by the number of days in the Payment due (days) on the Service Contract</description>
        <formula>AND( ISCHANGED( AcctSeed__Date__c ), OR( AcctSeed__Billing_Format__r.Id = &quot;a1U34000003y3Ql&quot;, AcctSeed__Billing_Format__r.Id = &quot;a1U80000000AqAE&quot; ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
