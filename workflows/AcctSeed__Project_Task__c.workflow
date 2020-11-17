<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Budgeted_Expense_Changed</fullName>
        <description>Budgeted Expense Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jhetzel@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Budgeted_Expense_Changed_Line_Item</template>
    </alerts>
    <alerts>
        <fullName>Budgeted_Expense_Changed_Accounting</fullName>
        <description>Budgeted Expense Changed - Accounting</description>
        <protected>false</protected>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Budgeted_Expense_Changed_Line_Item</template>
    </alerts>
    <alerts>
        <fullName>Budgeted_Expense_Changed_Accounting_NorCal_ROD</fullName>
        <description>Budgeted Expense Changed - NorCal ROD</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Operations_NorCal_Project_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Budgeted_Expense_Changed_Line_Item</template>
    </alerts>
    <alerts>
        <fullName>Budgeted_Expense_Changed_Accounting_SoCal_ROD</fullName>
        <description>Budgeted Expense Changed - SoCal ROD</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Operations_SoCal_Project_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Budgeted_Expense_Changed_Line_Item</template>
    </alerts>
    <fieldUpdates>
        <fullName>Active_Budget_Changed</fullName>
        <description>Populates changes to the Active Budget (old and new values) on the Line Item</description>
        <field>Active_Budget_History__c</field>
        <formula>IF( 
ISCHANGED(Active_Budget__c), TEXT(TODAY())+ &quot; &quot; 
+ LEFT($User.Alias,2) + &quot;: New Budget: $&quot; + TEXT(Active_Budget__c) + &quot;, Old Budget: $&quot; + TEXT(PRIORVALUE( Active_Budget__c )) + BR() + Active_Budget_History__c , 
IF( OR( ISCHANGED(Sales_Budget__c), ISCHANGED(PM_Budget__c)), BR() + Active_Budget_History__c, 
NULL))</formula>
        <name>Active Budget Changed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Budgeted_Expense_Update</fullName>
        <field>AcctSeed__Budgeted_Amount__c</field>
        <formula>IF(AcctSeed__Project__r.RecordType.Name= &quot;O&amp;M Project&quot;, Requisition_Costs_to_Date__c,

IF(AND( 
AcctSeed__Project__r.PM_Lock__c = FALSE, AcctSeed__Project__r.Sales_Budget_Locked__c = FALSE
), Sales_Budget__c, 
IF(AND(
AcctSeed__Project__r.PM_Lock__c = TRUE,AcctSeed__Project__r.Sales_Budget_Locked__c= TRUE 
), Active_Budget__c, 
IF(AND(
AcctSeed__Project__r.PM_Lock__c = TRUE,AcctSeed__Project__r.Sales_Budget_Locked__c= FALSE 
), Active_Budget__c,
IF(AND(
AcctSeed__Project__r.PM_Lock__c = FALSE,AcctSeed__Project__r.Sales_Budget_Locked__c= TRUE 
), PM_Budget__c,
IF(( AcctSeed__Project__r.PM_Lock__c = FALSE ), PM_Budget__c, 
IF( (AcctSeed__Project__r.PM_Lock__c = TRUE), Active_Budget__c, 

NULL)))))))</formula>
        <name>Budgeted Expense Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Duplicate_Line_Item_Test</fullName>
        <field>Duplicate_Line_Item_Test__c</field>
        <formula>Name + &quot;-&quot; + Cost_Code__c + &quot;-&quot; + AcctSeed__Project__c</formula>
        <name>Duplicate Line Item Test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Line_Item_Name</fullName>
        <field>Name</field>
        <formula>Cost_Code__r.Name</formula>
        <name>Line Item Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Non_PO_Costs</fullName>
        <field>Non_PO_Costs_Currency__c</field>
        <formula>IF( ISBLANK( Non_PO_Costs_RollUp__c ) , 0, Non_PO_Costs_RollUp__c )  +
