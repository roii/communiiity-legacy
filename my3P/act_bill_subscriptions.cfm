<!--- GET SUBSCRIPTION SETTINGS --->
<CFQUERY NAME="SubSettingDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM subscriptionSettings
</CFQUERY>

<!--- IF TODAY IS THE BILLING DAY --->

<cfif SubSettingDetails.DayBilled EQ DateFormat(localDateTime, "d")>


	<!--- CHECK IF THE BILLING HAS NOT ALREADY BEEN COMPLETED --->
	
	<cfif DateFormat(SubSettingDetails.LastBilled, "d mmmm yyyy") NEQ DateFormat(localDateTime, "d mmmm yyyy")>


		<!--- GET ALL THE KIDS --->
	
		<cfquery name="AllKids" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT ContactID, FirstName, LastName
		FROM Contacts
		WHERE ContactType='kid'
		AND ContactStatus <> 'deleted'
		ORDER BY ContactID
		</cfquery>
	
		
		<!--- LOOP ALL KIDS AND DEBIT THEIR EDUCATION ACCOUNT THE SUBSCRIPTION AMOUNT --->
		<cfloop query="AllKids">
	
			
			<!--- INSERT THE TRANSACTION --->
				
				<cfquery name="AddTransaction" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
				INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID)
				VALUES(#AllKids.contactID#, #CreateODBCDate(localDateTime)#, 'Debit', #SubSettingDetails.MonthlyAmount#, 'myKidsBiz monthly subscription payment', 'education', 0)
				</cfquery>
			
			
				
			<!--- LOG THIS ACTION --->
			
				<cfoutput>
				<cfset logdetails = 'Add Kids Subscription Transaction - (Date: #DateFormat(localDateTime, "d-mmm-yy")# Amount: #DollarFormat(SubSettingDetails.MonthlyAmount)#  Kid: #AllKids.FirstName# #AllKids.LastName#)'>
				</cfoutput>
			
				<cfinclude template="admin/act_adminlog.cfm">
		
		
		</cfloop>
	
	
		<!--- UPDATE THE SETTINGS AND LOG THE LAST BILLED DATE --->
		<cfquery name="UpdateSubSettings" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE subscriptionSettings
		SET LastBilled=#createODBCDate(localDateTime)#
		</cfquery>
		
	
	</cfif>
	
	
	
</cfif>