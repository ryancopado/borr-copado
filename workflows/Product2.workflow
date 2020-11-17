<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>GL_Accounts_Needed_Notification</fullName>
        <description>GL Accounts Needed Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Product_Approved</template>
    </alerts>
    <alerts>
        <fullName>Install_Manuals_field_updated</fullName>
        <description>Install Manuals field updated</description>
        <protected>false</protected>
        <recipients>
            <recipient>Operations_Engineering_Email_Alert</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>Principal_Structural_Engineer</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>ProfessionalStructuralEngineer</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Install_Manual_updated</template>
    </alerts>
    <alerts>
        <fullName>Inverter_Price_Change_alert</fullName>
        <description>Inverter Price Change alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>jaskins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jhuffine@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Inverter_Price_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Product_Cost_Edited</fullName>
        <description>Product Cost Edited</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Cost_Edited</template>
    </alerts>
    <alerts>
        <fullName>Product_Created</fullName>
        <description>Product Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jhuffine@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>logren@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>smeredith@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Created</template>
    </alerts>
    <alerts>
        <fullName>Product_Edited</fullName>
        <description>Product Edited</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>logren@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>smeredith@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Edited</template>
    </alerts>
    <alerts>
        <fullName>Product_Edited_Editor</fullName>
        <description>Product Edited - Editor</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Edited_Editor</template>
    </alerts>
    <alerts>
        <fullName>Product_Edited_Editor2</fullName>
        <description>Product Edited- Editor</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Edited_Editor</template>
    </alerts>
    <alerts>
        <fullName>Product_Edited_not_CA_or_BH</fullName>
        <description>Product Edited not CA or BH</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Edited</template>
    </alerts>
    <alerts>
        <fullName>Product_Update_Notification_Other</fullName>
        <description>Product Update Notification- Other</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Customer_Satisfaction/Prod_Update_Notification2</template>
    </alerts>
    <alerts>
        <fullName>Product_Update_Notification_mod_inverter</fullName>
        <description>Product Update Notification- mod and inverters</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Customer_Satisfaction/Prod_Update_Notification2</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Reason_for_modification</fullName>
        <field>Reason_for_modification__c</field>
        <name>Clear Reason for modification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Convert_Inches_to_MM</fullName>
        <field>Lead_Length_MM__c</field>
        <formula>Lead_Length_Inches_New__c * 25.4</formula>
        <name>Convert Inches to MM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Convert_MM_to_Inches</fullName>
        <field>Lead_Length_Inches_New__c</field>
        <formula>Lead_Length_MM__c * 0.0393701</formula>
        <name>Convert MM to Inches</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inventory_Product_Checked</fullName>
        <field>AcctSeed__Inventory_Product__c</field>
        <literalValue>1</literalValue>
        <name>Inventory Product Checked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inventory_Product_Purchased</fullName>
        <field>AcctSeed__Inventory_Type__c</field>
        <literalValue>Purchased</literalValue>
        <name>Inventory Product Purchased</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_Cost</fullName>
        <field>Prior_Unit_Cost__c</field>
        <formula>PRIORVALUE( Cost__c )</formula>
        <name>Prior Cost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Created</fullName>
        <field>Status__c</field>
        <literalValue>Not in Use</literalValue>
        <name>Product Created</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unit_Cost_Update</fullName>
        <field>AcctSeed__Unit_Cost__c</field>
        <formula>1.00</formula>
        <name>Unit Cost Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Past_Modification</fullName>
        <field>Past_modifications__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; + LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot;+ Reason_for_modification__c + &quot;,&quot; + BR() + 
