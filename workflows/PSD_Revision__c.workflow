<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_to_PSD_Apps_Engineer</fullName>
        <description>Alert to PSD Apps Engineer</description>
        <protected>false</protected>
        <recipients>
            <field>Applications_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Canning_PSD_Revision_Draft_Layout</fullName>
        <description>Canning - PSD Revision Draft Layout</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>pcanning@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Draft_Layout</template>
    </alerts>
    <alerts>
        <fullName>Canning_PSD_Revision_On_Hold</fullName>
        <description>Canning - PSD Revision On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>pcanning@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Delgado_PSD_Revision_Draft_Layout</fullName>
        <description>Delgado - PSD Revision Draft Layout</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tdelgado@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Draft_Layout</template>
    </alerts>
    <alerts>
        <fullName>Delgado_PSD_Revision_In_Design</fullName>
        <description>Delgado - PSD Revision In Design</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tdelgado@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>Delgado_PSD_Revision_On_Hold</fullName>
        <description>Delgado - PSD Revision On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tdelgado@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Foss_MIchaels_Revision_In_Design</fullName>
        <description>Foss-Michaels - PSD Revision In Design</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bfoss-michaelis@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>Foss_Michaels_PSD_Revision_Draft_Layout</fullName>
        <description>Foss Michaels- PSD Revision Draft Layout</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bfoss-michaelis@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Draft_Layout</template>
    </alerts>
    <alerts>
        <fullName>Foss_Michaels_PSD_Revision_On_Hold</fullName>
        <description>Foss Michaels- PSD Revision On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bfoss-michaelis@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>PSD_Rev_Resubmit_additional_requirements</fullName>
        <description>PSD Rev - Resubmit additional requirements</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Rev_Revision_Status_Change_Not_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>PSD_Rev_Resubmit_with_clarifications</fullName>
        <ccEmails>ljt@borregosolar.com</ccEmails>
        <description>PSD Rev - Resubmit with clarifications</description>
        <protected>false</protected>
        <recipients>
            <recipient>dxiao@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jzhang@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Rev_Resubmit_with_clarifications</template>
    </alerts>
    <alerts>
        <fullName>PSD_Rev_Revision_Status_Change</fullName>
        <description>PSD Rev - Revision Status Change</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Rev_Revision_Status_Change_Not_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>PSD_Revision_Designer_Assigned</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>PSD Revision - Designer Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PSD_Revision_Designer</template>
    </alerts>
    <alerts>
        <fullName>PSD_Revision_Not_Top_Priority</fullName>
        <description>PSD Revision Not Top Priority</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_In_Design</template>
    </alerts>
    <alerts>
        <fullName>PSD_Revision_Submitted</fullName>
        <ccEmails>ljt@borregosolar.com</ccEmails>
        <description>PSD Revision Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>dxiao@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jzhang@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Pat_PSD_Revision_In_Design</fullName>
        <description>Pat - PSD Revision In Design</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>pcanning@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>Tarn_PSD_Revision_In_Design</fullName>
        <description>Tarn - PSD Revision In Design</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>Yates_PSD_Revision_Draft_Layout</fullName>
        <description>Yates - PSD Revision Draft Layout</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Draft_Layout</template>
    </alerts>
    <alerts>
        <fullName>Yates_PSD_Revision_On_Hold</fullName>
        <description>Yates - PSD Revision On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Zha_PSD_Revision_Draft_Layout</fullName>
        <description>Zha- PSD Revision Draft Layout</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jzha@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Draft_Layout</template>
    </alerts>
    <alerts>
        <fullName>Zha_PSD_Revision_In_Design</fullName>
        <description>Zha - PSD Revision In Design</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jzha@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_Top_Priority</template>
    </alerts>
    <alerts>
        <fullName>Zha_PSD_Revision_On_Hold</fullName>
        <description>Zha - PSD Revision On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jzha@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PSD_Revision_On_Hold</template>
    </alerts>
    <fieldUpdates>
        <fullName>Capture_Working_Design_Date</fullName>
        <description>Date Stamps the date the status was changed to working design</description>
        <field>Working_Design_Date__c</field>
        <formula>TODAY()</formula>
        <name>Capture Working Design Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PSD_Revisions_Count</fullName>
        <field>Revision_Number__c</field>
        <formula>Pre_Sales_Design__r.Number_of_Revision__c + 1</formula>
        <name>PSD Revisions Count</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revision_Status_Change</fullName>
        <field>Revision_Status_Change__c</field>
        <formula>TODAY()</formula>
        <name>Revision Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_Date_Capture</fullName>
        <description>Captures the date the status changes to Submitted</description>
        <field>Submitted_Date__c</field>
        <formula>today()</formula>
        <name>Submitted Date Capture</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Canning - PSD Revision Draft Layout</fullName>
        <actions>
            <name>Canning_PSD_Revision_Draft_Layout</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Patrick Canning</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Canning - PSD Revision On Hold Not Top Priority</fullName>
        <actions>
            <name>Canning_PSD_Revision_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Patrick Canning</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Canning - PSD Revision Top Priority</fullName>
        <actions>
            <name>Pat_PSD_Revision_In_Design</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Patrick Canning</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Delgado - PSD Revision Draft Layout</fullName>
        <actions>
            <name>Delgado_PSD_Revision_Draft_Layout</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ted Delgado</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Delgado - PSD Revision On Hold Not Top Priority</fullName>
        <actions>
            <name>Delgado_PSD_Revision_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ted Delgado</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Delgado - PSD Revision Top Priorty</fullName>
        <actions>
            <name>Delgado_PSD_Revision_In_Design</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ted Delgado</value>
        </criteriaItems>
        <description>if status is In Design or draft layout and Top priority and apps engineer is TEd Delgado</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Foss Michaels - PSD Revision On Hold Not Top Priority</fullName>
        <actions>
            <name>Foss_Michaels_PSD_Revision_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ben Foss-Michaelis</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Foss-MIchaels - PSD Revision Top Priority</fullName>
        <actions>
            <name>Foss_MIchaels_Revision_In_Design</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ben Foss-Michaelis</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Foss-Michaels - PSD Revision Draft Layout</fullName>
        <actions>
            <name>Foss_Michaels_PSD_Revision_Draft_Layout</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Ben Foss-Michaelis</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Jalalpour - PSD Revision Draft Layout</fullName>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Bob Jalalpour</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Jalalpour - PSD Revision On Hold Not Top Priority</fullName>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Bob Jalalpour</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Jalalpour - PSD Revision Top Priority</fullName>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Bob Jalalpour</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PSD Count Revisions</fullName>
        <actions>
            <name>PSD_Revisions_Count</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update revision number: unique number sequencing for PSD Revision</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>PSD Rev - Resubmit additional requirments</fullName>
        <actions>
            <name>PSD_Rev_Resubmit_additional_requirements</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Resubmitted with Additional Requirements</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PSD Rev - Revision Status Change Not Top Priority</fullName>
        <actions>
            <name>PSD_Rev_Revision_Status_Change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Sold,Working Design</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PSD Revision Assignment Alert</fullName>
        <actions>
            <name>PSD_Revision_Designer_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Applications_Engineer__c</field>
            <operation>equals</operation>
            <value>Ben Foss-Michaelis,John Innes,Jun Zha</value>
        </criteriaItems>
        <description>Bryan Morrison wants to be notified via email when Ben FM, John Innes or Jun Zha receive a new pricing tool or Pre-sales design request.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PSD Revision In Design Not Top Priority</fullName>
        <actions>
            <name>PSD_Revision_Not_Top_Priority</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top,Low,Normal,High</value>
        </criteriaItems>
        <description>alert to oppty owner and record creator only if status is In Design but not a top priority</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Revision Status Change</fullName>
        <actions>
            <name>Revision_Status_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Revision_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Submitted Date</fullName>
        <actions>
            <name>Alert_to_PSD_Apps_Engineer</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Submitted_Date_Capture</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>Includes email alert to PSD Engineer</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Working Design Date</fullName>
        <actions>
            <name>Capture_Working_Design_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Working Design,Draft Layout</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Yates - PSD Revision Draft Layout</fullName>
        <actions>
            <name>Yates_PSD_Revision_Draft_Layout</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Tarn Yates</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Yates - PSD Revision On Hold Not Top Priority</fullName>
        <actions>
            <name>Yates_PSD_Revision_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Tarn Yates</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Yates - PSD Revision Top Priority</fullName>
        <actions>
            <name>Tarn_PSD_Revision_In_Design</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Tarn Yates</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Zha - PSD Revision Draft Layout</fullName>
        <actions>
            <name>Zha_PSD_Revision_Draft_Layout</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Jun Zha</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Zha - PSD Revision On Hold Not Top Priority</fullName>
        <actions>
            <name>Zha_PSD_Revision_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>June Zha</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Zha - PSD Revision Top Priority</fullName>
        <actions>
            <name>Zha_PSD_Revision_In_Design</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD_Revision__c.Revision_Status__c</field>
            <operation>equals</operation>
            <value>In Design,Draft Layout</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD_Revision__c.Priority__c</field>
            <operation>equals</operation>
            <value>Top</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>June Zha</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
