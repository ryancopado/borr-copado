<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Con_Req_Group_Civil_ConReq_and_Check_Automation</fullName>
        <description>Con Req Group: Civil ConReq and Check Automation</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>saslam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Construction_Requisition/Con_Req_Group_Civil_ConReq_and_Check_Automation</template>
    </alerts>
    <alerts>
        <fullName>Contact_10_days_until_deadline_date</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Contact - 10 days until deadline date</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X10_Days_to_Deadline_Date</template>
    </alerts>
    <alerts>
        <fullName>Contact_20_days_until_deadline_date</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Contact - 20 days until deadline date</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X20_Days_to_Deadline_Date</template>
    </alerts>
    <alerts>
        <fullName>Contact_5_days_until_deadline_date</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Contact - 5 days until deadline date</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X5_Days_to_Deadline_Date</template>
    </alerts>
    <alerts>
        <fullName>Material_CRG_Approved</fullName>
        <description>Material CRG Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Material_Purchase_Approved_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Material_Purchase_Approved</fullName>
        <description>Material Purchase Approved</description>
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
        <template>unfiled$public/Purchase_Approved_Major_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Other_Sub_CRG_Approved</fullName>
        <description>Other/Sub CRG Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Other_Sub_Purchase_Approved_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_ConReqGrp</fullName>
        <description>Purchase Approved- ConReqGrp</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Purchase_Approved_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_ConReqGrpAP</fullName>
        <description>Purchase Approved- ConReqGrp APAdmin</description>
        <protected>false</protected>
        <recipients>
            <recipient>bgayton@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hphillips@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Purchase_Approved_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_Sub_ConReq_Group</fullName>
        <description>Purchase Approved- Sub ConReq Group</description>
        <protected>false</protected>
        <recipients>
            <recipient>Expeditor</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Purchase_Approved_Sub_OtherConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Approved_for_Racking_Vendor</fullName>
        <description>Purchase Approved for Racking Vendor</description>
        <protected>false</protected>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Purchase_Approved_for_Racking_Vendor</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Rejected_Con_Req_Group</fullName>
        <description>Purchase Rejected- Con Req Group</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PurchaseRejectedCRGroup</template>
    </alerts>
    <alerts>
        <fullName>ROD_Email</fullName>
        <description>ROD Email</description>
        <protected>false</protected>
        <recipients>
            <field>ROD__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Purchase_Approved_ConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Sub_Purchase_Approved</fullName>
        <description>Sub Purchase Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Purchase_Approved_Sub_OtherConReqGrp</template>
    </alerts>
    <alerts>
        <fullName>Subcontract_Engineering_Approved</fullName>
        <description>Subcontract-Engineering Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Subcontractor_Eng_CR_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>CRG_Approved_Checkbox</fullName>
        <field>CRG_Approved__c</field>
        <literalValue>1</literalValue>
        <name>CRG Approved - Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Con_Req_Group_Approval_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Con Req Group Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Con_Req_Group_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Con Req Group Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Con_Req_Group_Recalled</fullName>
        <field>Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Con Req Group Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Con_Req_Group_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Con Req Group Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_of_Final_Approval</fullName>
        <description>Fills in the date of final approval to be used in a formula</description>
        <field>Date_of_Final_Approval__c</field>
        <formula>TEXT(NOW())</formula>
        <name>Date of Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Internal_Signatories</fullName>
        <field>Internal_Signatories_and_order__c</field>
        <formula>IF(
AND(
Requisition_Total_Roll_Up__c &lt;= 20000, 
NOT(CONTAINS( Cost_Code_Number__c ,&quot;02-1540&quot;)), 
NOT(CONTAINS( Cost_Code_Number__c,&quot;02-1535&quot;)), NOT(CONTAINS(Cost_Code_Number__c,&quot;02-1410&quot;))),
  Project_PM__r.FirstName&amp;&quot; &quot;&amp;Project_PM__r.LastName  ,

IF(
AND(
Requisition_Total_Roll_Up__c &gt; 20000, 
Requisition_Total_Roll_Up__c &lt; 100000,

CONTAINS( Project__r.Ops_Division__r.Name , &quot;EPC - West&quot; ),
NOT(CONTAINS( Cost_Code_Number__c ,&quot;02-1540&quot;)), 
NOT(CONTAINS( Cost_Code_Number__c,&quot;02-1535&quot;)), 
NOT(CONTAINS(Cost_Code_Number__c,&quot;02-1410&quot;))
),Project_PM__r.Manager_Name__c ,


IF(
AND(
CONTAINS( Project__r.Ops_Division__r.Name , &quot;EPC - West&quot; ),
Requisition_Total_Roll_Up__c &lt; 500000,
Requisition_Total_Roll_Up__c &gt; 100000, 
NOT(CONTAINS( Cost_Code_Number__c ,&quot;02-1540&quot;)), 
NOT(CONTAINS( Cost_Code_Number__c,&quot;02-1535&quot;)), NOT(CONTAINS(Cost_Code_Number__c,&quot;02-1410&quot;)),
OR(
CONTAINS(Category__c, &quot;F&quot;),CONTAINS(Category__c, &quot;O&quot;), CONTAINS(Category__c, &quot;S&quot;),CONTAINS(Category__c, &quot;M&quot;), CONTAINS(Category__c, &quot;L&quot;),CONTAINS(Category__c, &quot;E&quot;))),
  ROD__r.FirstName&amp;&quot; &quot;&amp;ROD__r.LastName  ,



IF(
AND(
CONTAINS( Project__r.Ops_Division__r.Name , &quot;EPC - West&quot; ),
Requisition_Total_Roll_Up__c &lt; 1000000,
Requisition_Total_Roll_Up__c &gt; 500000, NOT(CONTAINS( Cost_Code_Number__c ,&quot;02-1540&quot;)), NOT(CONTAINS( Cost_Code_Number__c,&quot;02-1535&quot;)), NOT(CONTAINS(Cost_Code_Number__c,&quot;02-1410&quot;)),OR(CONTAINS(Category__c, &quot;F&quot;),CONTAINS(Category__c, &quot;O&quot;), CONTAINS(Category__c, &quot;S&quot;),CONTAINS(Category__c, &quot;L&quot;),CONTAINS(Category__c, &quot;M&quot;), CONTAINS(Category__c, &quot;E&quot;))),
&quot;Brian Barker&quot;,

IF(
AND(
Requisition_Total_Roll_Up__c &gt; 1000000, 
NOT(CONTAINS( Cost_Code_Number__c ,&quot;02-1540&quot;)), 
NOT(CONTAINS( Cost_Code_Number__c,&quot;02-1535&quot;)), 
NOT(CONTAINS(Cost_Code_Number__c,&quot;02-1410&quot;)),
OR(
CONTAINS(Category__c, &quot;F&quot;),CONTAINS(Category__c, &quot;O&quot;), CONTAINS(Category__c, &quot;S&quot;),CONTAINS(Category__c, &quot;L&quot;),CONTAINS(Category__c, &quot;M&quot;), CONTAINS(Category__c, &quot;E&quot;))),
&quot;Mark Swanson&quot;,


NULL
)))))</formula>
        <name>Internal Signatories</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_Con_Req_Group</fullName>
        <field>IsLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Con Req Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_Con_Req_Group1</fullName>
        <field>IsLocked__c</field>
        <literalValue>1</literalValue>
        <name>Lock Con Req Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Ship_to_Address_Field</fullName>
        <field>Ship_To_Street__c</field>
        <formula>Project__r.Site_Address__c</formula>
        <name>Project Ship to Address Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Ship_to_City_Field</fullName>
        <field>Ship_To_City__c</field>
        <formula>Project__r.Site_City__c</formula>
        <name>Project Ship to City Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Ship_to_State_Field</fullName>
        <field>Ship_To_State__c</field>
        <formula>Project__r.Site_State__c</formula>
        <name>Project Ship to State Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Ship_to_Zip_Field</fullName>
        <field>Ship_To_Zip__c</field>
        <formula>Project__r.Site_Zip__c</formula>
        <name>Project Ship to Zip Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Field_Update1</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unlock_Con_Req_Group</fullName>
        <field>IsLocked__c</field>
        <literalValue>0</literalValue>
        <name>Unlock Con Req Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Con Req Group Email alert</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req_Group__c.Date_of_Final_Approval__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Con_Req_Group__c.Contact__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Con_Req_Group__c.Business_Days_Allowed__c</field>
            <operation>greaterOrEqual</operation>
            <value>4</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Contact_20_days_until_deadline_date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Con_Req_Group__c.Deadline_Date__c</offsetFromField>
            <timeLength>-20</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Contact_5_days_until_deadline_date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Con_Req_Group__c.Deadline_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Contact_10_days_until_deadline_date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Con_Req_Group__c.Deadline_Date__c</offsetFromField>
            <timeLength>-10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Material ConReq Approved</fullName>
        <actions>
            <name>Material_Purchase_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notice to Procurement, material req approved
