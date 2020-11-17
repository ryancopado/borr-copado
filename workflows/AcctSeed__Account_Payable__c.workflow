<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AP_Invoice_Paid_Affiliate_and_Referral_Fees</fullName>
        <description>AP Invoice Paid - Affiliate and Referral Fees</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Affiliate_and_Referral_Fees_AP_Line_Paid</template>
    </alerts>
    <alerts>
        <fullName>AP_Invoice_Paid_Utility_Upgrades</fullName>
        <description>AP Invoice Paid - Utility Upgrades</description>
        <protected>false</protected>
        <recipients>
            <recipient>eshambeau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Utility_Upgrades_AP_Line_Paid</template>
    </alerts>
    <alerts>
        <fullName>AP_Invoice_notify_Accounting_Analyst</fullName>
        <description>AP Invoice notify Accounting- Analyst</description>
        <protected>false</protected>
        <recipients>
            <recipient>lforrester@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/AP_Invoice_Notify_Accounting_Analyst</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Intx_Team_that_Utility_invoice_has_been_paid</fullName>
        <description>Email Alert to Intx Team that Utility invoice has been paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>eshambeau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/AP_Invoice_Has_been_Paid</template>
    </alerts>
    <alerts>
        <fullName>Insurance_Expired_for_VEndor</fullName>
        <description>Insurance Expired for VEndor</description>
        <protected>false</protected>
        <recipients>
            <recipient>sysuser@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Vendor_Insurance_Expired</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Paid_Email_Notification</fullName>
        <description>Invoice Paid Email Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Invoice_Paid_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>Invoice_has_been_approved</fullName>
        <description>Invoice has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Invoice_Approved_PO</template>
    </alerts>
    <alerts>
        <fullName>PO_Invoice_has_been_Rejected</fullName>
        <description>PO Invoice has been Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lforrester@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/POInvoice_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Vendor_without_insurance</fullName>
        <description>Vendor without insurance</description>
        <protected>false</protected>
        <recipients>
            <recipient>asandonato@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marlise@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Vendor_without_insurance</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved_BY_Paula</fullName>
        <field>Approved_By_Paula__c</field>
        <literalValue>1</literalValue>
        <name>Approved BY Paula</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Tyep_Dev_Eng</fullName>
        <description>Sets Invoice Type to Development &amp; Engineering</description>
        <field>Invoice_Type__c</field>
        <literalValue>Development &amp; Engineering</literalValue>
        <name>Invoice  Type - Dev &amp; Eng</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_G_A</fullName>
        <description>Sets Invoice Type to G&amp;A</description>
        <field>Invoice_Type__c</field>
        <literalValue>G&amp;A</literalValue>
        <name>Invoice Type - G&amp;A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Internal_Reclass</fullName>
        <description>Sets Invoice Type to Internal Reclass</description>
        <field>Invoice_Type__c</field>
        <literalValue>Internal Reclass</literalValue>
        <name>Invoice Type - Internal Reclass</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Materials</fullName>
        <description>Sets Invoice Type to Materials (material only)</description>
        <field>Invoice_Type__c</field>
        <literalValue>Material (material only)</literalValue>
        <name>Invoice Type - Materials</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Misc</fullName>
        <description>Sets Invoice Type to Misc. Job Costs</description>
        <field>Invoice_Type__c</field>
        <literalValue>Misc. Job Costs</literalValue>
        <name>Invoice Type - Misc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_O_M</fullName>
        <description>Sets Invoice Type to O&amp;M</description>
        <field>Invoice_Type__c</field>
        <literalValue>O&amp;M</literalValue>
        <name>Invoice Type - O&amp;M</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Other</fullName>
        <description>Sets Invoice Type to Other</description>
        <field>Invoice_Type__c</field>
        <literalValue>Other</literalValue>
        <name>Invoice Type - Other</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Solar_Modules</fullName>
        <description>Sets to Invoice Type to Solar Modules</description>
        <field>Invoice_Type__c</field>
        <literalValue>Solar Modules</literalValue>
        <name>Invoice Type - Solar Modules</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Type_Subcontractor</fullName>
        <description>Sets Invoice Type to Subcontractor</description>
        <field>Invoice_Type__c</field>
        <literalValue>Subcontractor</literalValue>
        <name>Invoice Type - Subcontractor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_AP_Invoice</fullName>
        <field>Legal__c</field>
        <literalValue>1</literalValue>
        <name>Legal AP Invoice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>New_Remit_to_Address</fullName>
        <field>Remit_to_Address__c</field>
        <formula>IF( 
ISBLANK( Remit_to__c ),NULL,
IF(
ISBLANK( Remit_to__r.Suite_Unit__c ), 
Remit_to__r.Street_Address__c &amp; BR() &amp; 
Remit_to__r.City__c + &quot;, &quot; + 
Remit_to__r.State__c &amp; BR() + &quot; &quot; + Remit_to__r.Zip_Code__c, 
Remit_to__r.Street_Address__c &amp; BR() &amp; 
Remit_to__r.Suite_Unit__c &amp; BR() &amp; 
Remit_to__r.City__c + &quot;, &quot; + 
Remit_to__r.State__c &amp; BR() + &quot; &quot; + Remit_to__r.Zip_Code__c ))</formula>
        <name>New Remit to Address</name>
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
        <fullName>Set_Status_To_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Set Status To Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Recalled</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Set Status to Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Set Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_status_update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Submitted status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_In_Process</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>In Process</literalValue>
        <name>Update Status- In Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>submitted</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AP Invoice - Paid Utility Upgrades</fullName>
        <actions>
            <name>AP_Invoice_Paid_Utility_Upgrades</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>email alert for when any AP Invoice has a Payable Line item of &quot;utility upgrades&quot; is marked as paid.</description>
        <formula>AND(   ISPICKVAL( AcctSeed__Payment_Status__c, &quot;PAID&quot;),    Count_Utility_Upgrade_Lines__c &gt; 0)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AP Invoice Alert  when Paid</fullName>
        <actions>
            <name>Email_Alert_to_Intx_Team_that_Utility_invoice_has_been_paid</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>invoice alert to Rob when con req he submits is paid</description>
        <formula>AND( Purchase_Order__r.Con_Req_Creator_ID__c = &quot;005340000097YwY&quot;, ISPICKVAL( AcctSeed__Payment_Status__c,&quot;Paid&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AP Invoice Alert  when Paid - Dave Moyer</fullName>
        <active>false</active>
        <description>invoice alert to Dave when con req he submits is paid</description>
        <formula>AND( Purchase_Order__r.Con_Req_Creator_ID__c = &quot;00534000009rSPV&quot;, ISPICKVAL( AcctSeed__Payment_Status__c,&quot;Paid&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AP Invoice Check Vendor Insurance</fullName>
        <actions>
            <name>Vendor_without_insurance</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(ISNULL(AcctSeed__Vendor__c )), ISPICKVAL(AcctSeed__Vendor__r.GL_Insurance_Required__c,&apos;Yes&apos;), ISBLANK(AcctSeed__Vendor__r.GL_Effective_Date__c),
AcctSeed__Vendor__r.RecordType.Id = &quot;012800000007h2p&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AP Invoice Notify Accounting- Analyst</fullName>
        <actions>
            <name>AP_Invoice_notify_Accounting_Analyst</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>OR(  AcctSeed__Vendor__r.Name = &quot;Bentek Solar&quot;, AcctSeed__Vendor__r.Name = &quot;Walsin Lihwa Holdings Limited&quot;, AcctSeed__Vendor__r.Name = &quot;Graybar&quot;, AcctSeed__Vendor__r.Name = &quot;SMA America, LLC&quot;, AcctSeed__Vendor__r.Name = &quot;LG Electronics USA, Inc.&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Affiliate and Referral Fees</fullName>
        <actions>
            <name>AP_Invoice_Paid_Affiliate_and_Referral_Fees</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( ISCHANGED( AcctSeed__Payment_Status__c ),  ISPICKVAL( AcctSeed__Payment_Status__c , &apos;Paid&apos;),  (Has_an_Affiliate_and_Referral_Fees_line__c = TRUE) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>In Process Expense Reports</fullName>
        <actions>
            <name>Update_Status_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Account_Payable__c.AcctSeed__Payee_Reference__c</field>
            <operation>contains</operation>
            <value>Expenses</value>
        </criteriaItems>
        <description>Sets status to &quot;In Process&quot; if AP Invoice is created from an Expense Report</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Dev %26 Eng</fullName>
        <actions>
            <name>Invoice_Tyep_Dev_Eng</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice Type to Development &amp; Engineering   based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Development &amp; Engineering&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - G%26A</fullName>
        <actions>
            <name>Invoice_Type_G_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice type to G&amp;A based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;G&amp;A&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Internal Reclass</fullName>
        <actions>
            <name>Invoice_Type_Internal_Reclass</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice type to Internal Reclass based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Internal Reclass&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Material</fullName>
        <actions>
            <name>Invoice_Type_Materials</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice Type to Material (material only)  based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Material (material only)&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Misc</fullName>
        <actions>
            <name>Invoice_Type_Misc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice Type to Misc. Job Costs based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Misc. Job Costs&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - O%26M</fullName>
        <actions>
            <name>Invoice_Type_O_M</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice type to O&amp;M based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;O&amp;M&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Other</fullName>
        <actions>
            <name>Invoice_Type_Other</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice type to Other based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Other&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Solar Modules</fullName>
        <actions>
            <name>Invoice_Type_Solar_Modules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice Type to Solar Modules based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Solar Modules&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Type - Subcontractor</fullName>
        <actions>
            <name>Invoice_Type_Subcontractor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sets the Invoice type to Subcontractor based on Vendor Default Invoice Type</description>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Default_Invoice_Type__c, &quot;Subcontractor&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Legal AP Invoice</fullName>
        <actions>
            <name>Legal_AP_Invoice</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL( AcctSeed__Vendor__r.Type, &quot;Legal&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Remit to%3A Changed</fullName>
        <actions>
            <name>New_Remit_to_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Remit_to__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