IF( ISBLANK( Roll_Up_Journal_Entries__c ) , 0,Roll_Up_Journal_Entries__c )- 
IF( ISBLANK(Roll_Up_Cash_Receipts__c) , 0, Roll_Up_Cash_Receipts__c)</formula>
        <name>Non PO Costs</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalculate</fullName>
        <field>Recalculate__c</field>
        <literalValue>0</literalValue>
        <name>Recalculate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Active_Budget</fullName>
        <field>Active_Budget__c</field>
        <formula>Sales_Budget__c</formula>
        <name>Sales - Active Budget</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_PM_Budget</fullName>
        <field>PM_Budget__c</field>
        <formula>Sales_Budget__c</formula>
        <name>Sales - PM Budget</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Line_Item_Note_History</fullName>
        <field>Line_Item_Notes__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; + LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot;+  Notes__c  + BR() + 
BR() 
+ PRIORVALUE( Notes__c )</formula>
        <name>Update Line Item Note History</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Budgeted Expense Email Alert</fullName>
        <actions>
            <name>Budgeted_Expense_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( ISPICKVAL( AcctSeed__Project__r.WIP_Status__c , &quot;On WIP&quot;), OR( AND(ISCHANGED(Active_Budget__c), AcctSeed__Project__r.PM_Lock__c = TRUE,  OR( Active_Budget__c &gt;= PRIORVALUE( Active_Budget__c ) + 3000, Active_Budget__c &lt;= PRIORVALUE( Active_Budget__c ) - 3000)), AND(ISCHANGED(PM_Budget__c), AcctSeed__Project__r.PM_Lock__c = FALSE,  OR( PM_Budget__c &gt;= PRIORVALUE( PM_Budget__c ) + 3000, PM_Budget__c &lt;= PRIORVALUE( PM_Budget__c ) - 3000))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Budgeted Expense Update</fullName>
        <actions>
            <name>Active_Budget_Changed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Budgeted_Expense_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Project_Task__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Budget Line Item</value>
        </criteriaItems>
        <description>Updates the Budgeted Expense with the current Budget in use. Added functions to populate prior Active Budget value and datestamp the change of the Active Budget.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Line Item Name</fullName>
        <actions>
            <name>Line_Item_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(    RecordTypeId = &quot;012800000007gu8&quot;,   NOT(     OR(       ISBLANK(Cost_Code__c),       Cost_Code__r.Id = &quot;a0H8000000I6Hub&quot;,       Cost_Code__r.Id = &quot;a0H8000000Ea9tt&quot;     )   ) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Lock OH%2FIndirects</fullName>
        <actions>
            <name>Sales_PM_Budget</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED( Sales_Budget__c ), 
RecordTypeId = &quot;012800000007gu8&quot;, 
Name = &quot;OH/Indirect Costs&quot;, 
OR( TEXT ( PRIORVALUE( Sales_Budget__c ) ) = NULL, PRIORVALUE( Sales_Budget__c ) =0 ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Non PO Costs</fullName>
        <actions>
            <name>Non_PO_Costs</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculate and set the value of field Non PO Costs (Non_PO_Costs_Currency__c) if any of the fields in the calculation have changed.</description>
        <formula>ISNEW() || ISCHANGED( Non_PO_Costs_RollUp__c ) || ISCHANGED( Roll_Up_Cash_Receipts__c )  ||  ISCHANGED( Roll_Up_Journal_Entries__c ) || Recalculate__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sales Budget Saved</fullName>
        <actions>
            <name>Sales_Active_Budget</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sales_PM_Budget</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Once Sales Budget is entered the value is copied to PM Budget</description>
        <formula>AND(  ISCHANGED( Sales_Budget__c ),  RecordTypeId = &quot;012800000007gu8&quot;, OR( Name = &quot;OH/Indirect Costs&quot;, Name = &quot;Internal Engineering&quot; ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Line Item Note History</fullName>
        <actions>
            <name>Update_Line_Item_Note_History</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Notes__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
