<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Quote_Accepted_by_Client_Notification</fullName>
        <description>Quote Accepted by Client Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>rallen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Quote_Email_Templates/Quote_Accepted_by_Client_Notification</template>
    </alerts>
</Workflow>
