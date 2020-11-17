<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Corrections_Needed</fullName>
        <description>Corrections Needed</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Corrections_Needed</template>
    </alerts>
    <alerts>
        <fullName>Corrections_Needed_SoCal</fullName>
        <description>Corrections Needed- SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Corrections_Needed</template>
    </alerts>
    <alerts>
        <fullName>Design_Approved</fullName>
        <description>Design Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Approved_Pending_Investigation</template>
    </alerts>
    <alerts>
        <fullName>Design_Approved_for_sale</fullName>
        <description>Design Approved for Sale</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Completed</template>
    </alerts>
    <alerts>
        <fullName>Design_Completed</fullName>
        <description>Design Completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Draft_Layout_Complete</template>
    </alerts>
    <alerts>
        <fullName>Design_On_Hold</fullName>
        <description>Design On Hold</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Hold</template>
    </alerts>
    <alerts>
        <fullName>Design_Past_Due</fullName>
        <description>Design Past Due</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Past_Due</template>
    </alerts>
    <alerts>
        <fullName>Design_Submitted</fullName>
        <description>Design Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Mid_Atlantic_Design_Complete</fullName>
        <description>Mid Atlantic Design Complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_IT_and_Infrastructure</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Completed</template>
    </alerts>
    <alerts>
        <fullName>PSD_Assigned_Apps_Alert</fullName>
        <description>PSD Assigned Apps Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Application_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pre_Sales_Design_Assigned_Apps</template>
    </alerts>
    <alerts>
        <fullName>Pre_Sales_Design_Submitted_New_England</fullName>
        <description>Pre-Sales Design Submitted New England</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Pre_Sales_Design_Submitted_SoCal</fullName>
        <description>Pre-Sales Design Submitted SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>tyates@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Submitted</template>
    </alerts>
    <rules>
        <fullName>Apps Engineer Review PSD- San Diego</fullName>
        <actions>
            <name>Design_Completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Kevin Roll</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <description>Apps Engineer to review Pre-Sales Design when complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Review PSD-Berk</fullName>
        <actions>
            <name>Design_Completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Tarn Yates</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft Layout</value>
        </criteriaItems>
        <description>Apps Engineer to review Pre-Sales Design when complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Design Approved Pending Investigation</fullName>
        <actions>
            <name>Design_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved Pending Investigation</value>
        </criteriaItems>
        <description>email notification to PD&apos;s that Design is approved pending investigation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Design Approved for Sale</fullName>
        <actions>
            <name>Design_Approved_for_sale</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Design Approved for Sale</value>
        </criteriaItems>
        <description>Email to requester when Design is approved for Sale</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Design On Hold- PD alert</fullName>
        <actions>
            <name>Design_On_Hold</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>email to PD</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Design Submitted or Hold- Kevin</fullName>
        <actions>
            <name>Pre_Sales_Design_Submitted_SoCal</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Kevin Roll</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>Design is submitted or on hold- email alert to Kevin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Design Submitted or Hold-Tarn</fullName>
        <actions>
            <name>Design_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Application_Engineer__c</field>
            <operation>equals</operation>
            <value>Tarn Yates</value>
        </criteriaItems>
        <criteriaItems>
            <field>PSD__c.Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>Design Submitted or On Hold- email Tarn</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PSD Assigned Apps Engineer Alert</fullName>
        <actions>
            <name>PSD_Assigned_Apps_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alert to user on Assigned Apps Engineer lookup field</description>
        <formula>ISCHANGED( Application_Engineer__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Review_Pre_Sales_Design</fullName>
        <assignedTo>etam@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Pre-Sales Design</subject>
    </tasks>
    <tasks>
        <fullName>Review_Pre_Sales_DesignMidAtlantic</fullName>
        <assignedTo>etam@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Pre-Sales Design</subject>
    </tasks>
    <tasks>
        <fullName>Review_Pre_Sales_DesignTarn</fullName>
        <assignedTo>tyates@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Pre-Sales Design</subject>
    </tasks>
</Workflow>
