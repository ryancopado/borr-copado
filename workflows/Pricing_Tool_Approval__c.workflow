<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ESD_Pricing_Request_Complete_Approved</fullName>
        <description>ESD Pricing Request Complete/Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>ebaratin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jdupont@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kcerniglia@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pricing_Tool_Approved_ESD</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Pricing_Request_Owner_that_Expected_Completion_Date_has_changed</fullName>
        <description>Email Alert to Pricing Request Owner that Expected Completion Date has changed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Prcing_Request_Exected_Completed_Date_Change</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted</fullName>
        <description>Email Alert to pre-con that a Pricing Request has been Submitted - EPC East Coast</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Product_Management</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted_Development</fullName>
        <description>Email Alert to pre-con that a Pricing Request has been Submitted - Development</description>
        <protected>false</protected>
        <recipients>
            <recipient>VP_of_Engineering_Dev</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted_EPC_Midwest</fullName>
        <description>Email Alert to pre-con that a Pricing Request has been Submitted - EPC Midwest</description>
        <protected>false</protected>
        <recipients>
            <recipient>Sr_Pre_Construction_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>cbrashers@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted_West_Coast</fullName>
        <description>Email Alert to pre-con that a Pricing Request has been Submitted - EPC West</description>
        <protected>false</protected>
        <recipients>
            <recipient>Applications_Engineering_Manager_West_Coast</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>rguild@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_notificaiton_to_the_request_of_Pricing_REquest_that_it_has_been_completed</fullName>
        <description>Email notificaiton to the request of Pricing REquest that it has been completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Completed</template>
    </alerts>
    <alerts>
        <fullName>New_Pricing_Request_Notification</fullName>
        <description>New Pricing Request Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Applications_Engineering</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_New</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Request_Email_Alert_when_Person_Responsible_field_is_changed_updated</fullName>
        <description>Pricing Request Email Alert when Person Responsible field is changed, updated</description>
        <protected>false</protected>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pricing_Request_Assigned</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Request_Person_Responsible_Assigned</fullName>
        <description>Pricing  Request- Person Responsible Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pricing_Request_Person_Responsible</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Tool_Approval_Finance_Request</fullName>
        <description>Pricing Tool Approval - Finance Request</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Project_Finance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Contract_Committee_Submittal/Pricing_Tool_Approval_Finance_Request</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Tool_Approval_PD</fullName>
        <description>Pricing Tool Approval - PD</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Contract_Committee_Submittal/Pricing_Tool_Approval_PD</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Tool_Approval_sold_with_a_SC_or_PG</fullName>
        <description>Pricing Tool Approval sold with a SC or PG</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorOperationsandMaintenance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Vice_President_O_M</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Contract_Committee_Submittal/Pricing_tool_Approved_with_SC_or_PG</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Tool_Approved</fullName>
        <description>Pricing Tool Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Contract_Committee_Submittal/Pricing_Tool_Approved</template>
    </alerts>
    <alerts>
        <fullName>Pricing_Tool_Rejected</fullName>
        <description>Pricing Tool Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>jaskins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Contract_Committee_Submittal/Pricing_Tool_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Utility_Scale_Pricing_Request_Submitted</fullName>
        <description>Utility Scale Pricing Request Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>cprice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Person_Responsible__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Utility_Scale_Pricing_Request_Submitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approximate_Install_Date</fullName>
        <description>from the Oppty</description>
        <field>Mobilization_Date__c</field>
        <formula>Opportunity__r.Approximate_Install_Date__c</formula>
        <name>Approximate Install Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_Apps_Engineer_Email_Update</fullName>
        <field>Assigned_Apps_Engineer_Email__c</field>
        <formula>Person_Responsible__r.Email</formula>
        <name>Assigned Apps Engineer Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ChangeFlagForApprovalProcess</fullName>
        <field>IsSubmittedForApproval__c</field>
        <literalValue>1</literalValue>
        <name>ChangeFlagForApprovalProcess</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Contract_Status</fullName>
        <description>Set Check Contract Status flag so that trigger PricingToolApproval will verify the Stage of the associated Opportunity to see if the approval for the Pricing Tool Approval record should be expired.</description>
        <field>Check_Contract_Signed__c</field>
        <literalValue>1</literalValue>
        <name>Check Contract Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Request_Entered</fullName>
        <field>Date_Request_Entered__c</field>
        <formula>Today ()</formula>
        <name>Date Request Entered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Submitted</fullName>
        <field>Date_Request_Submitted__c</field>
        <formula>Today()</formula>
        <name>Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Submitted_for_Approval</fullName>
        <field>Date_Pricing_Tool_Submitted_for_Approval__c</field>
        <formula>Today()</formula>
        <name>Date Submitted for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fields_Completed_Update</fullName>
        <field>Fields_Complete__c</field>
        <literalValue>1</literalValue>
        <name>Fields Completed Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Affiliate_Fee_from_PR</fullName>
        <description>Updates Affiliate Fee field on Opportunity with value from Pricing Request</description>
        <field>AffiliateFee__c</field>
        <formula>Affiliate_Fee__c</formula>
        <name>Opportunity Affiliate Fee from PR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Opportunity__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Utility_Upgrades_from_PR</fullName>
        <description>Updates Utility Upgrades field on Opportunity with value from Pricing Request</description>
        <field>Utility_Upgrades__c</field>
        <formula>Utility_Upgrades__c</formula>
        <name>Opportunity Utility Upgrades from PR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Opportunity__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pricing_Request_Completed_Date_Stamp</fullName>
        <field>Date_Request_Completed__c</field>
        <formula>Today ()</formula>
        <name>Pricing Request Completed Date Stamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pricing_Request_Status_Assigned</fullName>
        <field>Request_Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Pricing Request Status Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pricing_Request_Status_Update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Pricing Request Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pricing_Tool_Approval_Date</fullName>
        <field>Date_Pricing_Tool_Approved__c</field>
        <formula>Today()</formula>
        <name>Pricing Tool Approval Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalled</fullName>
        <field>Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Apps Engineer Email Address Change Update</fullName>
        <actions>
            <name>Assigned_Apps_Engineer_Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>pulls email address of apps engineer if person responsible is changed</description>
        <formula>ISCHANGED( Person_Responsible__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Email Address Update</fullName>
        <actions>
            <name>Assigned_Apps_Engineer_Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Assigned_Apps_Engineer_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>pulls email address of apps engineer listed on related opportunity</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>ESD Pricing Request Approved</fullName>
        <actions>
            <name>ESD_Pricing_Request_Complete_Approved</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Preliminary Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Final Approval</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Expected Completion Date Updated</fullName>
        <actions>
            <name>Email_Alert_to_Pricing_Request_Owner_that_Expected_Completion_Date_has_changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>emails requestor when expected completion date has been changed</description>
        <formula>ISCHANGED( Expected_Completion_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Mobilization Date</fullName>
        <actions>
            <name>Approximate_Install_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fills in the mobilization date with the approximate install date from the opportunity</description>
        <formula>NOT(ISBLANK(Opportunity__r.Approximate_Install_Date__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Alert</fullName>
        <actions>
            <name>Pricing_Request_Person_Responsible_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Person_Responsible__c</field>
            <operation>equals</operation>
            <value>John Innes,Nawaf Hassan,Shaun O&apos;Leary</value>
        </criteriaItems>
        <description>Bryan Morrison wants to be notified via email when his employees receive a new pricing tool or Pre-sales design request.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Approved</fullName>
        <actions>
            <name>Opportunity_Affiliate_Fee_from_PR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_Utility_Upgrades_from_PR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Update fields on Opportunity when Pricing Request is approved</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Assignment Alert</fullName>
        <actions>
            <name>Pricing_Request_Email_Alert_when_Person_Responsible_field_is_changed_updated</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Pricing_Request_Status_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED (Person_Responsible__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Completed</fullName>
        <actions>
            <name>Email_notificaiton_to_the_request_of_Pricing_REquest_that_it_has_been_completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Pricing_Request_Completed_Date_Stamp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Pricing_Request_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Pricing_Request_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Created</fullName>
        <actions>
            <name>New_Pricing_Request_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Requested Date</fullName>
        <actions>
            <name>Date_Request_Entered</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/8/2015</value>
        </criteriaItems>
        <description>auto-populates Date REquested with Created Date</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Submitted</fullName>
        <actions>
            <name>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(ISPICKVAL(Request_Status__c, &quot;Submitted&quot;),   Opportunity__r.Owner.Division=&quot;East&quot; || Opportunity__r.Owner.Division=&quot;New England&quot; || 
Opportunity__r.Owner.Division=&quot;Midwest&quot;   || 
Opportunity__r.Owner.Division=&quot;New York&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Submitted - West Coast</fullName>
        <actions>
            <name>Email_Alert_to_pre_con_that_a_Pricing_Request_has_been_Submitted_West_Coast</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(ISPICKVAL(Request_Status__c, &quot;Submitted&quot;), Opportunity__r.Owner.Division=&quot;West&quot; || Opportunity__r.Owner.Division=&quot;National&quot; || Opportunity__r.Owner.Division=&quot;WDG&quot; || Opportunity__r.Owner.Division=&quot;Southern CA&quot; || Opportunity__r.Owner.Division=&quot;Northern CA&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Request Submitted- ESD</fullName>
        <actions>
            <name>ESD_Pricing_Request_Complete_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(ISPICKVAL(Request_Status__c, &quot;Submitted&quot;),  Includes_Storage__c= TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Tool Approval - 30 Day Rule</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Status__c</field>
            <operation>equals</operation>
            <value>Final Approval</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Check_Contract_Status</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Pricing Tool Approval - Final Approval</fullName>
        <actions>
            <name>Pricing_Tool_Approval_Finance_Request</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Pricing_Tool_Approval_PD</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Status__c</field>
            <operation>equals</operation>
            <value>Final Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Pricing_Differences__c</field>
            <operation>greaterOrEqual</operation>
            <value>1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Pricing_Differences__c</field>
            <operation>lessOrEqual</operation>
            <value>-1</value>
        </criteriaItems>
        <description>Actions to take when a Pricing Tool Approval record is marked &quot;Final Approval&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Tool Approval - Preliminary Approval</fullName>
        <actions>
            <name>Pricing_Tool_Approval_Finance_Request</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Pricing_Tool_Approval_PD</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Status__c</field>
            <operation>equals</operation>
            <value>Preliminary Approval</value>
        </criteriaItems>
        <description>Actions to take when a Pricing Tool Approval record is marked &quot;Preliminary Approval&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pricing Tool Approval Fields Complete</fullName>
        <actions>
            <name>Fields_Completed_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7 AND 8 AND 9 AND 10</booleanFilter>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Link_to_Contracts__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Notes_RE_Contractual_Scope__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Notes__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Customer_requirements_beyond_code__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Are_there_union_labor_requirements__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Anyone_walked_the_site__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Any_sign_of_wetlands__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Permit_costs_validated_with_the_town__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Town_restrictions_or_mandates__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Scope_Changes__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>checks that all fields in the Pricing Tool Approval Section have been not left blank so its ready for submission</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Utility Scale Pricing Request Submitted</fullName>
        <actions>
            <name>Utility_Scale_Pricing_Request_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Utility_Scale__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Person_Responsible__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Pricing_Tool_Approval__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>Checks to see if the Pricing Request is marked as Utility Scale and sends an email if it is.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
