<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_to_Accounting_New_Contract_set_up</fullName>
        <description>Alert to Accounting- New Contract set up</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Set_up</template>
    </alerts>
    <alerts>
        <fullName>Contract</fullName>
        <description>O&amp;M Contract will expire in 10 Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>djohnston@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/O_M_Contract_will_expire_in_10_Days</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_service_contract_type_field_is_changed</fullName>
        <description>Email alert when service contract type field is changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtea@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Type_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Guarantee_Term_Ending</fullName>
        <description>Guarantee Term Ending</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>O_M_Administrator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>DirectorofTechnology</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>Sales_Associate_O_M</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Guarantee_Term_Ending</template>
    </alerts>
    <alerts>
        <fullName>New_Contract_Created_East</fullName>
        <ccEmails>OpsCenter@borregosolar.com</ccEmails>
        <description>New Contract Created - East</description>
        <protected>false</protected>
        <recipients>
            <recipient>O_M_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gshambo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jdestefano@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfendrock@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Set_up</template>
    </alerts>
    <alerts>
        <fullName>New_Contract_Created_Southeast</fullName>
        <ccEmails>OpsCenter@borregosolar.com</ccEmails>
        <description>New Contract Created - Southeast</description>
        <protected>false</protected>
        <recipients>
            <recipient>O_M_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gshambo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfendrock@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Set_up</template>
    </alerts>
    <alerts>
        <fullName>New_Contract_Created_West</fullName>
        <ccEmails>OpsCenter@borregosolar.com</ccEmails>
        <description>New Contract Created - West</description>
        <protected>false</protected>
        <recipients>
            <recipient>O_M_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gshambo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfendrock@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Set_up</template>
    </alerts>
    <alerts>
        <fullName>O_M_Contract_Expired_or_Completed</fullName>
        <ccEmails>spg@borregosolar.com</ccEmails>
        <description>O&amp;M Contract Expired or Completed</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jharden@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/O_M_Contract_has_Expired_or_Completed</template>
    </alerts>
    <alerts>
        <fullName>O_M_Contract_will_expire_in_30_Days</fullName>
        <description>O&amp;M Contract will expire in 30 Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>djohnston@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsnow@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/O_M_Conract_will_expire_in_30_Days</template>
    </alerts>
    <alerts>
        <fullName>O_M_Contract_will_expire_in_90_Days</fullName>
        <description>O&amp;M Contract will expire in 90 Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>djohnston@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pking@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/O_M_Conract_will_expire_in_90_Days</template>
    </alerts>
    <alerts>
        <fullName>Service_Contract_Start_Date_Approaching_EAST</fullName>
        <description>Service Contract Start Date Approaching EAST</description>
        <protected>false</protected>
        <recipients>
            <recipient>kcrowley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Start_Date_Approaching</template>
    </alerts>
    <alerts>
        <fullName>Service_Contract_Start_Date_Approaching_NOR_CAL</fullName>
        <description>Service Contract Start Date Approaching NOR CAL</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Start_Date_Approaching</template>
    </alerts>
    <alerts>
        <fullName>Service_Contract_Start_Date_Approaching_SO_CAL</fullName>
        <description>Service Contract Start Date Approaching SO CAL</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Start_Date_Approaching</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Status_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approval Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_Pending_Approval</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Approval Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_Recalled</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Approval Status Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approval Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Liability</fullName>
        <field>Auto_Liablity__c</field>
        <formula>1000000</formula>
        <name>Auto Liability</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_Terms_Name</fullName>
        <field>Billing_Terms_Name__c</field>
        <formula>Account.AcctSeed__Billing_Terms_Name__c</formula>
        <name>Billing Terms Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contract_Name</fullName>
        <description>autopops the field Name on Service contract via a WF</description>
        <field>Name</field>
        <formula>ASProject__r.Name</formula>
        <name>Contract Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contract_Term_months_Calculate</fullName>
        <description>Calculates the difference in months between Service Contract Start Date and Contract End Date</description>
        <field>ContractTerm</field>
        <formula>((YEAR( EndDate ) - YEAR( Service_Contract_Start_Date__c ) - 1) *12) + (12 - MONTH( Service_Contract_Start_Date__c )) + MONTH( EndDate )</formula>
        <name>Contract Term (months) Calculate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deductible</fullName>
        <field>Deductible_bodily_injury_property_damag__c</field>
        <formula>250</formula>
        <name>Deductible</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fire_Damage</fullName>
        <field>Fire_Damage__c</field>
        <formula>250000</formula>
        <name>Fire Damage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>General_Liability_aggregate</fullName>
        <field>General_Liability_aggregate__c</field>
        <formula>2000000</formula>
        <name>General Liability (aggregate)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>General_Liability_per_occurrence</fullName>
        <field>General_Liability_per_occurrence__c</field>
        <formula>1000000</formula>
        <name>General Liability (per occurrence)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Medical_Expense</fullName>
        <field>Medical_Expense_each_claim__c</field>
        <formula>10000</formula>
        <name>Medical Expense</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Personal_Advertising_Injury_aggregate</fullName>
        <field>Personal_Advertising_Injury_aggregate__c</field>
        <formula>1000000</formula>
        <name>Personal/Advertising Injury (aggregate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prevailing_Wage_Included</fullName>
        <field>Prevailing_Wage_Included__c</field>
        <formula>TEXT(ASProject__r.AcctSeed__Opportunity__r.Prevailing_Wage__c)</formula>
        <name>Prevailing Wage Included</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Umbrella_Liability</fullName>
        <field>Umbrella_Liability_aggregate__c</field>
        <formula>2000000</formula>
        <name>Umbrella Liability</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Umbrella_Liability_per_Occurence</fullName>
        <field>Umbrella_Liability_per_occurrence__c</field>
        <formula>1000000</formula>
        <name>Umbrella Liability per Occurence</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Workers_Comp</fullName>
        <field>Worker_s_Compensation_Each_Accident_Dis__c</field>
        <formula>1000000</formula>
        <name>Workers Comp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>contract_complete</fullName>
        <field>Contract_Status__c</field>
        <literalValue>Paid Contract Complete</literalValue>
        <name>contract complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_nullvoid</fullName>
        <field>Status</field>
        <literalValue>NullVoid</literalValue>
        <name>status nullvoid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Billing Terms AUto Update from Account</fullName>
        <actions>
            <name>Billing_Terms_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Billing_Terms_Name__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Billing Terms Name will auto update value that is on related account if the field on Service Contract is blank.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Contract Complete</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Contract_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.EndDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Does_Contract_Auto_Renew__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>auto updates Contract Status upon reaching Contract End date - if not auto renew contract</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>contract_complete</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.EndDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Contract Insurance Updates</fullName>
        <actions>
            <name>Auto_Liability</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Deductible</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Fire_Damage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>General_Liability_aggregate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>General_Liability_per_occurrence</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Medical_Expense</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Personal_Advertising_Injury_aggregate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Umbrella_Liability</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Umbrella_Liability_per_Occurence</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Workers_Comp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Standard_Insurance_Terms__c</field>
            <operation>equals</operation>
            <value>Yes,No</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contract Name</fullName>
        <actions>
            <name>Contract_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>used to autopopulate the field NAME on the service contract object, will match project name.</description>
        <formula>OR(
ISNEW(),
ISCHANGED( ASProject__c )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Contract Created</fullName>
        <actions>
            <name>Alert_to_Accounting_New_Contract_set_up</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>Warranty and Paid</value>
        </criteriaItems>
        <description>Email alert to Accounting when a Service Contract has been set up</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Contract Created -East</fullName>
        <actions>
            <name>New_Contract_Created_East</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty,O&amp;M,O&amp;M T&amp;M,Project</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Branch__c</field>
            <operation>equals</operation>
            <value>Mid Atlantic,New England</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Contract_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Email alert to Accounting and O&amp;M Manager when a Service Contract has been set up in New England or Mid Atlantic branch.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Contract Created -Southeast</fullName>
        <actions>
            <name>New_Contract_Created_Southeast</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty,O&amp;M,O&amp;M T&amp;M,Project</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Branch__c</field>
            <operation>equals</operation>
            <value>Southeast</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Contract_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Email alert to Accounting and O&amp;M Manager when a Service Contract has been set up in Southeast branch.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Contract Created -West</fullName>
        <actions>
            <name>New_Contract_Created_West</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M and Warranty,O&amp;M,O&amp;M T&amp;M,Project</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Branch__c</field>
            <operation>equals</operation>
            <value>Nor Cal,So Cal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Contract_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Email alert to Accounting and O&amp;M Manager when a Service Contract has been set up in NorCal or SoCal branch.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>O%26M Contract Exp Alert</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>Borrego Warranty,O&amp;M and Warranty,O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Does_Contract_Auto_Renew__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Account__c</field>
            <operation>notEqual</operation>
            <value>NRG</value>
        </criteriaItems>
        <description>alerts sales team 90 days prior to expiration date of contacts that do not auto-renew</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>O_M_Contract_will_expire_in_90_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.EndDate</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>O%26M Contract Exp Alert - NRG</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>Borrego Warranty,O&amp;M and Warranty,O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Does_Contract_Auto_Renew__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Account__c</field>
            <operation>equals</operation>
            <value>NRG</value>
        </criteriaItems>
        <description>alerts sales team 30 days prior to expiration date for all NRG Contracts</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>O_M_Contract_will_expire_in_30_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.EndDate</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>O%26M Contract Exp Alert 10-Day</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>Warranty/Construction,O&amp;M,O&amp;M T&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Does_Contract_Auto_Renew__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Account__c</field>
            <operation>equals</operation>
            <value>NRG</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Contract</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.EndDate</offsetFromField>
            <timeLength>-10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>O%26M Contract has Expired or Completed</fullName>
        <actions>
            <name>O_M_Contract_Expired_or_Completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Contract_Status__c</field>
            <operation>equals</operation>
            <value>Expired,Paid Contract Complete,Customer Terminated,Borrego Terminated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <description>alerts O&amp;M ops and accounting that a contract status has been changed to Contract Complete or Expired</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Performance Guarantee Ending</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Term_Years__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.GuaranteeStartDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email alert to go out when the Performance Guarantee related to the Service Contract reaches the end of its term.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Guarantee_Term_Ending</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Guarantee_End_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Prevailing Wage Included</fullName>
        <actions>
            <name>Prevailing_Wage_Included</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Account__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto pops the value from prevailing wage from opportunity upon creation but can also be changed if needed.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Service Contract Edited</fullName>
        <actions>
            <name>Contract_Term_months_Calculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Runs when start or end date on a Paid service contract are updated</description>
        <formula>AND(  NOT( ISBLANK( EndDate )),  NOT( ISBLANK( Service_Contract_Start_Date__c )),  RecordTypeId = &quot;012340000007kck&quot;,  OR(   ISCHANGED( EndDate ),    ISCHANGED( Service_Contract_Start_Date__c )   )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Service Contract Start Date EAST</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>Boston,Mid Atlantic</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Service_Contract_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>notification that Service Contract Start date is approaching - 10 days out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Service_Contract_Start_Date_Approaching_EAST</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Service_Contract_Start_Date__c</offsetFromField>
            <timeLength>-10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Service Contract Start Date NOR CAL</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>Berkeley,Oakland</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Service_Contract_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>notification that Service Contract Start date is approaching - 10 days out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Service_Contract_Start_Date_Approaching_NOR_CAL</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Service_Contract_Start_Date__c</offsetFromField>
            <timeLength>-10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Service Contract Start Date SO CAL</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>San Diego</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Service_Contract_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>notification that Service Contract Start date is approaching - 10 days out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Service_Contract_Start_Date_Approaching_SO_CAL</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Service_Contract_Start_Date__c</offsetFromField>
            <timeLength>-10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
