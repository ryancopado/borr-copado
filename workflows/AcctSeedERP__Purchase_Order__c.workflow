<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Aaron_Approved</fullName>
        <description>Aaron Approved</description>
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
        <template>Procurement/Aaron_Approved</template>
    </alerts>
    <alerts>
        <fullName>Alert_to_Service_Req_creator_that_Balance_on_PO_is_negative</fullName>
        <description>Alert to Service Req creator that Balance on PO is negative</description>
        <protected>false</protected>
        <recipients>
            <field>LH_Con_Req_Creator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Balance_Remaining_on_PO_is_negative</template>
    </alerts>
    <alerts>
        <fullName>Also_Energy_PO_Created</fullName>
        <ccEmails>accounting@alsoenergy.com</ccEmails>
        <description>Also Energy -  PO Created</description>
        <protected>false</protected>
        <senderAddress>hphillips@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Alerts/Vendor_PO_w_POL_Notification</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Expeditor_PM_Approved</fullName>
        <description>Email to Expeditor- PM Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PM_Approved_Mat_l_PO</template>
    </alerts>
    <alerts>
        <fullName>Notify_AP_Invoice_Recieved</fullName>
        <description>Notify AP - Invoice Recieved</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_AP_Invoice_Recieved</template>
    </alerts>
    <alerts>
        <fullName>O_M_Vendor_Notification_PO_has_been_created</fullName>
        <description>O&amp;M Vendor Notification PO has been created</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeedERP__Vendor_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>hphillips@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Alerts/Vendor_PO_w_POL_Notification</template>
    </alerts>
    <alerts>
        <fullName>O_M_service_req_PO_Has_Been_Created</fullName>
        <description>O&amp;M service req PO Has Been Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>LH_Con_Req_Creator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/O_M_Service_REQ_PO_has_been_created</template>
    </alerts>
    <alerts>
        <fullName>PM_Alert_PO_created</fullName>
        <description>PM Alert - PO created</description>
        <protected>false</protected>
        <recipients>
            <field>LH_Con_Req_Creator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PO_has_been_created</template>
    </alerts>
    <alerts>
        <fullName>PO_Rejected</fullName>
        <description>PO Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PM_Rejected_PO</template>
    </alerts>
    <alerts>
        <fullName>PO_Rejected_Notify_Procurement</fullName>
        <description>PO Rejected - Notify Procurement</description>
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
        <template>Alerts/PM_Rejected_PO</template>
    </alerts>
    <alerts>
        <fullName>Vendor_PO_Notification</fullName>
        <description>Vendor PO Notification</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeedERP__Vendor_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <recipient>elaramee@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>apdocs@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Alerts/Vendor_PO_Notification</template>
    </alerts>
    <alerts>
        <fullName>Vendor_PO_Notification_Log_Activity</fullName>
        <ccEmails>emailtosalesforce@8-2lvle30q9dms88x0qldayyc93lhbd8kem9ifa2aa8812isg7qt.3-1jdxeau.na29.le.salesforce.com</ccEmails>
        <description>Vendor PO Notification Log Activity</description>
        <protected>false</protected>
        <senderAddress>apdocs@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Vendor_PO_Notification_Log_Activity</template>
    </alerts>
    <alerts>
        <fullName>Vendor_PO_w_POL_Notification</fullName>
        <description>Vendor PO w/POL Notification</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeedERP__Vendor_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>apdocs@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Alerts/Vendor_PO_w_POL_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Aaron_Approved</fullName>
        <field>AcctSeedERP__Status__c</field>
        <literalValue>Aaron Approved</literalValue>
        <name>Aaron Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Email_Field_Update</fullName>
        <field>Serivce_Req_Creator_Email__c</field>
        <formula>LH_Con_Req_Creator__r.Email</formula>
        <name>Email Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Material_PO_Type</fullName>
        <field>AcctSeedERP__Type__c</field>
        <literalValue>Material</literalValue>
        <name>Material PO Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PM_Approved</fullName>
        <field>AcctSeedERP__Status__c</field>
        <literalValue>PM Approved</literalValue>
        <name>PM Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Closed_Date</fullName>
        <description>Rule fires whenever the Status field of a Purchase Order is set to &quot;Closed&quot;.</description>
        <field>PO_Closed_Date__c</field>
        <formula>TODAY()</formula>
        <name>PO Closed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Revision_Change</fullName>
        <field>Revision_Change_Date__c</field>
        <formula>TODAY()</formula>
        <name>PO Revision Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Status_Change_Date</fullName>
        <description>records the date the status changes</description>
        <field>PO_Status_Change_Date__c</field>
        <formula>TODAY()</formula>
        <name>PO Status Change Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Approval</fullName>
        <field>AcctSeedERP__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Procurement_Approved</fullName>
        <field>AcctSeedERP__Status__c</field>
        <literalValue>Procurement Approved</literalValue>
        <name>Procurement Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>AcctSeedERP__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Inco_Terms</fullName>
        <field>Inco_Terms__c</field>
        <formula>AcctSeedERP__Vendor__r.Inco_Terms__c</formula>
        <name>Set Inco Terms</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Vendor_City</fullName>
        <field>AcctSeedERP__Vendor_City__c</field>
        <formula>AcctSeedERP__Vendor__r.BillingCity</formula>
        <name>Set Vendor City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Vendor_Country</fullName>
        <field>AcctSeedERP__Vendor_Country__c</field>
        <formula>AcctSeedERP__Vendor__r.BillingCountry</formula>
        <name>Set Vendor Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Vendor_State</fullName>
        <field>AcctSeedERP__Vendor_State__c</field>
        <formula>AcctSeedERP__Vendor__r.BillingState</formula>
        <name>Set Vendor State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Vendor_Street</fullName>
        <field>AcctSeedERP__Vendor_Street__c</field>
        <formula>AcctSeedERP__Vendor__r.BillingStreet</formula>
        <name>Set Vendor Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Vendor_Zip</fullName>
        <field>AcctSeedERP__Vendor_Postal_Code__c</field>
        <formula>AcctSeedERP__Vendor__r.BillingPostalCode</formula>
        <name>Set Vendor Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>set_Payment_Terms</fullName>
        <field>Payment_Terms__c</field>
        <formula>TEXT(AcctSeedERP__Vendor__r.AcctSeed__Account_Payable_Terms__c)</formula>
        <name>set Payment Terms</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Also Energy PO Created</fullName>
        <active>false</active>
        <description>NO LONGER USED PER HANNAH P</description>
        <formula>AND( Con_Req_Group__r.RecordTypeId  = &quot;01234000000BnNq&quot;,  AcctSeedERP__Vendor__c = &quot;0018000000wJLuk&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Also_Energy_PO_Created</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Balance Remaining on PO is negative</fullName>
        <actions>
            <name>Alert_to_Service_Req_creator_that_Balance_on_PO_is_negative</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>alerts con req creator when balance on PO is negative</description>
        <formula>AND( LH_Con_Req_Creator__r.Department = &quot;O&amp;M&quot;,  Balance_Remaining_on_PO__c &lt; 0)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Material PO Update</fullName>
        <actions>
            <name>Material_PO_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>contains</operation>
            <value>Procurement</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>O%26M PO Created - Vendor Notification</fullName>
        <active>false</active>
        <description>emails externally - vendor contact upon creation of a PO from Service CRG</description>
        <formula>Con_Req_Group__r.RecordTypeId  = &quot;01234000000BnNq&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>O_M_Vendor_Notification_PO_has_been_created</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AcctSeedERP__Purchase_Order__c.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PM Alert -PO has been created</fullName>
        <active>true</active>
        <description>Sends an email to the PM once the PO has been created.</description>
        <formula>AND( CRG_Creator_Dept__c = &quot;Operations/Indirects&quot;, CreatedDate &gt; DATETIMEVALUE(TODAY())-1)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PM_Alert_PO_created</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AcctSeedERP__Purchase_Order__c.PO_Notification_Time_Trigger__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PM Approved</fullName>
        <actions>
            <name>Email_to_Expeditor_PM_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Checks to see if Case is populated to exclude O&amp;M Purchase Orders</description>
        <formula>AND( ISPICKVAL( AcctSeedERP__Status__c  , &quot;PM Approved&quot; ), ISBLANK( Case__c ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO Closed Date</fullName>
        <actions>
            <name>PO_Closed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Purchase_Order__c.AcctSeedERP__Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Rule fires whenever the Status field of a Purchase Order is set to &quot;Closed&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO Revision Date Change</fullName>
        <actions>
            <name>PO_Revision_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Revision_Number__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO Status Change Date</fullName>
        <actions>
            <name>PO_Status_Change_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>records the date the status changes</description>
        <formula>ISCHANGED(AcctSeedERP__Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO created - Notify Vendor</fullName>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Purchase_Order__c.Send_Email_Checkbox__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Vendor_PO_w_POL_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AcctSeedERP__Purchase_Order__c.PO_Notification_Time_Trigger__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PO created - Notify Vendor Log Activity</fullName>
        <actions>
            <name>Vendor_PO_Notification_Log_Activity</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Purchase_Order__c.Send_Email_Checkbox__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Service PO Created</fullName>
        <actions>
            <name>O_M_service_req_PO_Has_Been_Created</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeedERP__Purchase_Order__c.Division1__c</field>
            <operation>equals</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <description>triggers alert whenever O&amp;M Sevice REQ has been created to notify creator of CRG that its been approved and PO is available.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set PO Terms</fullName>
        <actions>
            <name>Set_Inco_Terms</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>set_Payment_Terms</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>populating the vendor information</fullName>
        <actions>
            <name>Set_Vendor_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Vendor_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Vendor_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Vendor_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Vendor_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
