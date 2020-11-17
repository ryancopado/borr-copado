<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_CReation_Request_Endsight</fullName>
        <ccEmails>support@syndeotech.com</ccEmails>
        <description>Account CReation Request- Endsight</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Endsight_create_new_user</template>
    </alerts>
    <alerts>
        <fullName>Account_deactivation_approved</fullName>
        <description>Account deactivation approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>ITManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>asoliman@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cdibraccio@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kknight@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Account_Deactivation_Approval</template>
    </alerts>
    <alerts>
        <fullName>Alert_To_Jeremy_Requisition_Expired</fullName>
        <description>Alert To Jeremy- Requisition Expired</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Personnel_Request_Expired</template>
    </alerts>
    <alerts>
        <fullName>Business_Cards_Approved</fullName>
        <description>Business Cards Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/BusinessCardsApproved</template>
    </alerts>
    <alerts>
        <fullName>CAD_Library_Addition_Approved</fullName>
        <description>CAD Library Addition Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/CAD_Library_Approval_User</template>
    </alerts>
    <alerts>
        <fullName>CAD_Library_Addition_Rejected</fullName>
        <description>CAD Library Addition Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CAD_Addition_Rejected_Owner</template>
    </alerts>
    <alerts>
        <fullName>CAD_Library_Addition_Submitted_Ops</fullName>
        <description>CAD Library Addition Submitted- Ops</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/CAD_Library_Approval_Ops</template>
    </alerts>
    <alerts>
        <fullName>Check_Request_Approved</fullName>
        <description>Check Request Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Check_Request_Approval_Notice</template>
    </alerts>
    <alerts>
        <fullName>Check_Request_Rejected</fullName>
        <description>Check Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Check_Request_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Computer_Purchase_Notification</fullName>
        <description>Computer Purchase Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Computer_Purchase_Notification</template>
    </alerts>
    <alerts>
        <fullName>Create_Phone_Number</fullName>
        <description>Create Phone Number and Computer Set up</description>
        <protected>false</protected>
        <recipients>
            <recipient>abarss@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbarbosa@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>obasegio@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>svelez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Employee_Phone_set_up</template>
    </alerts>
    <alerts>
        <fullName>DocuSign_Request_Accepted</fullName>
        <description>DocuSign Request Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/DocuSign_Request_Accepted</template>
    </alerts>
    <alerts>
        <fullName>DocuSign_Request_Rejected</fullName>
        <description>DocuSign Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/DocuSign_Request_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Email_Horizon_set_up_account</fullName>
        <ccEmails>support@cumulusglobal.com</ccEmails>
        <description>Email Horizon- set up account</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Cumulus_create_new_user</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_Holly_IT_req</fullName>
        <description>Email alert to Holly- IT req</description>
        <protected>false</protected>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/SF_Req_Email_Update_to_Erik</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Managers_3_days_post_start_date</fullName>
        <description>Email to Managers 3 days post start date</description>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Post_Hire_manager_email</template>
    </alerts>
    <alerts>
        <fullName>Employ_Bio_Comments_Added</fullName>
        <description>Employ Bio Comments Added</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kengstrom@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Comments_Added</template>
    </alerts>
    <alerts>
        <fullName>Employ_Bio_Final_Draft_Approved</fullName>
        <description>Employ Bio Final Draft Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kengstrom@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Final_Draft_Approved_by_Employee</template>
    </alerts>
    <alerts>
        <fullName>Employ_Bio_Final_Draft_Ready_for_Review</fullName>
        <description>Employ Bio Final Draft Ready for Review</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Final_Draft_Ready_for_Review</template>
    </alerts>
    <alerts>
        <fullName>Employ_Bio_Questions_Complete_Email_Alert</fullName>
        <description>Employ Bio Questions Complete Email Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kengstrom@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Employ_Bio_Working_Draft_Ready_for_Review</fullName>
        <description>Employ Bio Working Draft Ready for Review</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Working_Draft_Ready_for_Review</template>
    </alerts>
    <alerts>
        <fullName>Employee_Bio_Posted_to_Website</fullName>
        <description>Employee Bio Posted to Website</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Employee_Bio_Posted_To_Website</template>
    </alerts>
    <alerts>
        <fullName>Energize_Award_Alert_to_Manager</fullName>
        <description>Energize Award Alert to Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Recipient_Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Energize_Award_Notify_Manager</template>
    </alerts>
    <alerts>
        <fullName>Energize_Award_Notify_Recipient</fullName>
        <description>Energize Award - Notify Recipient</description>
        <protected>false</protected>
        <recipients>
            <field>Recipient__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Energize_Award_Notify_Recipient</template>
    </alerts>
    <alerts>
        <fullName>Energize_Award_Submitted</fullName>
        <ccEmails>peopleandculture@borregosolar.com</ccEmails>
        <description>Energize Award Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>Comp_Benefits_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Energize_Award_Notification</template>
    </alerts>
    <alerts>
        <fullName>Energize_Req_has_been_approved</fullName>
        <description>Energize Req has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Energize_award_approved</template>
    </alerts>
    <alerts>
        <fullName>HR_Notification</fullName>
        <description>HR Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>VP_of_People_Culture</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/HR_Notification_of_Personnel_Req</template>
    </alerts>
    <alerts>
        <fullName>IT_Item_Ordered</fullName>
        <description>IT Item Ordered</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/IT_Item_Ordered</template>
    </alerts>
    <alerts>
        <fullName>IT_Support_Req_Accepted</fullName>
        <description>IT Support Req Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/IT_Support_Req_Accepted</template>
    </alerts>
    <alerts>
        <fullName>IT_Support_Req_Created</fullName>
        <description>IT Support Req Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/IT_Support_Req_Created</template>
    </alerts>
    <alerts>
        <fullName>ItemPurchased</fullName>
        <description>Item Purchased</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/ItemPurchased</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Accepted</fullName>
        <description>Legal Request Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Accepted_Confidential</fullName>
        <description>Legal Request Accepted - Confidential</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Accepted_Legal_Request_Approval_Attorney_Client_Privileged_and_Co</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Accepted_Dispute</fullName>
        <description>Legal Request Accepted - Dispute</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Accepted_Dispute</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Assigned</fullName>
        <description>Legal Request Assigned</description>
        <protected>false</protected>
        <recipients>
            <field>BSSI_Attorney__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Assigned</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Completed</fullName>
        <description>Legal Request Completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Completed</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Completed_Dispute</fullName>
        <description>Legal Request Completed - Dispute</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Completed_Dispute</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Completed_HR_Employee_Matter</fullName>
        <description>Legal Request Completed HR/Employee Matter</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Approval_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Approval_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Completed_HR_Employee_Matter</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Rejected</fullName>
        <description>Legal Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Rejected_Confidential</fullName>
        <description>Legal Request Rejected - Confidential</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Rejected_Legal_Request_Approval_Attorney_Client_Privileged_and_Con</template>
    </alerts>
    <alerts>
        <fullName>Legal_Request_Rejected_Dispute</fullName>
        <description>Legal Request Rejected - Dispute</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Legal_Request_Rejected_Dispute</template>
    </alerts>
    <alerts>
        <fullName>Legal_Requisition_Form_Follow_Up</fullName>
        <description>Legal Requisition Form Follow Up</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Follow_Up_Legal_Req</template>
    </alerts>
    <alerts>
        <fullName>New_Employee_Starting_Soon</fullName>
        <description>New Employee Starting Soon</description>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Employee_Starting_soon</template>
    </alerts>
    <alerts>
        <fullName>New_Employee_notification</fullName>
        <description>New Employee notification</description>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Employee_Starting_soon</template>
    </alerts>
    <alerts>
        <fullName>New_Hire_Initial_Referral_30_Days_has_passed</fullName>
        <description>New Hire Initial Referral - 30 Days has passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Hire_with_Referral_30_Days_has_passed</template>
    </alerts>
    <alerts>
        <fullName>New_Hire_Initial_Referral_Alert</fullName>
        <description>New Hire Initial Referral Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Hire_with_Referral</template>
    </alerts>
    <alerts>
        <fullName>New_User_Syndeo</fullName>
        <ccEmails>support@syndeotech.com</ccEmails>
        <description>New User Syndeo</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Syndeo_create_new_user</template>
    </alerts>
    <alerts>
        <fullName>NonOps_Exempt_Employee_NonCA</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>NonOps Exempt Employee NonCA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/NON_OPS_New_Hire_Email_NonCA</template>
    </alerts>
    <alerts>
        <fullName>Non_Ops_Employee_CA</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Non Ops Employee CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/NON_OPS_New_Hire_Email</template>
    </alerts>
    <alerts>
        <fullName>Non_Ops_NonExempt_CA</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Non Ops NonExempt CA / Non CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/Non_Ops_NonExempt_CA_Non_CA</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_Accounting_that_personnel_change_request_is_in_process</fullName>
        <description>Notification to Accounting that personnel change request is in process.</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>cdibraccio@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kknight@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Personnel_Change_Request</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_Creator</fullName>
        <description>Notification to Creator</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>elaramee@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lforrester@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/General_Purchase_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_Creator2</fullName>
        <description>Notification to Creator</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/General_Purchase_Approved</template>
    </alerts>
    <alerts>
        <fullName>OPS_O_M_New_Hire_Email_Alert</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>OPS/O&amp;M New Hire Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/OPS_O_M_EMAIL_New_Hire_Email_CA</template>
    </alerts>
    <alerts>
        <fullName>OPS_O_M_New_Hire_Email_Alert_Non_CA</fullName>
        <description>OPS/O&amp;M New Hire Email Alert Non CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/OPS_O_M_EMAIL_New_Hire_Email_NonCA</template>
    </alerts>
    <alerts>
        <fullName>O_M_Exempt_CA</fullName>
        <description>O&amp;M Exempt CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/O_M_Exempt_CA</template>
    </alerts>
    <alerts>
        <fullName>O_M_Exempt_Non_CA</fullName>
        <description>O&amp;M Exempt Non CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/O_M_Exempt_Non_CA</template>
    </alerts>
    <alerts>
        <fullName>O_M_NonExempt_CA</fullName>
        <description>O&amp;M NonExempt CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/O_M_nonexempt_CA</template>
    </alerts>
    <alerts>
        <fullName>O_M_NonExempt_Non_CA</fullName>
        <description>O&amp;M NonExempt Non CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/O_M_NonExempt_Non_CA</template>
    </alerts>
    <alerts>
        <fullName>Offer_Letter_Signed_East</fullName>
        <description>Offer Letter Signed  - East</description>
        <protected>false</protected>
        <recipients>
            <recipient>asoliman@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Offer_Letter_Signed</template>
    </alerts>
    <alerts>
        <fullName>Offer_Letter_Signed_Oakland</fullName>
        <description>Offer Letter Signed  - Oakland</description>
        <protected>false</protected>
        <recipients>
            <recipient>asoliman@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kknight@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Offer_Letter_Signed</template>
    </alerts>
    <alerts>
        <fullName>Offer_Letter_Signed_San_Diego</fullName>
        <description>Offer Letter Signed  - San Deigo</description>
        <protected>false</protected>
        <recipients>
            <recipient>asoliman@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Offer_Letter_Signed</template>
    </alerts>
    <alerts>
        <fullName>Onboard_Checklist_Manager</fullName>
        <description>Onboard Checklist - Manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Onboard_Checklist</template>
    </alerts>
    <alerts>
        <fullName>Ops_NonExempt_Employee_CA</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Ops NonExempt Employee CA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/OPS_Non_Exempt_New_Hire_Email_CA</template>
    </alerts>
    <alerts>
        <fullName>Ops_NonExempt_Employee_NonCA</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Ops NonExempt Employee NonCA</description>
        <protected>false</protected>
        <recipients>
            <field>New_User_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>peopleandculture@borregosolar.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HR/OPS_Non_Exempt_New_Hire_Email_NonCA</template>
    </alerts>
    <alerts>
        <fullName>PersonnelRejected</fullName>
        <description>Personnel Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>VP_of_People_Culture</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PersonnelRejectedOwner</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Approved</fullName>
        <description>Personnel Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PersonnelApprovedOwner</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Change_Approved_Employee_Alert</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Personnel Change Approved - Employee Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Name1__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Personnel_Change_Request_Effective_Date_Reached_Employee</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Change_Approved_Employee_Manager_Alert</fullName>
        <description>Personnel Change Approved - Employee/Manager Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Personnel_Change_Request_Complete_Employee</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Change_Complete_HR_Payroll</fullName>
        <description>Personnel Change Complete HR/Payroll</description>
        <protected>false</protected>
        <recipients>
            <recipient>cdibraccio@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kpellerin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pfort@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vmalaga@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Personnel_Change_Request_Complete_HR_Payrool</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Change_Request_Complete_IT</fullName>
        <description>Personnel Change Request Complete IT</description>
        <protected>false</protected>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhanagan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Personnel_Change_Request_Complete_IT</template>
    </alerts>
    <alerts>
        <fullName>Personnel_Change_Request_Complete_Notification</fullName>
        <description>Personnel Change Request Complete Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>idiza@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>keden@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Personnel_Change_Request_Complete</template>
    </alerts>
    <alerts>
        <fullName>Process_Improvement_Proposal_Approved</fullName>
        <description>Process Improvement Proposal Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Process_Improvement_Proposal_Approved</template>
    </alerts>
    <alerts>
        <fullName>Process_Improvement_Proposal_Complete</fullName>
        <description>Process Improvement Proposal Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Process_Improvement_Proposal_Complete</template>
    </alerts>
    <alerts>
        <fullName>Process_Improvement_Proposal_Rejected</fullName>
        <description>Process Improvement Proposal Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Process_Improvement_Proposal_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Process_Improvement_Proposal_Submitted</fullName>
        <description>Process Improvement Proposal Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Owner_of_Standard__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Process_Improvement_Proposal_Submitted</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApproved</fullName>
        <description>Purchase Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApprovedOwner</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedIT</fullName>
        <description>Purchase Approved - IT</description>
        <protected>false</protected>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedNewEngland</fullName>
        <description>Purchase Approved - New England</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedNorthCA</fullName>
        <description>Purchase Approved - North CA</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedOffice</fullName>
        <description>Purchase Approved - Office</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedOfficeItem</fullName>
        <description>Purchase Approved - Office Items</description>
        <protected>false</protected>
        <recipients>
            <recipient>dbarbosa@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseApprovedSouthCA</fullName>
        <description>Purchase Approved - South CA</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>PurchaseRejectedOwner</fullName>
        <description>Purchase Rejected - Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseRejectedOwner</template>
    </alerts>
    <alerts>
        <fullName>Purchase_Req_Approved</fullName>
        <description>Purchase Req Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Treasury_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/PurchaseApproved</template>
    </alerts>
    <alerts>
        <fullName>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Eri</fullName>
        <description>Requisition Form Email Notification Salesforce Request Has Been Assisgned to Rich</description>
        <protected>false</protected>
        <recipients>
            <recipient>rdaniels@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/SF_Req_Email_Update_to_Erik</template>
    </alerts>
    <alerts>
        <fullName>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Mar</fullName>
        <description>Requisition Form Email Notification Salesforce Request Has Been Assisgned to Mary</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_Req_Email_Update_to_Patty</template>
    </alerts>
    <alerts>
        <fullName>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Pat</fullName>
        <description>Requisition Form Email Notification Salesforce Request Has Been Assisgned to Rich</description>
        <protected>false</protected>
        <recipients>
            <recipient>rdaniels@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_Req_Email_Update_to_Patty</template>
    </alerts>
    <alerts>
        <fullName>Salesforce_Request_Approved</fullName>
        <description>Salesforce Request Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rdaniels@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Salesforce_Update_Approved</template>
    </alerts>
    <alerts>
        <fullName>Salesforce_Request_Rejected</fullName>
        <description>Salesforce Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rdaniels@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Salesforce_Update_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Salesforce_Update_Complete</fullName>
        <description>Salesforce Update Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Salesforce_Update_Complete</template>
    </alerts>
    <alerts>
        <fullName>StockApproved</fullName>
        <description>Stock Option Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/StockApprovedOwner</template>
    </alerts>
    <alerts>
        <fullName>Stock_Option_Approved_Controller</fullName>
        <description>Stock Option Approved - Controller</description>
        <protected>false</protected>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/StockApprovedCon</template>
    </alerts>
    <alerts>
        <fullName>Stock_Option_Rejected</fullName>
        <description>Stock Option Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/StockRejectedOwner</template>
    </alerts>
    <alerts>
        <fullName>Tech_Req_Complete</fullName>
        <description>Tech Req Complete</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Tech_Req_Complete</template>
    </alerts>
    <alerts>
        <fullName>TravelApprovedOwner</fullName>
        <description>Travel Approved - Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/TravelApprovedOwner</template>
    </alerts>
    <alerts>
        <fullName>TravelRejectedOwner</fullName>
        <description>Travel Rejected - Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/TravelRejectedOwner</template>
    </alerts>
    <alerts>
        <fullName>Update_Sharing_Rules_for_recruitment_team</fullName>
        <description>Update Sharing Rules for recruitment team</description>
        <protected>false</protected>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Update_Lead_Sharing_Rules</template>
    </alerts>
    <alerts>
        <fullName>set_up_SF_account</fullName>
        <description>Set up SF Account</description>
        <protected>false</protected>
        <recipients>
            <recipient>cdibraccio@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhanagan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Create_SF_Account</template>
    </alerts>
    <fieldUpdates>
        <fullName>Account_submitted</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Account submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Admin_Review</fullName>
        <description>Changes status to Admin Review</description>
        <field>Status__c</field>
        <literalValue>Admin Review</literalValue>
        <name>Admin Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ApprovalPending</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Date_Update</fullName>
        <field>Approval_Date__c</field>
        <formula>Today()</formula>
        <name>Approval Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>AutoAssigntoUltiProAdmin</fullName>
        <description>Make UltiPro admin owner of UltiPro reqs</description>
        <field>Requisition_Owner__c</field>
        <literalValue>Mary Mersereau</literalValue>
        <name>AutoAssigntoUltiProAdmin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Completed_Date_Update</fullName>
        <description>updates the completed date on SF REqs</description>
        <field>Completed_Date__c</field>
        <formula>TODAY()</formula>
        <name>Completed Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_ID</fullName>
        <description>brought over from user record</description>
        <field>Employee_Contact_Record_ID_2__c</field>
        <formula>Employee_Name1__r.Contact_Record_ID__c</formula>
        <name>Contact ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Accepted</fullName>
        <field>Date_Accepted__c</field>
        <formula>TODAY()</formula>
        <name>Date Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Complete</fullName>
        <description>updates Date complete with TODAY()</description>
        <field>Date_Complete__c</field>
        <formula>TODAY()</formula>
        <name>Date Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DocuSign_Request_Rejected</fullName>
        <field>Status_DocuSign__c</field>
        <literalValue>Rejected</literalValue>
        <name>DocuSign Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Follow_Up_Status_N_A</fullName>
        <field>FollowUpStatus__c</field>
        <literalValue>N/A</literalValue>
        <name>Follow Up Status- N/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Follow_Up_Status_Scheduled</fullName>
        <field>FollowUpStatus__c</field>
        <literalValue>Scheduled</literalValue>
        <name>Follow Up Status- Scheduled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IT_Approval</fullName>
        <field>Status__c</field>
        <literalValue>IT Approved</literalValue>
        <name>IT Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Request_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Request Accepted</literalValue>
        <name>Legal Request Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Request_Completed</fullName>
        <field>Status__c</field>
        <literalValue>Complete</literalValue>
        <name>Legal Request Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Request_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Request Rejected</literalValue>
        <name>Legal Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Status_Update</fullName>
        <field>Status__c</field>
        <literalValue>Request Pending</literalValue>
        <name>Legal Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Manager_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Manager Approved</literalValue>
        <name>Manager Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Out_of_User_Testing_Date_on_SF_Update</fullName>
        <field>Out_of_User_Testing__c</field>
        <formula>TODAY()</formula>
        <name>Out of User Testing Date on SF Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Out_of_Waiting_Date_on_SF_Update</fullName>
        <field>Out_of_Waiting_Date__c</field>
        <formula>TODAY()</formula>
        <name>Out of Waiting Date on SF Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Owner_update_to_Holly</fullName>
        <field>Requisition_Owner__c</field>
        <literalValue>Holly Kiernan</literalValue>
        <name>Owner update to Holly</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Personnel_Change_Request_Complete</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Personnel Change Request Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalled_Request</fullName>
        <field>Status__c</field>
        <literalValue>On Hold</literalValue>
        <name>Recalled Request</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>Status__c</field>
        <literalValue>X - Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Req_Owner_Mary</fullName>
        <field>Requisition_Owner__c</field>
        <literalValue>Mary Mersereau</literalValue>
        <name>Req Owner - Mary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Req_Owner_to_Erik</fullName>
        <field>Requisition_Owner__c</field>
        <literalValue>Richard Daniels</literalValue>
        <name>Req Owner to Rich</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Req_Owner_to_Matt</fullName>
        <field>Requisition_Owner__c</field>
        <literalValue>Matt Hanagan</literalValue>
        <name>Req Owner to Matt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Req_Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Req Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>STatus_update_to_rejected</fullName>
        <field>Status__c</field>
        <literalValue>X - Rejected</literalValue>
        <name>STatus update to rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>StatusExecutiveApproved</fullName>
        <field>Status__c</field>
        <literalValue>Executive Approved</literalValue>
        <name>Status - Executive Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>StatusHODApproved</fullName>
        <field>Status__c</field>
        <literalValue>Department Head Approved</literalValue>
        <name>Status - HOD Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>StatusManagerApproved</fullName>
        <field>Status__c</field>
        <literalValue>Manager Approved</literalValue>
        <name>Status - Manager Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Request Accepted</literalValue>
        <name>Status Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change_to_Expired</fullName>
        <field>Status__c</field>
        <name>Status Change to Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Update_to_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status Update to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_equals_Accepted</fullName>
        <field>Status_DocuSign__c</field>
        <literalValue>Accepted</literalValue>
        <name>Status equals Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_equals_Submitted</fullName>
        <field>Status_DocuSign__c</field>
        <literalValue>Submmitted</literalValue>
        <name>Status equals Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Admin_Notes</fullName>
        <description>auto populates value from current admin note and date stamps and initial stamps to build historical trail</description>
        <field>Admin_Notes__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; 
+ LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot; 
+  Current_Admin_Note__c  + BR() + 
BR() + PRIORVALUE(  Admin_Notes__c  )</formula>
        <name>Update Admin Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Accepted</fullName>
        <description>updates the date accepted field with TODAY()</description>
        <field>Date_Accepted__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Submitted</fullName>
        <description>updates the date submitted field with TODAY()</description>
        <field>Date_Submitted__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Employee_Manager_s_Email</fullName>
        <description>Auto update Employee Manager&apos;s Email to be used in email alert</description>
        <field>Recipient_Manager_s_Email__c</field>
        <formula>Recipient__r.Manager.Email</formula>
        <name>Update Employee Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_owner_manager_s_manager_Id</fullName>
        <field>OwnerManagerManagersId__c</field>
        <formula>CASESAFEID(owner_manager__r.ManagerId)</formula>
        <name>Update owner manager&apos;s manager Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Urgent_Tech_Re</fullName>
        <field>Priority__c</field>
        <literalValue>Urgent</literalValue>
        <name>Urgent Tech Re</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>User_Testing_Date_on_SF_Update</fullName>
        <field>User_Testing_Date__c</field>
        <formula>TODAY()</formula>
        <name>User Testing Date on SF Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Waiting_Date_SF_Update_REQ</fullName>
        <field>Waiting_Date__c</field>
        <formula>TODAY()</formula>
        <name>Waiting Date SF Update REQ</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AutoAssignTechReqAdmin</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Eri</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Req_Owner_to_Erik</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>2 AND 3 AND (1 OR 4 OR 5)</booleanFilter>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Owner_Business_Unit__c</field>
            <operation>contains</operation>
            <value>ESD</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.FirstName</field>
            <operation>notEqual</operation>
            <value>Patty,Emily,Richard,Mary</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Owner_Business_Unit__c</field>
            <operation>contains</operation>
            <value>Development</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Owner_Business_Unit__c</field>
            <operation>contains</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <description>Auto Assign Technical Req to SF Admin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AutoAssignTechReqHolly</fullName>
        <actions>
            <name>Owner_update_to_Holly</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>equals</operation>
            <value>OTHER</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Object_to_Update__c</field>
            <operation>notEqual</operation>
            <value>UltiPro,Procore</value>
        </criteriaItems>
        <description>Auto Assign Technical Req to IT Manager</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AutoAssignTechReqMary</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Mar</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Req_Owner_Mary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>2 and 4 and (1 or 3)</booleanFilter>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Owner_Business_Unit__c</field>
            <operation>contains</operation>
            <value>Shared Services</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Owner_Business_Unit__c</field>
            <operation>contains</operation>
            <value>EPC</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Re-Assign Technical Req to SF Admin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AutoAssignTechReqRich</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Pat</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>equals</operation>
            <value>Salesforce</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.FirstName</field>
            <operation>notEqual</operation>
            <value>Richard</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
            <value>Richard Daniels</value>
        </criteriaItems>
        <description>Re-Assign Technical Req to SF Admin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AutoAssignTechReqUltiPro</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Mar</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>AutoAssigntoUltiProAdmin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>equals</operation>
            <value>OTHER</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Object_to_Update__c</field>
            <operation>equals</operation>
            <value>UltiPro</value>
        </criteriaItems>
        <description>Auto Assign Technical Req to UltiPro Admin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Completed Date Update</fullName>
        <actions>
            <name>Completed_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Completed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>auto updates the completed date when the status = complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DocuSign Date Complete</fullName>
        <actions>
            <name>Date_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>DocuSign Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Fully Executed</value>
        </criteriaItems>
        <description>updates the field Date Complete on the DocuSign Request record type</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Comments Added</fullName>
        <actions>
            <name>Employ_Bio_Comments_Added</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert back to marketingthat comments have been added to working draft</description>
        <formula>ISCHANGED ( Draft_Status__c) &amp;&amp;  ISPICKVAL( Draft_Status__c , &quot;Employee Comments Added&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Final Draft Approved by Employee</fullName>
        <actions>
            <name>Employ_Bio_Final_Draft_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert back to marketing that the employee has approved the final draft</description>
        <formula>ISCHANGED ( Draft_Status__c) &amp;&amp;  ISPICKVAL( Draft_Status__c , &quot;Approved&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Final Draft Ready for Review</fullName>
        <actions>
            <name>Employ_Bio_Final_Draft_Ready_for_Review</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert back to requestor that a final draft has been completed and is ready for their review</description>
        <formula>ISCHANGED ( Draft_Status__c) &amp;&amp;  ISPICKVAL( Draft_Status__c , &quot;Final Draft Ready for Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Posted to Site</fullName>
        <actions>
            <name>Employee_Bio_Posted_to_Website</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert back to requestor that bio has been posted to the website</description>
        <formula>ISCHANGED ( Draft_Status__c) &amp;&amp;  ISPICKVAL( Draft_Status__c , &quot;Posted to Website&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Request Submitted</fullName>
        <actions>
            <name>Employ_Bio_Questions_Complete_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employee Bio</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Draft_Status__c</field>
            <operation>equals</operation>
            <value>Submitted to Marketing</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee Bio Working Draft Ready for Review</fullName>
        <actions>
            <name>Employ_Bio_Working_Draft_Ready_for_Review</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>sends email alert back to requestor that a working draft has been completed and is ready for their review</description>
        <formula>ISCHANGED ( Draft_Status__c) &amp;&amp;  ISPICKVAL( Draft_Status__c , &quot;Working Draft Ready for Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Employee Contact Record ID</fullName>
        <actions>
            <name>Contact_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Brings over the related Contact ID. Used with LH</description>
        <formula>NOT(ISBLANK( Employee_Name1__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Follow Up Status- Low Impact</fullName>
        <actions>
            <name>Follow_Up_Status_N_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Priority__c</field>
            <operation>equals</operation>
            <value>Low</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Gathering Requirements,In Progress</value>
        </criteriaItems>
        <description>defaults to &quot;N/A&quot; when Impact Level is &quot;Low&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Follow Up Status- Med%2FHigh Impact</fullName>
        <actions>
            <name>Follow_Up_Status_Scheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Priority__c</field>
            <operation>notEqual</operation>
            <value>Low,Urgent</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Gathering Requirements,In Progress</value>
        </criteriaItems>
        <description>defaults to &quot;Scheduled&quot; when Impact Level is &quot;Medium&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>General Purchase Req Approved</fullName>
        <actions>
            <name>Purchase_Req_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>General Purchase</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>When a General Purchase Req is approved - send an email</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IT Hardware%2FSoftware Item Approved</fullName>
        <actions>
            <name>PurchaseApprovedIT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email alert when an IT Request for a non-office item is approved</description>
        <formula>AND(  ISPICKVAL( Status__c , &quot;Approved&quot; ),  RecordType.DeveloperName = &quot;ITRequest&quot; ,  NOT( ISPICKVAL( Item_Requested__r.Type__c , &quot;Office&quot; ) )  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IT Item Ordered</fullName>
        <actions>
            <name>IT_Item_Ordered</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Ordered,Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Request</value>
        </criteriaItems>
        <description>Feedback loop to let employees know when their approved IT purchase has been ordered with an estimated delivery date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IT Office Item Approved</fullName>
        <actions>
            <name>PurchaseApprovedOfficeItem</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email alert when an IT Request for an office item is approved</description>
        <formula>AND(  ISPICKVAL( Status__c , &quot;Approved&quot; ),  RecordType.DeveloperName = &quot;ITRequest&quot; ,  ISPICKVAL( Item_Requested__r.Type__c , &quot;Office&quot; )  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IT Support Req Accepted</fullName>
        <actions>
            <name>IT_Support_Req_Accepted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Sys Admin w/o HR</value>
        </criteriaItems>
        <description>When the IT Support Req status is changed to accepted by an admin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IT Support Req Created</fullName>
        <actions>
            <name>IT_Support_Req_Created</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Admin_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type_of_Request__c</field>
            <operation>equals</operation>
            <value>WORK STOPPAGE,Error Message</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notEqual</operation>
            <value>Applications Developer</value>
        </criteriaItems>
        <description>Sends email to user and changes status to &quot;Admin Review&quot;</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Legal Forms Completed Follow UP</fullName>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Legal Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.BSSI_Attorney__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Request Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Complete__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>triggers time based email alerts to ensure legal requisition was completed by outside counsel</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Legal_Requisition_Form_Follow_Up</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Date_Accepted__c</offsetFromField>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Legal_Requisition_Form_Follow_Up</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Date_Accepted__c</offsetFromField>
            <timeLength>42</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Legal Request Assigned</fullName>
        <actions>
            <name>Legal_Request_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Legal Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.BSSI_Attorney__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Legal Request Completed</fullName>
        <actions>
            <name>Legal_Request_Completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Legal_Request_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Legal Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>notEqual</operation>
            <value>Dispute,HR / Employee Matter</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Legal Request Completed Dispute</fullName>
        <actions>
            <name>Legal_Request_Completed_Dispute</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Legal_Request_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Legal Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>equals</operation>
            <value>Dispute</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Legal Request Completed HR%2FEmployee Matter</fullName>
        <actions>
            <name>Legal_Request_Completed_HR_Employee_Matter</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Legal_Request_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Legal Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>equals</operation>
            <value>HR / Employee Matter</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Hire with Referral Notification</fullName>
        <active>false</active>
        <description>notifys P &amp; C whenever a new hire is hired and there is a referral</description>
        <formula>AND(  RecordTypeId = &quot;012800000006jx4&quot;,  ISPICKVAL(Status__c , &quot;Hired&quot;), NOT(ISBLANK(Referred_By__c))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_Hire_Initial_Referral_30_Days_has_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Actual_Start_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>New_Hire_Initial_Referral_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Actual_Start_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Offer Letter Signed - East</fullName>
        <actions>
            <name>Create_Phone_Number</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Offer_Letter_Signed_East</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Onboard_Checklist_Manager</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>set_up_SF_account</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Hired</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Branch2__c</field>
            <operation>notEqual</operation>
            <value>Berkeley,San Diego</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>notEqual</operation>
            <value>Internal/Transfer</value>
        </criteriaItems>
        <description>goes out when Personnel Req status changes to Hired</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Offer Letter Signed - Oakland</fullName>
        <actions>
            <name>Create_Phone_Number</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Offer_Letter_Signed_Oakland</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Onboard_Checklist_Manager</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>set_up_SF_account</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Hired</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Branch2__c</field>
            <operation>equals</operation>
            <value>Berkeley</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Personnel Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>notEqual</operation>
            <value>Internal/Transfer</value>
        </criteriaItems>
        <description>goes out when Personnel Req status changes to Hired</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Offer Letter Signed - San Deigo</fullName>
        <actions>
            <name>Create_Phone_Number</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Offer_Letter_Signed_San_Diego</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Onboard_Checklist_Manager</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>set_up_SF_account</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Hired</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Branch2__c</field>
            <operation>equals</operation>
            <value>San Diego</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Personnel Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Type__c</field>
            <operation>notEqual</operation>
            <value>Internal/Transfer</value>
        </criteriaItems>
        <description>goes out when Personnel Req status changes to Hired</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Out of User Testing Date on SF Update</fullName>
        <actions>
            <name>Out_of_User_Testing_Date_on_SF_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto-pops out of waiting date on SF Update REQ whenever Request Status moves from User TEsting to something else</description>
        <formula>AND( ISCHANGED( Status__c ),  RecordTypeId = &quot;012800000007g5m&quot;, NOT(ISPICKVAL(Status__c, &quot;User Testing&quot;)), NOT(ISBLANK( User_Testing_Date__c )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Out of Waiting Date on SF Update</fullName>
        <actions>
            <name>Out_of_Waiting_Date_on_SF_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto-pops out of waiting date on SF Update REQ whenever Request Status is updated to Waiting for Response</description>
        <formula>AND( ISCHANGED(Status__c ),  RecordTypeId = &quot;012800000007g5m&quot;, NOT(ISPICKVAL(Status__c, &quot;Waiting for Response&quot;)), NOT(ISBLANK(Waiting_Date__c )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Personnel Change Employee Notification</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Email alert to the employee that a personnel change has been approved and is in effect.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Personnel_Change_Approved_Employee_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Effective_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Reminder Email to Hiring Manager</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Account Creation Request</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_Employee_Starting_Soon</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Purchase_Requisition__c.Planned_Employee_Start_Date__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF Req Email Update to Admin</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Eri</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
            <value>Patty Ryder</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SF Req Email Update to Holly</fullName>
        <actions>
            <name>Email_alert_to_Holly_IT_req</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
            <value>Holly Kiernan</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.CreatedById</field>
            <operation>notEqual</operation>
            <value>Holly Kiernan</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SF Req Email Update to Mary</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Mar</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
            <value>Mary Mersereau</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SF Req Email Update to Rich</fullName>
        <actions>
            <name>Requisition_Form_Email_Notification_Salesforce_Request_Has_Been_Assisgned_to_Pat</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Requisition_Owner__c</field>
            <operation>equals</operation>
            <value>Richard Daniels</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Salesforce Update Complete</fullName>
        <actions>
            <name>Salesforce_Update_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT System Improvement</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.CreatedById</field>
            <operation>notEqual</operation>
            <value>Patty Ryder,Emily Tam,Erik Laramee</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Tech Req Complete</fullName>
        <actions>
            <name>Tech_Req_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TechReqUrgent</fullName>
        <actions>
            <name>Urgent_Tech_Re</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Technical Support</value>
        </criteriaItems>
        <description>marks tech reqs urgent</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Employee Manager%27s Email</fullName>
        <actions>
            <name>Update_Employee_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Purchase_Requisition__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Energize Award</value>
        </criteriaItems>
        <description>Update Employee Manager&apos;s Email to be used in email alert to notify managers of Energize Award</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update owner manager%27s manager Id</fullName>
        <actions>
            <name>Update_owner_manager_s_manager_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>used to update Owner Managers&apos; Manager field with their SF ID, used in conjunction with LH for approval processes routing</description>
        <formula>NOT(ISBLANK(   owner_manager__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>User Testing Date on SF Update</fullName>
        <actions>
            <name>User_Testing_Date_on_SF_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto-pops waiting date on SF Update REQ whenever Request Status is updated to User Testing</description>
        <formula>AND( ISCHANGED(Status__c ),  RecordTypeId = &quot;012800000007g5m&quot;, ISPICKVAL(Status__c, &quot;User Testing&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Waiting Date on SF Update</fullName>
        <actions>
            <name>Waiting_Date_SF_Update_REQ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto-pops waiting date on SF Update REQ whenever Request Status is updated to Waiting for Response</description>
        <formula>AND( ISCHANGED( Status__c ),  RecordTypeId = &quot;012800000007g5m&quot;, ISPICKVAL(Status__c, &quot;Waiting for Response&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>update admin notes</fullName>
        <actions>
            <name>Update_Admin_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto populates notes from current admin note into historical tracking field Admin Notes</description>
        <formula>ISCHANGED (Current_Admin_Note__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