Excludes O&amp;M</description>
        <formula>AND(  ISPICKVAL( Status__c, &quot;Approved&quot; ),  Material_CRG__c &gt; 0 ,  RecordTypeId &lt;&gt; &quot;01234000000BnNq&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Material ConReq Approved - Creator</fullName>
        <actions>
            <name>Material_CRG_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req_Group__c.CRG_Approved__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Con_Req_Group__c.Material_CRG__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Emails record creator that Procurement has been notified to create a PO</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Other%2FSub ConReq Approved - Creator</fullName>
        <actions>
            <name>Other_Sub_CRG_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Con_Req_Group__c.CRG_Approved__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Con_Req_Group__c.Material_CRG__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>Emails record creator that Accounting has been notified to create a PO</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Racking Vendor Approved</fullName>
        <actions>
            <name>Purchase_Approved_for_Racking_Vendor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notice to accounting, Racking Vendor approved CRG, excludes O&amp;M Service Visit record type</description>
        <formula>AND( ISPICKVAL(Vendor__r.Type , &quot;Racking&quot;), ISPICKVAL(Status__c , &quot;Approved&quot;), RecordTypeId &lt;&gt; &quot;01234000000BnNq&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sub%2FOther ConReq Approved</fullName>
        <actions>
            <name>Purchase_Approved_Sub_ConReq_Group</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notice to accounting, sub req approved
Excludes O&amp;M</description>
        <formula>AND(  OR(   CONTAINS( Category__c  , &quot;S&quot; ),   BEGINS( Cost_Code_Number__c , &quot;03&quot; )   ),  ISPICKVAL( Status__c , &quot;Approved&quot; ),  RecordTypeId &lt;&gt; &quot;01234000000BnNq&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Field</fullName>
        <active>true</active>
        <formula>AND( RecordType.Name = &quot;Service Visit&quot;,  NOT(ISBLANK(Quote__c ))  )</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Status_Field_Update1</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Con_Req_Group__c.Trigger_Time_03__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Use Project Address as Ship to</fullName>
        <actions>
            <name>Project_Ship_to_Address_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Ship_to_City_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Ship_to_State_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Ship_to_Zip_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Con_Req_Group__c.Use_Project_Ship_To__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>auto fills ship to address fields on the Service Con Req if this box is checked off with same address as related project</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
