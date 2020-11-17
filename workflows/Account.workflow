<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_Approved</fullName>
        <description>Account Approved</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <recipient>Treasury_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Account_Approved</template>
    </alerts>
    <alerts>
        <fullName>Account_Rejected</fullName>
        <description>Account Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Account_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Account_Submitted_for_Approval</fullName>
        <description>Account Submitted for Approval</description>
        <protected>false</protected>
        <recipients>
            <field>Submitter_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Account_Approval_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Auto_Insurance_Expiration_Bos_MidAtl</fullName>
        <description>Auto Insurance Expiration Bos/MidAtl</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Auto_Insurance_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Auto_Insurance_Expiration_NorCal</fullName>
        <description>Auto Insurance Expiration NorCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>cleatham@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Auto_Insurance_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Auto_Insurance_Expiration_SoCal</fullName>
        <description>Auto Insurance Expiration SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Auto_Insurance_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Bid_Eligibility_Expiration_Warning</fullName>
        <description>Bid Eligibility Expiration Warning</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Bid_Eligibility_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Email_Procurement</fullName>
        <description>Email Procurement</description>
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
        <template>Alerts/New_SubVendor_account_created</template>
    </alerts>
    <alerts>
        <fullName>GL_Insurance_Expiration</fullName>
        <description>GL Insurance Expiration BOS/MidAtl</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/GL_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>GL_Insurance_Expiration_NorCal</fullName>
        <description>GL Insurance Expiration NorCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>cleatham@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/GL_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>GL_Insurance_Expiration_So_Cal</fullName>
        <description>GL Insurance Expiration So Cal</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/GL_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>New_Vendor_account_created</fullName>
        <description>New Vendor account created</description>
        <protected>false</protected>
        <recipients>
            <recipient>aorozco@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Business_Vendor_account_created</template>
    </alerts>
    <alerts>
        <fullName>PLI_Cert_Expiration</fullName>
        <description>PLI Cert Expiration</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PLI_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>PLI_Cert_Expiration_BOS_MIDATL</fullName>
        <description>PLI Cert Expiration BOS/MIDATL</description>
        <protected>false</protected>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PLI_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>PLI_Cert_Expiration_So_Cal</fullName>
        <description>PLI Cert Expiration So Cal</description>
        <protected>false</protected>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PLI_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>PLI_expiration_60_days</fullName>
        <description>PLI expiration 60 days</description>
        <protected>false</protected>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PLI_Cert_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Sub_Approved</fullName>
        <description>Sub Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Sub_Account_Approved</template>
    </alerts>
    <alerts>
        <fullName>Umbrella_Coverage_Expiration_Bos_MidAtl</fullName>
        <description>Umbrella Coverage Expiration Bos/MidAtl</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Umbrella_Coverage_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Umbrella_Coverage_Expiration_NorCal</fullName>
        <description>Umbrella Coverage Expiration NorCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>cleatham@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Umbrella_Coverage_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Umbrella_Coverage_Expiration_SoCal</fullName>
        <description>Umbrella Coverage Expiration SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Umbrella_Coverage_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Workers_Comp_Expiration_Bos_MidAtl</fullName>
        <description>Workers Comp Expiration Bos/MidAtl</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Workers_Comp_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Workers_Comp_Expiration_NorCal</fullName>
        <description>Workers Comp Expiration NorCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>cleatham@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Workers_Comp_Expiration</template>
    </alerts>
    <alerts>
        <fullName>Workers_Comp_Expiration_SoCal</fullName>
        <description>Workers Comp Expiration SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Workers_Comp_Expiration</template>
    </alerts>
    <fieldUpdates>
        <fullName>Account_Type_Blank</fullName>
        <field>AcctSeed__Accounting_Type__c</field>
        <name>Account Type Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Accounting_Active</fullName>
        <field>AcctSeed__Accounting_Active__c</field>
        <literalValue>1</literalValue>
        <name>Accounting Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Accounting_Type_Customer</fullName>
        <field>AcctSeed__Accounting_Type__c</field>
        <literalValue>Customer</literalValue>
        <name>Accounting Type- Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Accounting_Type_Vendor</fullName>
        <field>AcctSeed__Accounting_Type__c</field>
        <literalValue>Vendor</literalValue>
        <name>Accounting Type - Vendor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Active_Checkbox_Update</fullName>
        <field>AcctSeed__Accounting_Active__c</field>
        <literalValue>1</literalValue>
        <name>Active Checkbox Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Convert_Account_Type</fullName>
        <field>AcctSeed__Accounting_Active__c</field>
        <literalValue>0</literalValue>
        <name>Convert Account Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Account_Owner_Changed_Update</fullName>
        <field>Date_of_Account_Ownership_Change__c</field>
        <formula>TODAY()</formula>
        <name>Date Account Owner Changed Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NewEnglandBoston</fullName>
        <field>Branch__c</field>
        <literalValue>Boston</literalValue>
        <name>New England =&gt; Boston</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_Active</fullName>
        <description>Unchecks the &quot;active&quot; checkbox</description>
        <field>AcctSeed__Accounting_Active__c</field>
        <literalValue>0</literalValue>
        <name>Not Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SanJoseSiliconValley</fullName>
        <field>Branch__c</field>
        <literalValue>Silicon Valley</literalValue>
        <name>San Jose =&gt; Silicon Valley</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Short_Description</fullName>
        <field>Short_Description__c</field>
        <formula>LEFT( Description , 40 )</formula>
        <name>Short Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitter_Email</fullName>
        <field>Submitter_Email__c</field>
        <formula>Current_user_email__c</formula>
        <name>Submitter Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateShipping</fullName>
        <description>Copies billing adress to shipping</description>
        <field>ShippingStreet</field>
        <formula>BillingStreet</formula>
        <name>Update Shipping</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Number</fullName>
        <field>AccountNumber</field>
        <formula>LEFT(Name, 4) &amp; &quot;-&quot; &amp; TEXT(TODAY())</formula>
        <name>Update Account Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>shippingcity</fullName>
        <field>ShippingCity</field>
        <formula>BillingCity</formula>
        <name>shipping city</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>shippingstate</fullName>
        <field>ShippingState</field>
        <formula>BillingState</formula>
        <name>shipping state</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>shippingzip</fullName>
        <field>ShippingPostalCode</field>
        <formula>BillingPostalCode</formula>
        <name>shipping zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Account Number Update</fullName>
        <actions>
            <name>Update_Account_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer,Municipality,Private,Vendor- Material,Vendor- Corporate,Vendor- Subcontractor/Non-Material</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.AccountNumber</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Account Owner Change Date Stampe</fullName>
        <actions>
            <name>Date_Account_Owner_Changed_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>date stamps date account owner was changed</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Accounting Active for Customers</fullName>
        <actions>
            <name>Accounting_Type_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Active_Checkbox_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer</value>
        </criteriaItems>
        <description>Marks all Customer Accounts as Active to be used in Accounting Seed</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Bid Eligibility Expiration</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Bid_Eligibility_Expiration_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Emails Sales Ops 60 days prior to Bid Eligibility Expiration</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Bid_Eligibility_Expiration_Warning</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Bid_Eligibility_Expiration_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Convert Account Type</fullName>
        <actions>
            <name>Account_Type_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will fire when a user converts a record from customer to any type of vendor account. It will uncheck the accounting active checkbox</description>
        <formula>AND(ISCHANGED( RecordTypeId ), PRIORVALUE(RecordTypeId)=&quot;012300000000Yip&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PLI Cert Expiration</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.PLI_Cert_Required__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PLI_Cert_Expiration_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.AcctSeed__Accounting_Active__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Emails Engineering Coordinator 30 days prior to PLI Insurance Expiration</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PLI_Cert_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.PLI_Cert_Expiration_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Short Description</fullName>
        <actions>
            <name>Short_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( ISCHANGED( Description ), (ISNEW() ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>z%2E Blank Shipping Address</fullName>
        <actions>
            <name>UpdateShipping</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>shippingcity</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>shippingstate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>shippingzip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.ShippingStreet</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Customer</value>
        </criteriaItems>
        <description>Copies over billing address as shipping address when shipping address is blank</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