BR() 
+ PRIORVALUE( Past_modifications__c )</formula>
        <name>Update Past Modification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Key</fullName>
        <description>Prevent duplicate in Product Name field</description>
        <field>Unique_Product_Name__c</field>
        <formula>Name</formula>
        <name>Update Record Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>pending_approval</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>pending approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Convert Inches to MM</fullName>
        <actions>
            <name>Convert_Inches_to_MM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(  Lead_Length_Inches_New__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Convert MM to Inches</fullName>
        <actions>
            <name>Convert_MM_to_Inches</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(  Lead_Length_MM__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Edit Product</fullName>
        <actions>
            <name>Product_Edited</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( $User.LastName &lt;&gt; &apos;Hibberd&apos;,$User.LastName &lt;&gt; &apos;Orozco&apos;, ISCHANGED( Status__c ), NOT( ISPICKVAL(Status__c,&quot;5- O&amp;M In Use&quot; )  || ISPICKVAL(Status__c,&quot;6- O&amp;M Not In Use&quot; )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Install Manual update</fullName>
        <actions>
            <name>Install_Manuals_field_updated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify Structural Engineering and Operations Engineering teams when the Install Manual field is updated.</description>
        <formula>ISCHANGED( Install_Manual__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Inventory Product Active</fullName>
        <actions>
            <name>GL_Accounts_Needed_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Inventory_Product_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Inventory_Product_Purchased</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Unit_Cost_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Product2.Status__c</field>
            <operation>equals</operation>
            <value>Approved for Spec,Purchase Order Only,Approved For Sale</value>
        </criteriaItems>
        <description>Checked when RG approves product</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Inverter Price Changes</fullName>
        <actions>
            <name>Inverter_Price_Change_alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Prior_Cost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>notification to Pricing team that the Cost on Inverter Product has changed</description>
        <formula>AND(  RecordTypeId = &quot;01230000000944Y&quot;, ISCHANGED(  Cost__c  ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Product</fullName>
        <actions>
            <name>Product_Created</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Product_Created</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND( $User.LastName &lt;&gt; &apos;Hibberd&apos;, $User.LastName &lt;&gt; &apos;Orozco&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Product Non O%26M Alert</fullName>
        <actions>
            <name>Product_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  $User.LastName &lt;&gt; &apos;Hibberd&apos;,  $User.LastName &lt;&gt; &apos;Orozco&apos;, NOT(  ISPICKVAL(Status__c,&quot;5- O&amp;M In Use&quot; ) || ISPICKVAL(Status__c,&quot;6- O&amp;M Not In Use&quot; ))  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Product Non O%26M Field Update</fullName>
        <actions>
            <name>Product_Created</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  $User.LastName &lt;&gt; &apos;Hibberd&apos;,  $User.LastName &lt;&gt; &apos;Orozco&apos;, NOT(  ISPICKVAL(Status__c,&quot;5- O&amp;M In Use&quot; ) || ISPICKVAL(Status__c,&quot;6- O&amp;M Not In Use&quot; ))  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product Update Email Notification</fullName>
        <actions>
            <name>Product_Update_Notification_mod_inverter</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>bhibberd@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>etam@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>pcanning@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Family</field>
            <operation>notEqual</operation>
            <value>Solar Modules,Inverters</value>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Status__c</field>
            <operation>notEqual</operation>
            <value>5- O&amp;M In Use,6- O&amp;M Not In Use</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Product Update Email Notification-Other Products</fullName>
        <actions>
            <name>Product_Update_Notification_Other</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>etam@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>bhibberd@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>pcanning@borregosolar.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Family</field>
            <operation>notEqual</operation>
            <value>Solar Modules,Inverters</value>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Status__c</field>
            <operation>notEqual</operation>
            <value>5- O&amp;M In Use,6- O&amp;M Not In Use</value>
        </criteriaItems>
        <description>not inverters or modules</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Past Modification</fullName>
        <actions>
            <name>Clear_Reason_for_modification</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Past_Modification</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Reason_for_modification__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Product Name Record Key</fullName>
        <actions>
            <name>Update_Record_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Product2.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Product</value>
        </criteriaItems>
        <description>Rule to prevent duplicate records on Product Name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
