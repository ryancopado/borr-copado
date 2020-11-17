<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Project_Manager_Rating_By_Field</fullName>
        <field>Project_Manager_Rating_By__c</field>
        <formula>$User.FirstName &amp; &quot; &quot;  &amp;$User.LastName</formula>
        <name>Set Project Manager Rating By Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Project_Manager_Rating_Date</fullName>
        <field>Project_Manager_Rating_Date__c</field>
        <formula>Now()</formula>
        <name>Set Project Manager Rating Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Project_Manager_Rating_Numeric</fullName>
        <field>Project_Manager_Rating_Numeric__c</field>
        <formula>Value(Text ( Project_Manager_Rating__c  ) )</formula>
        <name>Set Project Manager Rating Numeric</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Site_Supervisor_Rating_By</fullName>
        <field>Site_Supervisor_Rating_By__c</field>
        <formula>$User.FirstName &amp; &quot; &quot; &amp;  $User.LastName</formula>
        <name>Set Site Supervisor Rating By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Site_Supervisor_Rating_Date</fullName>
        <field>Site_Supervisor_Rating_Date__c</field>
        <formula>Now()</formula>
        <name>Set Site Supervisor Rating Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Site_Supervisor_Rating_Numeric</fullName>
        <field>Site_Supervisor_Rating_Numeric__c</field>
        <formula>Value (Text (  Site_Supervisor_Rating__c  ))</formula>
        <name>Set Site Supervisor Rating Numeric</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Project Manager Rating Set</fullName>
        <actions>
            <name>Set_Project_Manager_Rating_By_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Project_Manager_Rating_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Project_Manager_Rating_Numeric</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR ( 	IF ( AND ( ISPICKVAL(Project_Manager_Rating__c , &quot;1&quot;), Project_Manager_Rating_Numeric__c &lt;&gt;1 ), True , False ), 	IF ( AND ( ISPICKVAL(Project_Manager_Rating__c , &quot;2&quot;), Project_Manager_Rating_Numeric__c &lt;&gt;2 ), True , False ), 	IF ( AND ( ISPICKVAL(Project_Manager_Rating__c , &quot;3&quot;), Project_Manager_Rating_Numeric__c &lt;&gt;3 ), True , False ), 	IF ( AND ( ISPICKVAL(Project_Manager_Rating__c , &quot;4&quot;), Project_Manager_Rating_Numeric__c &lt;&gt;4 ), True , False ), 	IF ( AND ( ISPICKVAL(Project_Manager_Rating__c , &quot;5&quot;), Project_Manager_Rating_Numeric__c &lt;&gt;5 ), True , False ),  	AND (  		ISBLANK(Project_Manager_Rating_Numeric__c) , 		OR ( ISPICKVAL(Project_Manager_Rating__c , &quot;1&quot;), 			 ISPICKVAL(Project_Manager_Rating__c , &quot;2&quot;), 			 ISPICKVAL(Project_Manager_Rating__c , &quot;3&quot;), 			 ISPICKVAL(Project_Manager_Rating__c , &quot;4&quot;), 			 ISPICKVAL(Project_Manager_Rating__c , &quot;5&quot;) 		  ) 		) 	)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Site Supervisor Rating Set</fullName>
        <actions>
            <name>Set_Site_Supervisor_Rating_By</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Site_Supervisor_Rating_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Site_Supervisor_Rating_Numeric</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR ( 	IF ( AND ( ISPICKVAL( Site_Supervisor_Rating__c  , &quot;1&quot;), Site_Supervisor_Rating_Numeric__c &lt;&gt;1 ), True , False ), 	IF ( AND ( ISPICKVAL(Site_Supervisor_Rating__c , &quot;2&quot;), Site_Supervisor_Rating_Numeric__c &lt;&gt;2 ), True , False ), 	IF ( AND ( ISPICKVAL(Site_Supervisor_Rating__c , &quot;3&quot;), Site_Supervisor_Rating_Numeric__c &lt;&gt;3 ), True , False ), 	IF ( AND ( ISPICKVAL(Site_Supervisor_Rating__c , &quot;4&quot;), Site_Supervisor_Rating_Numeric__c &lt;&gt;4 ), True , False ), 	IF ( AND ( ISPICKVAL(Site_Supervisor_Rating__c , &quot;5&quot;), Site_Supervisor_Rating_Numeric__c &lt;&gt;5 ), True , False ),  	AND (  		ISBLANK(Site_Supervisor_Rating_Numeric__c) , 		OR ( ISPICKVAL(Site_Supervisor_Rating__c , &quot;1&quot;), 			 ISPICKVAL(Site_Supervisor_Rating__c , &quot;2&quot;), 			 ISPICKVAL(Site_Supervisor_Rating__c , &quot;3&quot;), 			 ISPICKVAL(Site_Supervisor_Rating__c , &quot;4&quot;), 			 ISPICKVAL(Site_Supervisor_Rating__c , &quot;5&quot;) 		  ) 		) 	)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
