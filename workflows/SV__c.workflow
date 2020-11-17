<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_SPG_when_PreOp_Op_SV_is_created</fullName>
        <description>Email Alert to SPG when PreOp/Op SV is created</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PreOp_Op_SV_created_alert_to_SPG</template>
    </alerts>
    <alerts>
        <fullName>National_Grid_SV_creation</fullName>
        <ccEmails>john.coles@nationalgrid.com, Carmine.Luongo@nationalgrid.com</ccEmails>
        <description>National Grid SV creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/National_Grid_SV_Creation</template>
    </alerts>
    <alerts>
        <fullName>New_Internal_PM_Service_Visit_Created</fullName>
        <description>New Internal PM Service Visit Created</description>
        <protected>false</protected>
        <recipients>
            <field>Technician__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SupportEmails/New_PM_Service_has_been_Created</template>
    </alerts>
    <alerts>
        <fullName>New_SErvice_Visit_has_been_assigned_email_notification</fullName>
        <description>New SErvice Visit has been assigned email notification</description>
        <protected>false</protected>
        <recipients>
            <field>Technician__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Service_Visit_has_been_Created</template>
    </alerts>
    <alerts>
        <fullName>Service_Visit_Email_Alert</fullName>
        <description>Service Visit Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Visit_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>Syncarpha_Email_Alert_PM_Scheduled</fullName>
        <ccEmails>operations@syncarpha.com</ccEmails>
        <description>Syncarpha Email Alert - PM Scheduled</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SupportEmails/Syncarpha_PM_SV_Creation</template>
    </alerts>
    <alerts>
        <fullName>Syncarpha_SV_completion</fullName>
        <ccEmails>operations@syncarpha.com</ccEmails>
        <description>Syncarpha SV completion</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Syncarpha_SV_Completion</template>
    </alerts>
    <alerts>
        <fullName>Syncarpha_SV_creation</fullName>
        <ccEmails>operations@syncarpha.com</ccEmails>
        <description>Syncarpha SV creation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Syncarpha_SV_Creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Admin_Time_Auto_Pop_if_New_and_Blank</fullName>
        <field>Administration_Time__c</field>
        <formula>0.50</formula>
        <name>Admin Time Auto Pop if New and Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billable_Field</fullName>
        <field>Billing_Field__c</field>
        <literalValue>Billable</literalValue>
        <name>Billable Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Field_Bill_EPC_Commission</fullName>
        <field>Billing_Field__c</field>
        <literalValue>Bill EPC Commissioning</literalValue>
        <name>Billing Field - Bill EPC Commission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Field_Billable</fullName>
        <field>Billing_Field__c</field>
        <literalValue>Billable</literalValue>
        <name>Billing Field - Billable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Field_Billable_Fixed_Price</fullName>
        <field>Billing_Field__c</field>
        <literalValue>Billable - Fixed Price</literalValue>
        <name>Billing Field -  Billable Fixed Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Field_Not_Billable</fullName>
        <field>Billing_Field__c</field>
        <literalValue>Not Billable</literalValue>
        <name>Billing Field - Not Billable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Description</fullName>
        <field>CaseDescription__c</field>
        <formula>Case__r.Description</formula>
        <name>Case Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_Service_Visit</fullName>
        <field>Completed__c</field>
        <literalValue>1</literalValue>
        <name>Completed Service Visit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EPC_Warranty</fullName>
        <field>Billing_Field__c</field>
        <literalValue>EPC Warranty</literalValue>
        <name>EPC Warranty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Historical_Field_update</fullName>
        <field>VisitCommentHistory__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot;
