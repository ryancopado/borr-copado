<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Borrego_PPA_Notification</fullName>
        <description>Borrego PPA Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>fmatin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jtai@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>zchristie@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Borrego_PPA</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedContractor</fullName>
        <ccEmails>chris10@borregosolar.com, toddblicense@borregosolar.com, aaron46@borregosolar.com, joemaster@borregosolar.com</ccEmails>
        <description>Contract Signed - Contractor</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedtoContractors</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedManagement</fullName>
        <description>Contract Signed Management</description>
        <protected>false</protected>
        <recipients>
            <recipient>Internal</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedtoManagment</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedManagement_Offtaker</fullName>
        <description>Contract Signed Management Offtaker</description>
        <protected>false</protected>
        <recipients>
            <recipient>Internal</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSigned_Offtaker_toManagment</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedOtherAR</fullName>
        <description>Contract Signed - Other - AR</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedtoAR</template>
    </alerts>
    <alerts>
        <fullName>Create_Smartsheet_Reminder</fullName>
        <description>Create Smartsheet Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Create_Smartsheet_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Company_Wide_Development_Opportunity_Booked</fullName>
        <description>Email Alert Company Wide - Development Opportunity Booked</description>
        <protected>false</protected>
        <recipients>
            <recipient>Internal</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HR/CompanyWide_Development_Project_Booked</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Gary_Bradley_when_Contact_Signed_includes_PG</fullName>
        <description>Email Alert to Gary/Bradley when Contact Signed includes PG</description>
        <protected>false</protected>
        <recipients>
            <recipient>asachdeva@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>azaretsky@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bmartin@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Contract_Signed_to_Bradley_Gary</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_NY_Sales_team_that_Oppty_has_been_Closed_Lost</fullName>
        <description>Email Alert to NY Sales team that Oppty has been Closed Lost</description>
        <protected>false</protected>
        <recipients>
            <recipient>NY_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_O_M_team_that_Oppty_has_been_Closed_Lost</fullName>
        <description>Email Alert to O&amp; M team that Oppty has been Closed Lost</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_O_M_that_Oppty_has_moved_to_Disqualified</fullName>
        <description>Email Alert to O &amp; M that Oppty has moved to Disqualified</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Disqualified</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_O_M_that_Oppty_has_moved_to_No_Decision</fullName>
        <description>Email Alert to O&amp;M that Oppty has moved to No Decision</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_No_Decision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_O_M_that_Oppty_has_moved_to_Project_Awarded</fullName>
        <description>Email Alert to O &amp;M  that Oppty has moved to Project Awarded</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_O_M_Business_Development</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Awarded</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified</fullName>
        <description>Email Alert to Sales that Oppty has moved to Disqualified</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Disqualified</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified_Technical_EAST</fullName>
        <description>Email Alert to Sales that Oppty has moved to Disqualified-Technical_EAST</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>Eastern_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Disqualified</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified_Technical_WEST</fullName>
        <description>Email Alert to Sales that Oppty has moved to Disqualified-Technical_WEST</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Disqualified</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_NO_Decision_NY</fullName>
        <description>Email Alert to Sales that Oppty has moved to NO Decision NY</description>
        <protected>false</protected>
        <recipients>
            <recipient>NY_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bvonmoos@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_No_Decision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_No_Decision</fullName>
        <description>Email Alert to Sales that Oppty has moved to No Decision</description>
        <protected>false</protected>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bvonmoos@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_No_Decision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_No_Decision_1</fullName>
        <description>Email Alert to Sales that Oppty has moved to No Decision</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_No_Decision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_No_Decision_WDG</fullName>
        <description>Email Alert to Sales that Oppty has moved to No Decision WDG</description>
        <protected>false</protected>
        <recipients>
            <recipient>WDG_Sales_Region</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_No_Decision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_EAST</fullName>
        <description>Email Alert to Sales that Oppty has moved to Shorlisted/Interviews_EAST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Eastern_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Shortlisted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_NY</fullName>
        <description>Email Alert to Sales that Oppty has moved to Shorlisted/Interviews_NY</description>
        <protected>false</protected>
        <recipients>
            <recipient>NY_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Shortlisted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_WDG</fullName>
        <description>Email Alert to Sales that Oppty has moved to Shorlisted/Interviews_WDG</description>
        <protected>false</protected>
        <recipients>
            <recipient>WDG_Sales_Region</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Shortlisted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_WEST</fullName>
        <description>Email Alert to Sales that Oppty has moved to Shorlisted/Interviews_WEST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Shortlisted</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_WDG_Sales_team_that_Oppty_has_been_closed</fullName>
        <description>Email Alert to WDG Sales team that Oppty has been closed</description>
        <protected>false</protected>
        <recipients>
            <recipient>WDG_Sales_Region</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost</template>
    </alerts>
    <alerts>
        <fullName>Emerging_Markets_LOI_Signed</fullName>
        <description>Emerging Markets - LOI Signed</description>
        <protected>false</protected>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>soleary@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Emerging_Markets_LOI_Signed</template>
    </alerts>
    <alerts>
        <fullName>Financing_Date_Alert</fullName>
        <description>Financing Date Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Financing_Close_Date_Alert</template>
    </alerts>
    <alerts>
        <fullName>MIPA_Signed</fullName>
        <description>MIPA Signed</description>
        <protected>false</protected>
        <recipients>
            <recipient>Internal</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MIPA_Signed_Notification</template>
    </alerts>
    <alerts>
        <fullName>O_M_Opportunity_AutoCreate_Notification</fullName>
        <description>O&amp;M Opportunity AutoCreate Notification</description>
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
            <recipient>pstephenson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/O_M_Opportunity_Created</template>
    </alerts>
    <alerts>
        <fullName>Offtaker_CLOSED_LOST_EAST</fullName>
        <description>Offtaker CLOSED LOST EAST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Eastern_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost_Offtaker</template>
    </alerts>
    <alerts>
        <fullName>Offtaker_CLOSED_LOST_NY</fullName>
        <description>Offtaker CLOSED LOST NY</description>
        <protected>false</protected>
        <recipients>
            <recipient>NY_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost_Offtaker</template>
    </alerts>
    <alerts>
        <fullName>Offtaker_CLOSED_LOST_WEST</fullName>
        <description>Offtaker CLOSED LOST WEST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bvonmoos@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>phall@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wbush@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost_Offtaker</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Created</fullName>
        <description>Opportunity Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hkiernan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Created</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Option_Lease_Expiration_Warning_100_Days</fullName>
        <description>Opportunity Option Lease Expiration Warning 100 Days</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Option_Lease_Expiration_Warning_100_Days</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Option_Lease_Expiration_Warning_10_Days</fullName>
        <description>Opportunity Option Lease Expiration Warning 10 Days</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Option_Lease_Expiration_10_days</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Option_Lease_Expiration_Warning_30_Days</fullName>
        <description>Opportunity Option Lease Expiration Warning 30 Days</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Option_Lease_Expiration_30_days</template>
    </alerts>
    <alerts>
        <fullName>Oppty_Closed_Lost_EASTERN_DIVISION</fullName>
        <description>Oppty Closed Lost EASTERN DIVISION</description>
        <protected>false</protected>
        <recipients>
            <recipient>Eastern_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost</template>
    </alerts>
    <alerts>
        <fullName>Oppty_Closed_Lost_WESTERN_REGION</fullName>
        <description>Oppty Closed Lost WESTERN REGION</description>
        <protected>false</protected>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jconnell@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shorn@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Closed_Lost</template>
    </alerts>
    <alerts>
        <fullName>Oppty_has_moved_to_Disqualified_MIDWEST</fullName>
        <description>Oppty has moved to Disqualified - MIDWEST</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>afarkes@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Opportunity_Disqualified</template>
    </alerts>
    <alerts>
        <fullName>PV_Engineers_awarded</fullName>
        <ccEmails>ProjectNotifications@pv-engineers.com</ccEmails>
        <description>PV Engineers Awarded - Opportunity Project Awarded PB</description>
        <protected>false</protected>
        <recipients>
            <recipient>ddutil@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmersereau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/EPC_Opportunity_Awarded_PV_Engineers</template>
    </alerts>
    <alerts>
        <fullName>PaidinFullBS</fullName>
        <description>Paid in Full BS</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PaidinFull</template>
    </alerts>
    <alerts>
        <fullName>PaidinFullBoston</fullName>
        <description>Paid in Full Boston</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PaidinFull</template>
    </alerts>
    <alerts>
        <fullName>Project_Awarded_Notification</fullName>
        <ccEmails>westernpd@borregosolar.com</ccEmails>
        <description>Project Awarded Notification- West Coast</description>
        <protected>false</protected>
        <recipients>
            <recipient>Western_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VP_of_Operations_Western_Region</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPofSalesWest</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>aorozco@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ddutil@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbird@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rgerlach@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Awarded</template>
    </alerts>
    <alerts>
        <fullName>Project_Awarded_NotificationEC</fullName>
        <ccEmails>westernpd@borregosolar.com</ccEmails>
        <description>Project Awarded Notification- East Coast</description>
        <protected>false</protected>
        <recipients>
            <recipient>Eastern_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>NY_Sales_Division</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CFO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CTO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Executive_VP_of_Sales</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>PresidentProjectManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>aorozco@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ddutil@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpitera@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rgerlach@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Awarded</template>
    </alerts>
    <alerts>
        <fullName>Proposal_Submitted_Date_Notification</fullName>
        <description>Proposal Submitted Date Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Proposal_Submitted_Notification</template>
    </alerts>
    <alerts>
        <fullName>ReferralFeeDue</fullName>
        <description>Referral Fee Due</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>ApexCodedAlerts/ReferralFeeDue</template>
    </alerts>
    <alerts>
        <fullName>Service_Contract_Included_in_Project_Contract</fullName>
        <description>Service Contract Included in Project Contract</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorOperationsandMaintenance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>dmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marlise@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Service_Contract_Included</template>
    </alerts>
    <fieldUpdates>
        <fullName>Apps_Engineer_Auto_Assignment_Gebo</fullName>
        <field>Assigned_Apps_Engineer__c</field>
        <lookupValue>jinnes@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Apps Engineer Auto-Assignment - Gebo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Apps_Engineer_Auto_Assignment_Innes</fullName>
        <field>Assigned_Apps_Engineer__c</field>
        <lookupValue>jinnes@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Apps Engineer Auto-Assignment - Innes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Apps_Engineer_Auto_Assignment_Rogan</fullName>
        <field>Assigned_Apps_Engineer__c</field>
        <lookupValue>rguild@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Apps Engineer Auto-Assignment - Rogan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Apps_Engineer_Auto_Assignment_Yates</fullName>
        <field>Assigned_Apps_Engineer__c</field>
        <lookupValue>tyates@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Apps Engineer Auto-Assignment - Yates</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Apps_Engineer_O_Leary</fullName>
        <field>Assigned_Apps_Engineer__c</field>
        <lookupValue>soleary@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Apps Engineer - O&quot;Leary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Budgetary_Proposal_Submitted_Date</fullName>
        <field>Date_Budgetary_Proposal_Sent__c</field>
        <formula>TODAY()</formula>
        <name>Budgetary Proposal Submitted Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Date_Match_Storage_Close_Date</fullName>
        <field>Storage_Close_Date__c</field>
        <formula>CloseDate</formula>
        <name>Close Date Match Storage Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Update_Close_Date</fullName>
        <field>CloseDate</field>
        <formula>NOW()</formula>
        <name>Closed Update Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_LOI_Signed</fullName>
        <field>Date_LOI_Signed__c</field>
        <formula>TODAY()</formula>
        <name>Date LOI Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Marketing_Qualified</fullName>
        <field>Date_Marketing_Qualified__c</field>
        <formula>TODAY()</formula>
        <name>Date Marketing Qualified</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Option_Lease_Executed</fullName>
        <field>Option_Lease_Execution_Date__c</field>
        <formula>TODAY()</formula>
        <name>Date Option Lease Executed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ESD_Storage_Proposal</fullName>
        <field>Storage_Proposal_Submitted_Date__c</field>
        <formula>Proposal_Submitted_Date__c</formula>
        <name>ESD Storage Proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fore_cast_update</fullName>
        <field>Finalupdate__c</field>
        <formula>ForecastDefinition__c</formula>
        <name>Fore cast update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Jon_Cerino_Converted</fullName>
        <field>Jon_Cerino__c</field>
        <literalValue>1</literalValue>
        <name>Jon Cerino Converted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Jon_Cerino_Converted_2</fullName>
        <field>Development_Type__c</field>
        <literalValue>Strategic BD</literalValue>
        <name>Jon Cerino Converted 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Jon_Cerino_Opp_Manual_Update</fullName>
        <field>Jon_Cerino__c</field>
        <literalValue>1</literalValue>
        <name>Jon Cerino Opp Manual Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Jon_Cerino_Opp_Manual_Update_2</fullName>
        <field>Development_Type__c</field>
        <literalValue>Strategic BD</literalValue>
        <name>Jon Cerino Opp Manual Update 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MIPA_Signed_Date_Close_date</fullName>
        <field>CloseDate</field>
        <formula>MIPASignedDate__c</formula>
        <name>MIPA Signed Date = Close date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Most_recent_proposal_submitted_update</fullName>
        <field>Most_recent_proposal_submitted_date__c</field>
        <formula>Most_Recent_Proposal_Submitted__c</formula>
        <name>Most recent proposal submitted update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>O_M_Expected_Billing_AutoUpdate</fullName>
        <description>autoupdates Expected Billing date on O&amp;M opptortunity upon auto creation</description>
        <field>Expected_Billing_Start_Date__c</field>
        <formula>EPC_Opportunity__r.CloseDate +210</formula>
        <name>O&amp;M Expected Billing AutoUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>O_M_Opportunity_Created_Close_Date</fullName>
        <description>autopopulates close date on O&amp;M opportunity when autocreated</description>
        <field>CloseDate</field>
        <formula>EPC_Opportunity__r.CloseDate + 180</formula>
        <name>O&amp;M Opportunity Created Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OpportunityStageUpdate</fullName>
        <field>StageName</field>
        <literalValue>Proposal Sent</literalValue>
        <name>Opportunity Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Closed_Lost_update_Close_Dat</fullName>
        <field>CloseDate</field>
        <formula>Today()</formula>
        <name>Opportunity Closed Lost update Close Dat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Oppty_Owner_Manager_Email_Update</fullName>
        <field>Oppty_Owner_Manager_Email__c</field>
        <formula>Owner.Manager.Email</formula>
        <name>Oppty Owner Manager Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Possible_of_SItes</fullName>
        <description>auto updates to match # of sites when blank</description>
        <field>Number_of_Sites__c</field>
        <formula>of_Sites__c</formula>
        <name>Possible # of SItes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Awarded_Date_Update</fullName>
        <field>Project_Awarded_Date__c</field>
        <formula>Today()</formula>
        <name>Project Awarded Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Booked_Date</fullName>
        <field>Booked_Date__c</field>
        <formula>TODAY()</formula>
        <name>Project Booked Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Likelihood_100_when_Signed</fullName>
        <field>Project_Likelihood__c</field>
        <literalValue>100%</literalValue>
        <name>Project Likelihood 100% when Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Likelihood_Closed_Lost_Pushed_Ou</fullName>
        <description>updates to 0%</description>
        <field>Project_Likelihood__c</field>
        <literalValue>0%</literalValue>
        <name>Project Likelihood Closed Lost Pushed Ou</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Qualified_Date_update</fullName>
        <field>Opportunity_Qualified_Date__c</field>
        <formula>TODAY()</formula>
        <name>Qualified Date update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>S_S_Direct_COGS_Update</fullName>
        <description>Update Total Direct COGS (S+S Direct COGS) to System Size * S+S DCOGs $/watt whenever Development opportunity is updated</description>
        <field>S_S_Direct_COGS__c</field>
        <formula>SSDCOGswatt__c *  Original_Contract_System_Size__c</formula>
        <name>S+S/Total Direct COGS Update (Dev)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SalesOps_Qualified_Checkbox</fullName>
        <field>SalesOps_Qualified__c</field>
        <literalValue>1</literalValue>
        <name>SalesOps Qualified Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Shortlisted_Checkbox</fullName>
        <field>Shortlisted__c</field>
        <literalValue>1</literalValue>
        <name>Shortlisted Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Storage_Booked_Date</fullName>
        <field>Storage_Booked_Date__c</field>
        <formula>TODAY()</formula>
        <name>Storage Booked Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Inverter_Delivery_update_field</fullName>
        <description>Update &quot;Inverter Delivery Date Updated&quot; field</description>
        <field>Delivery_Date_Updated_I__c</field>
        <formula>TODAY()</formula>
        <name>Update Inverter Delivery update field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Module_Delivery_update_field</fullName>
        <field>Delivery_Date_Updated_M__c</field>
        <formula>TODAY()</formula>
        <name>Update Module Delivery update field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Non_PD_Bulk_Opportunity_field</fullName>
        <field>Non_PD_Bulk_Opportunity__c</field>
        <literalValue>1</literalValue>
        <name>Update Non-PD Bulk Opportunity field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Zero_out_Solar_Project_Likelihood</fullName>
        <field>Project_Likelihood__c</field>
        <literalValue>0%</literalValue>
        <name>Zero out Solar Project Likelihood</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>0a%2E Management</fullName>
        <actions>
            <name>ContractSignedContractor</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ContractSignedManagement</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Signed,EPC Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Captive/OnSite,Standard Opportunity,WDG Opportunity,O&amp;M Opportunity,Standalone Storage</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>0a%2E Management - Contract Signed - Offtaker</fullName>
        <actions>
            <name>ContractSignedContractor</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ContractSignedManagement_Offtaker</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Signed,EPC Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Offtaker</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AR - Other Contracts</fullName>
        <actions>
            <name>ContractSignedOtherAR</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Type</field>
            <operation>contains</operation>
            <value>Service,Upgrades,Consulting Services,Sub-Contract Install</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Auto-Assignment - Askins</fullName>
        <active>false</active>
        <description>assigns apps engineer Askins whenever the Opportunity Owner is not listed in other assignments.</description>
        <formula>ISPICKVAL(Owner.Branch__c, &quot;Corporate&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Auto-Assignment - FossMichaels</fullName>
        <active>false</active>
        <description>assigns apps engineer Rogan whenever the EPC Opportunity Owner user profile branch field is set to New England</description>
        <formula>AND(
   ISPICKVAL(Owner.Branch__c, &quot;New England&quot;),
   Owner.Id  &lt;&gt; &quot;00534000009fH1T&quot;
   )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Auto-Assignment - OLeary</fullName>
        <actions>
            <name>Apps_Engineer_O_Leary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>assigns apps engineer Shaun O&apos;Leary whenever the EPC Opportunity Owner user profile branch field is set to Midwest</description>
        <formula>AND(  ISPICKVAL(Owner.Branch__c, &quot;Midwest&quot;),  Owner.Id &lt;&gt; &quot;0053400000BYNI3&quot;  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Auto-Assignment - Rogan</fullName>
        <actions>
            <name>Apps_Engineer_Auto_Assignment_Rogan</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>assigns apps engineer Rogan whenever the EPC Opportunity Owner User profile branch field is set to So Cal</description>
        <formula>ISPICKVAL(Owner.Branch__c, &quot;So Cal&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Apps Engineer Auto-Assignment - Yates</fullName>
        <actions>
            <name>Apps_Engineer_Auto_Assignment_Yates</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>assigns apps engineer Yates whenever the Opportunity Owner user profile branch is set to Nor Cal</description>
        <formula>ISPICKVAL(Owner.Branch__c, &quot;Nor Cal&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Budgetary Proposal Submitted Date</fullName>
        <actions>
            <name>Budgetary_Proposal_Submitted_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Budgetary_Proposal_Sent__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>auto fills date field when checkbox of same name is used.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Close Date Match Storage Close Date</fullName>
        <actions>
            <name>Close_Date_Match_Storage_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>updates Storage Close Date to match Close Date on Standalone Storage record type</description>
        <formula>RecordTypeId = &quot;012340000007n0e&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Closed Lost Field Updates</fullName>
        <actions>
            <name>Closed_Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost,Not Ready / Pushed Out,Disqualified - Sales,Disqualified - Technical</value>
        </criteriaItems>
        <description>update project likelihood to 0% when closed lost or pushed out also updates Close Date to current date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Company Wide Email - Develop Oppty Booked</fullName>
        <actions>
            <name>Email_Alert_Company_Wide_Development_Opportunity_Booked</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Project Booked</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contract Signed and PG included</fullName>
        <actions>
            <name>Email_Alert_to_Gary_Bradley_when_Contact_Signed_includes_PG</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>EPC Signed,Contract Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Performance_Guarantee_Included__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>email alert to Gary/Bradley once contract is signed if PG Included is YES</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contract Signed updates Project Likelihood%2FClose Date</fullName>
        <actions>
            <name>Closed_Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_100_when_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Signed,EPC Signed</value>
        </criteriaItems>
        <description>uupdates project likelihood &amp; close date when stage is moved to contract signed or EPC signed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Create Smartsheet Reminder</fullName>
        <actions>
            <name>Create_Smartsheet_Reminder</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Oppty Stage for the east coast reaches LOI signed, send an email to the admins to create a smartsheet</description>
        <formula>And(  ISPICKVAL( StageName , &quot;LOI Signed&quot;),  RecordTypeId = &quot;012340000007ka0&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Date Marketing Qualified</fullName>
        <actions>
            <name>Date_Marketing_Qualified</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.SalesOps_Qualified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forecastsystemsize</fullName>
        <actions>
            <name>Fore_cast_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Not(ISBLANK( ForecastDefinition__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Jon Cerino Converted</fullName>
        <actions>
            <name>Jon_Cerino_Converted_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Development_Type__c</field>
            <operation>equals</operation>
            <value>Strategic BD</value>
        </criteriaItems>
        <description>If the jon cerino check box equals true and the lead is converted then the opportunity field will be updated to true.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Jon Cerino Opp Manual Update</fullName>
        <actions>
            <name>Jon_Cerino_Opp_Manual_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Jon_Cerino_Opp_Manual_Update_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Development_Type__c</field>
            <operation>equals</operation>
            <value>Strategic BD</value>
        </criteriaItems>
        <description>If Jon Cerino check box is updated to true then the jon cerino check box will updated on the account.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MIPA Signed %3D Close Date</fullName>
        <actions>
            <name>MIPA_Signed_Date_Close_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates close date on oppty to match mipa signed date</description>
        <formula>ISCHANGED( MIPASignedDate__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MIPA Signed Notification</fullName>
        <actions>
            <name>MIPA_Signed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>MIPA Signed</value>
        </criteriaItems>
        <description>Company email for MIPA Signed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Most recent proposal sumitted update</fullName>
        <actions>
            <name>Most_recent_proposal_submitted_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Most_Recent_Proposal_Submitted__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>O%26M Opportunty Created Alert %26 Field Updates</fullName>
        <actions>
            <name>O_M_Opportunity_AutoCreate_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>O_M_Expected_Billing_AutoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>O_M_Opportunity_Created_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>when O&amp;M opportunity is auto-created an alert is send out and close date and expected billing date are auto updated</description>
        <formula>NOT(ISBLANK( EPC_Opportunity__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost EAST DIVISION</fullName>
        <actions>
            <name>Oppty_Closed_Lost_EASTERN_DIVISION</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>East,New England</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost EAST OFFTAKER</fullName>
        <actions>
            <name>Offtaker_CLOSED_LOST_EAST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Closed_Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>East,New England</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Offtaker</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team - offtaker only</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost NY DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_NY_Sales_team_that_Oppty_has_been_Closed_Lost</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>New York</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost NY OFFTAKER</fullName>
        <actions>
            <name>Offtaker_CLOSED_LOST_NY</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Closed_Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>New York</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Offtaker</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost O %26 M</fullName>
        <actions>
            <name>Email_Alert_to_O_M_team_that_Oppty_has_been_Closed_Lost</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost WDG DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_WDG_Sales_team_that_Oppty_has_been_closed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>WDG</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Closed Lost WEST DIVISION</fullName>
        <actions>
            <name>Oppty_Closed_Lost_WESTERN_REGION</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Disqualfied-Midwest</fullName>
        <actions>
            <name>Oppty_has_moved_to_Disqualified_MIDWEST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Closed_Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Disqualified - Technical,Disqualified - Sales</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>Midwest</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>O&amp;M Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to disqualified</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Disqualfied-O %26 M</fullName>
        <actions>
            <name>Email_Alert_to_O_M_that_Oppty_has_moved_to_Disqualified</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Disqualified - Sales,Disqualified - Technical</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to disqualified</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Disqualfied-Sales</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Disqualified - Sales</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to disqualified-sales</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Disqualfied-Technical-EAST</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified_Technical_EAST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Disqualified - Technical</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>Boston,Mid Atlantic</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to disqualified-technical</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Disqualfied-Technical-WEST</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Disqualified_Technical_WEST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Disqualified - Technical</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Branch__c</field>
            <operation>equals</operation>
            <value>Berkeley,Oakland,San Diego</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to disqualified-technical</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity No Decision</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_No_Decision_1</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>No Decision</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to no decision</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity No Decision O %26 M</fullName>
        <actions>
            <name>Email_Alert_to_O_M_that_Oppty_has_moved_to_No_Decision</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Closed_Lost_update_Close_Dat</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Likelihood_Closed_Lost_Pushed_Ou</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>No Decision</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Opportunity</value>
        </criteriaItems>
        <description>email notification to sales mgt when oppty stage is moved to no decision</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Shortlisted EAST DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_EAST</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Shortlisted/Interviews</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>East,New England</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Shortlisted NY DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_NY</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Shortlisted/Interviews</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>New York</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <description>auto-populates date in Closed Date field as date it was moved to Closed Lost Stage and sends email to sales team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Shortlisted WDG DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_WDG</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Shortlisted/Interviews</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>WDG</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Shortlisted WEST DIVISION</fullName>
        <actions>
            <name>Email_Alert_to_Sales_that_Oppty_has_moved_to_Shorlisted_Interviews_WEST</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Shortlisted/Interviews</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Oppty Owner Manager Email Update</fullName>
        <actions>
            <name>Oppty_Owner_Manager_Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto updates Oppty Owner Manager&apos;s email address whenever Oppty Owner is changed.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Oppty Possible Sites Update</fullName>
        <actions>
            <name>Possible_of_SItes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto populates possible # of sites field with same value of # of Sites field if blank</description>
        <formula>ISCHANGED( of_Sites__c )  &amp;&amp; ISBLANK( Number_of_Sites__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Project Awarded Date</fullName>
        <actions>
            <name>Project_Awarded_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( StageName ), ISPICKVAL(StageName, &quot;Project Awarded&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Project Awarded Date- skip Award Stage</fullName>
        <actions>
            <name>Project_Awarded_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISPICKVAL(StageName, &quot;Contract Signed&quot;), 
ISCHANGED( StageName ), ISBLANK(Project_Awarded_Date__c )= TRUE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Project Awarded Notification O %26 M</fullName>
        <actions>
            <name>Email_Alert_to_O_M_that_Oppty_has_moved_to_Project_Awarded</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Project_Likelihood_100_when_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Project Awarded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Awarded Notification- East Coast</fullName>
        <actions>
            <name>Project_Awarded_NotificationEC</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Project Awarded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>East,New England,New York</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Awarded Notification- West Coast</fullName>
        <actions>
            <name>Project_Awarded_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Project Awarded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Opportunity_Owner_Division__c</field>
            <operation>equals</operation>
            <value>West</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Development,Offtaker,Captive/OnSite,Standard Opportunity,WDG Opportunity</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Booked Date</fullName>
        <actions>
            <name>Project_Booked_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED(StageName),  
ISPICKVAL(StageName, &quot;Project Booked&quot;) 
   || ISPICKVAL(StageName, &quot;Contract Signed&quot;)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Submitted Date Notification</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Prospecting</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Proposal_Submitted_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Proposal_Submitted_Date_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Proposal_Submitted_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Proposal Submitted Date Update ESD-Storage proposal submitted date</fullName>
        <actions>
            <name>ESD_Storage_Proposal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Storage_Proposal_Submitted_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Proposal_Submitted_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto fills ESD Storage proposal with same value upon initial update</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Qualified Date</fullName>
        <actions>
            <name>Qualified_Date_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( 
AND( 
ISNEW(), 
ISPICKVAL(StageName, &quot;Qualified&quot;) 
), 
AND( 
ISCHANGED( StageName ), 
ISPICKVAL(StageName, &quot;Qualified&quot;) 
) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Qualified Date- skip Qualified Stage</fullName>
        <actions>
            <name>Qualified_Date_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( StageName ), PRIORVALUE(StageName)= &quot;Prospecting&quot;, ISBLANK(Opportunity_Qualified_Date__c)= TRUE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>S%2BS Direct COGS Update from System Size</fullName>
        <actions>
            <name>S_S_Direct_COGS_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When System Size is updated, recalculates S+S Direct COGS as System Size * S+S DCOGs $/watt</description>
        <formula>AND(
Record_Type_Name__c = &quot;Development&quot; ,
ISCHANGED( Original_Contract_System_Size__c ),
NOT( ISBLANK( Synced_Pricing_Request__c ))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SalesOps Qualified Checkbox</fullName>
        <actions>
            <name>SalesOps_Qualified_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Qualification_Status__c</field>
            <operation>equals</operation>
            <value>Qualified</value>
        </criteriaItems>
        <description>auto updates checkbox when oppty created and Account has qualficiation status of QUalified</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Service Contract INcluded</fullName>
        <actions>
            <name>Service_Contract_Included_in_Project_Contract</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Service_Contract_Included__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Signed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Shortlisted Checkbox</fullName>
        <actions>
            <name>Shortlisted_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Shortlisted/Interviews</value>
        </criteriaItems>
        <description>checks off box whenever opportunity enters shortlisted stage, used mostly for reporting</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Storage Booked Date</fullName>
        <actions>
            <name>Storage_Booked_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED( Storage_Stage__c ), 
ISPICKVAL(Storage_Stage__c, &quot;Project Booked&quot;) 
|| ISPICKVAL(Storage_Stage__c, &quot;EPC Signed&quot;) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Storage%3A Solar Fields Zero Out</fullName>
        <actions>
            <name>Zero_out_Solar_Project_Likelihood</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>make the Solar project Likelihood field default to 0 when a Standalone Storage Opportunity is creating from cloning a Development type. This is to combat inaccurate reporting on Weighted Pipeline reports</description>
        <formula>RecordTypeId = &quot;012340000007n0e&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update LOI Date Signed</fullName>
        <actions>
            <name>Date_LOI_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED( StageName ) , 
TEXT(StageName) = &quot;LOI Signed&quot;, 
RecordTypeId = &quot;012340000007ka0&quot; 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Non-PD Bulk Opportunity field</fullName>
        <actions>
            <name>Update_Non_PD_Bulk_Opportunity_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CreatedBy.Profile.Name =&apos;Sys Admin w/o HR&apos;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Option Lease Execution Date</fullName>
        <actions>
            <name>Date_Option_Lease_Executed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( ISCHANGED( StageName ) , TEXT(StageName) = &quot;Option Lease Executed&quot;, RecordTypeId = &quot;012340000007ka0&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>MeetwithPMandDesigner</fullName>
        <assignedToType>owner</assignedToType>
        <description>Meet with the Project Manager and Designer assigned for the Handoff.</description>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Meet with PM and Designer</subject>
    </tasks>
</Workflow>