+ Latest_Visit_Comment__c+ BR() + 
BR() + PRIORVALUE(VisitCommentHistory__c )</formula>
        <name>Historical Field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Labor_Billing_EPC_Warranty</fullName>
        <field>Billing_Field__c</field>
        <literalValue>EPC Warranty</literalValue>
        <name>Labor Billing - EPC Warranty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Labor_Billing_O_M_Warranty</fullName>
        <field>Billing_Field__c</field>
        <literalValue>O&amp;M Warranty</literalValue>
        <name>Labor Billing - O&amp;M Warranty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SV_Current</fullName>
        <field>Current__c</field>
        <literalValue>1</literalValue>
        <name>SV Current</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Service_Visit_Auto_update_of_Billable</fullName>
        <description>auto updates billable on the SV if the SC is of package type = basic</description>
        <field>Billable__c</field>
        <literalValue>Yes</literalValue>
        <name>Service Visit Auto update of Billable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Service_Visit_update_Reactive_SC_billabl</fullName>
        <field>Billable__c</field>
        <literalValue>No</literalValue>
        <name>Service Visit update Reactive SC billabl</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spare_Parts_USed</fullName>
        <field>Spare_Parts_Used__c</field>
        <literalValue>1</literalValue>
        <name>Spare Parts USed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Visit_End_Date</fullName>
        <description>auto populates visit end date with visits tart date upon creation</description>
        <field>Visit_End_Date__c</field>
        <formula>Visit_Date__c</formula>
        <name>Visit End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Visit_Start_to_Equal_Work_Started</fullName>
        <field>Visit_Date__c</field>
        <formula>DATEVALUE(  SiteArrivalTime__c  )</formula>
        <name>Visit Start to Equal Work Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Work_Started_Update</fullName>
        <field>WorkStarted__c</field>
        <formula>SiteArrivalTime__c</formula>
        <name>Work Started Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Admin Time Auto Pop if New and Blank</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Administration_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Account__c</field>
            <operation>contains</operation>
        </criteriaItems>
        <description>auto populates a time of .5 hours upon creation if left blank</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Auto-pop Labor Billing for Admin Visit</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Admin Service Visit</value>
        </criteriaItems>
        <description>auto fills Labor Billing to Not Billable on all Admin Service Visits</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Autopop Start Time- Admin Visits</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Visit_Start_to_Equal_Work_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Work_Started_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Admin Service Visit</value>
        </criteriaItems>
        <description>auto fills work started, visit start and labor billing upon creation of a Admin Service Visit</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Billable Landscaping Exceeds Count</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Landscaping visit exceeds contract allotment</description>
        <formula>AND( Case_Record_Type__c = &quot;Landscaping&quot;,  ( Contract__r.CY_Completed_Landscaping_Visits__c    &gt;     Contract__r.Landscaping_Visits_Number__c   ),   NOT(ISBLANK( Work_Ended__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billable Primary PM Exceeds Count</fullName>
        <actions>
            <name>Billable_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Primary PM visit exceeds contract allotment
Contract__r.CY_Completed_Primary_PM_Visits__c  &gt;=</description>
        <formula>AND( Case_Record_Type__c = &quot;Primary PM&quot;,  (Contract__r.CY_Completed_Primary_PM_Visits__c  &gt;   Contract__r.Primary_PM_Visits_Number__c) ,   NOT(ISBLANK( Work_Ended__c))   )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billable Secondary PM Exceeds Count</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Secondary PM visit exceeds contract allotment</description>
        <formula>AND( Case_Record_Type__c = &quot;Secondary PM&quot;,  ( Contract__r.CY_Completed_Secondary_PM_Visits__c   &gt;    Contract__r.Secondary_PM_Visits_Number__c ) ,   NOT(ISBLANK( Work_Ended__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billable Washing Exceeds Count</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Washing visit exceeds contract allotment</description>
        <formula>AND( 
Case_Record_Type__c = &quot;Module Washing&quot;, 
(Contract__r.CY_Completed_Module_Wash_Visits__c &gt;       Contract__r.Module_Washings_Number__c ),  
NOT(ISBLANK( Work_Ended__c ))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Current Visit</fullName>
        <actions>
            <name>SV_Current</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Visit_Date__c</field>
            <operation>equals</operation>
            <value>THIS YEAR</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Internal notification of new PM SV</fullName>
        <actions>
            <name>New_Internal_PM_Service_Visit_Created</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>emails internal technician if new PM SV is assigned to them</description>
        <formula>AND(  RecordTypeId = &quot;01234000000BnNz&quot;,  NOT(ISBLANK(Visit_Date__c)), ISCHANGED( Technician__c ),  Completed__c = FALSE, Technician__r.AccountId = &quot;0013400001UfQpm&quot;,  Technician__r.Id &lt;&gt; &quot;0033400001vURk2&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Internal notification of new SV</fullName>
        <actions>
            <name>New_SErvice_Visit_has_been_assigned_email_notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>emails internal technician if new SV is assigned to them</description>
        <formula>AND( 
RecordTypeId = &quot;01234000000BnNs&quot;,
 NOT(ISBLANK(Visit_Date__c)),
Technician__r.AccountId = &quot;0013400001UfQpm&quot;,
 Technician__r.Id  &lt;&gt; &quot;0033400001vURk2&quot;
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billable%3A Landscaping Exceeds Count</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto updates Labor Billing to Billable whenever the CY Landscaping count on the contract exceeds the allotment for free landscaping</description>
        <formula>AND(  Case_Record_Type__c = &quot;Landscaping&quot;,  (  Contract__r.CY_Completed_Landscaping_Visits__c &gt; Contract__r.Landscaping_Visits_Number__c  ),  Completed__c = TRUE )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing -  Bill EPC COmmissioning</fullName>
        <actions>
            <name>Billing_Field_Bill_EPC_Commission</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>Borrego Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>contains</operation>
            <value>Closeout,Commissioning</value>
        </criteriaItems>
        <description>auto populates value in the Labor Billing Field upon completion of a Service Visit to the value of Bill EPC COmmissioning based on contract type, case type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing -  Billable</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4 AND 9) OR (1 AND 2 AND 3 AND 8 AND 9) OR (1 AND 2 AND 7 AND 8 AND 9) OR (1 AND 3 AND 5 AND 4 AND 9) OR (1 AND 3 AND 5 AND 8 AND 9) OR (1 AND 5 AND 7 AND 8 AND 9) OR (1 AND 6 AND 9)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package__c</field>
            <operation>equals</operation>
            <value>Basic</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Manufacturer Warranty,Reactive Service,Investigation - No Reactive Required</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M T&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>equals</operation>
            <value>Additional Services</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>notEqual</operation>
            <value>Landscaping,Module Washing</value>
        </criteriaItems>
        <description>auto populates value in the Labor Billing Field upon completion of a Service Visit to the value of Billable, based on contract type, case type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing -  Billable Fixed Price</fullName>
        <actions>
            <name>Billing_Field_Billable_Fixed_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>Project</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package__c</field>
            <operation>equals</operation>
            <value>Fixed Price</value>
        </criteriaItems>
        <description>auto populates value in the Labor Billing Field upon completion of a Service Visit to the value of Billable Fixed Price based on contract type, case type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing -  EPC Warranty</fullName>
        <actions>
            <name>EPC_Warranty</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>Borrego Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>equals</operation>
            <value>Reactive - Borrego Warranty</value>
        </criteriaItems>
        <description>auto populates value in the Labor Billing Field upon completion of a Service Visit to the value of Bill EPC COmmissioning based on contract type, case type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing - EPC Warranty</fullName>
        <actions>
            <name>Labor_Billing_EPC_Warranty</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4) OR (1 AND 5 AND 6 AND 7)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty,O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>Reactive,Basic</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Borrego EPC Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>T&amp;M and Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>T&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Borrego EPC Warranty</value>
        </criteriaItems>
        <description>auto fills Labor Billing field with EPC Warranty</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing - Not Billable -</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4 AND 10) OR (1 AND 2 AND 3 AND 5 AND 10) OR (1 AND 2 AND 6 AND 7 AND 10) OR (1 AND 2 AND 5 AND 6 AND 10) OR ( 1 AND 8 AND 3 AND 5 AND 10) OR (1 AND 8 AND 6 AND 5 AND 10 ) OR ( 1 AND 8 AND 6 AND 9 AND 10)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package__c</field>
            <operation>equals</operation>
            <value>Basic</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Borrego Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>equals</operation>
            <value>Primary PM,Secondary PM</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Manufacturer Warranty,Reactive Service,Investigation - No Reactive Required,Reactive Service - Borrego Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Manufacturer Warranty,Reactive Service,Investigation - No Reactive Required</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>notEqual</operation>
            <value>Landscaping,Module Washing</value>
        </criteriaItems>
        <description>auto populates value in the Labor Billing Field upon completion of a Service Visit to the value of Not Billable, based on contract type, case type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing - O%26M Warranty</fullName>
        <actions>
            <name>Labor_Billing_O_M_Warranty</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 AND 2 AND 3 AND 4) OR (1 AND 5 AND 6 AND 7)</booleanFilter>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty,O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>Reactive,Basic</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Borrego O&amp;M Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Service_Contract_Type__c</field>
            <operation>equals</operation>
            <value>T&amp;M and Warranty</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>equals</operation>
            <value>T&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Reactive_Service_Type__c</field>
            <operation>equals</operation>
            <value>Reactive Service - Borrego O&amp;M Warranty</value>
        </criteriaItems>
        <description>auto fills Labor Billing field with O&amp;M Warranty</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Not Billable Landscaping Is Below Count</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Landscaping visit count is below contract allotment for free or prepaid visits</description>
        <formula>AND(  Case_Record_Type__c = &quot;Landscaping&quot;,  NOT(ISPICKVAL( Contract__r.Landscaping_Visits_per_Year__c , &quot;OnCall Billable&quot;)),  (Contract__r.CY_Completed_Landscaping_Visits__c &lt;= Contract__r.Landscaping_Visits_Number__c ),   Completed__c = TRUE  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>National Grid SV Creation</fullName>
        <actions>
            <name>National_Grid_SV_creation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>email alert to National Grid contact that a reactive visit has been created</description>
        <formula>AND( 
RecordTypeId = &quot;01234000000BnNs&quot;, 
CONTAINS( Account__r.Name , &quot;National Grid&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Non Productive Service Visit</fullName>
        <actions>
            <name>Visit_Start_to_Equal_Work_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto pops Visit Start Date with date value from Work Started field for reporting/grouping purposes</description>
        <formula>AND(  RecordType.Id = &quot;0124C0000008cJq&quot;,  NOT(ISBLANK( WorkStarted__c ))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Landscaping As Needed</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Landscaping visits is &quot;as needed&quot; to not billable</description>
        <formula>AND( Case_Record_Type__c = &quot;Landscaping&quot;,  Contract__r.Landscaping_Visits_Number__c = 9999,   NOT(ISBLANK( Work_Ended__c))  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Landscaping Is Below Count</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Landscaping visit count is below contract allotment</description>
        <formula>AND( Case_Record_Type__c = &quot;Landscaping&quot;,  ( Contract__r.CY_Completed_Landscaping_Visits__c  &lt;=    Contract__r.Landscaping_Visits_Number__c ) ,   NOT(ISBLANK( Work_Ended__c))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Primary PM Is Below Count</fullName>
        <active>false</active>
        <description>updates billable field if Primary PM visit count is below contract allotment</description>
        <formula>AND( Case_Record_Type__c = &quot;Primary PM&quot;,  (Contract__r.CY_Completed_Primary_PM_Visits__c  &lt;=  Contract__r.Primary_PM_Visits_Number__c) ,   NOT(ISBLANK( Work_Ended__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Secondary Is Below Count</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Secondary PM visit count is below contract allotment</description>
        <formula>AND( Case_Record_Type__c = &quot;Secondary PM&quot;,  ( Contract__r.CY_Completed_Secondary_PM_Visits__c   &lt;=    Contract__r.Secondary_PM_Visits_Number__c ) ,   NOT(ISBLANK( Work_Ended__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Washing As Needed</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Wash Allotment is As Needed, to Not Billable</description>
        <formula>AND( Case_Record_Type__c = &quot;Module Washing&quot;,  Contract__r.Module_Washings_Number__c = 9999,   NOT(ISBLANK( Work_Ended__c )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Billable Washing Is Below Count</fullName>
        <actions>
            <name>Billing_Field_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates billable field if Washing visit count is below contract allotment</description>
        <formula>AND( 
Case_Record_Type__c = &quot;Module Washing&quot;, 
NOT(ISPICKVAL( Contract__r.Modules_Washings_per_Year__c, &quot;OnCall Billable&quot;)),
(Contract__r.CY_Completed_Module_Wash_Visits__c   
&lt;=Contract__r.Module_Washings_Number__c  ) , 
NOT(ISBLANK( Work_Ended__c)) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OnCall Billable Landscaping Visit</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>if allotment for visits is OnCall Billable - Labor Billing is always Billable</description>
        <formula>AND( 
Case_Record_Type__c = &quot;Landscaping&quot;,
NOT(ISBLANK( Work_Ended__c)),
ISPICKVAL( Contract__r.Landscaping_Visits_per_Year__c , &quot;OnCall Billable&quot;)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OnCall Billable Module Wash Visit</fullName>
        <actions>
            <name>Billing_Field_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>if allotment for visits is OnCall Billable - Labor Billing is always Billable</description>
        <formula>AND( 
Case_Record_Type__c = &quot;Module Washing&quot;,
NOT(ISBLANK( Work_Ended__c)),
ISPICKVAL(Contract__r.Modules_Washings_per_Year__c, &quot;OnCall Billable&quot;)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PreOp%2FOp SV created alert to SPG</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Visit_Reason__c</field>
            <operation>equals</operation>
            <value>Preoperational commissioning,Operational commissioning</value>
        </criteriaItems>
        <description>alert to go to Gary when a preop/operational commissioning service visit is created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Reactive Service Auto FilL Case Description</fullName>
        <actions>
            <name>Case_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Visit_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Case_Record_Type__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <description>auto populates Case Description field upon creation of a Reactive Service Visit, to bring details into SV for tech from email to case</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>SV for Reactive Service Contract</fullName>
        <actions>
            <name>Service_Visit_update_Reactive_SC_billabl</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>contains</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Visit_Reason__c</field>
            <operation>equals</operation>
            <value>Reactive Service</value>
        </criteriaItems>
        <description>auto populate some fields on Service Visit from Reactive Service Contract upon creation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SV from BasicHourly Service Contract</fullName>
        <actions>
            <name>Service_Visit_Auto_update_of_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.O_M_Package_Type__c</field>
            <operation>contains</operation>
            <value>Basic,Hourly</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Visit_Reason__c</field>
            <operation>equals</operation>
            <value>Reactive Service</value>
        </criteriaItems>
        <description>auto populate some fields on Service Visit from Basic and Hourly Service Contract upon creation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Scheduled Email Alert for Service Visit</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Visit_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Status__c</field>
            <operation>equals</operation>
            <value>Scheduled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Service_Visit_Email_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SV__c.Visit_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Service Visit Complete</fullName>
        <actions>
            <name>Completed_Service_Visit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Work_Ended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto checks off completed box when the Work Ended Time field is filled out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Spare Parts USed</fullName>
        <actions>
            <name>Spare_Parts_USed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>SV__c.Qty_Inventory_Used_1__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>SV__c.Qty_Inventory_Used_2__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>used to track whether visit resulted in use of Spare Parts Inventory</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Syncarpha PM SV Creation</fullName>
        <actions>
            <name>Syncarpha_Email_Alert_PM_Scheduled</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>email alert to Syncarpha contact that a PM visit has been scheduled</description>
        <formula>AND( RecordTypeId = &quot;01234000000BnNz&quot;, CONTAINS( Account__r.Name , &quot;Syncarpha&quot;) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Syncarpha SV Completion</fullName>
        <actions>
            <name>Syncarpha_SV_completion</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>email alert to Syncarpha contact that a visit has been completed</description>
        <formula>AND( RecordTypeId = &quot;01234000000BnNs&quot;,  Completed__c = TRUE, CONTAINS( Account__r.Name , &quot;Syncarpha&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Syncarpha SV Creation</fullName>
        <actions>
            <name>Syncarpha_SV_creation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>email alert to Syncarpha contact that a reactive visit has been created.</description>
        <formula>AND( RecordTypeId = &quot;01234000000BnNs&quot;, CONTAINS( Account__r.Name , &quot;Syncarpha&quot;) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Visit Comment History</fullName>
        <actions>
            <name>Historical_Field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(Latest_Visit_Comment__c)
&amp;&amp;
(CommentsLastCreated__c=CountofComments__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Visit End Date</fullName>
        <actions>
            <name>Visit_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SV__c.Visit_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto populates Visit End Date upon creation of a Visit to match the Visit Start Date</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
