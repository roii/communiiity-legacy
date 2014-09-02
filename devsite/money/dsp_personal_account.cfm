<cfoutput>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.personalAcc_StartRow" default="1">
</cflock>

<cfif isdefined("personalAcc_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.personalAcc_StartRow = personalAcc_StartRow>
	</cflock>
</cfif>


<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.personalAcc_MaxRows" default="20">
</cflock>

<cfif isdefined("personalAcc_MaxRows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.personalAcc_MaxRows = personalAcc_MaxRows>
	</cflock>
</cfif>


<cfparam name="url.transactions_sortby" default="transaction_date">
<cfparam name="url.transactions_sortby_mode" default="DESC">


<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account = 'Personal'
AND Contact_transactions.ContactID=Contacts.ContactID
AND Contacts.ContactID=#session.UserID#
ORDER BY #url.transactions_sortby# #url.transactions_sortby_mode#
</cfquery>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<!--- SET THE money_endrow VALUE --->
	<cfif session.personalAcc_MaxRows NEQ 'ALL'>
	
		<cfif TransactionHistory.RecordCount GT (session.personalAcc_StartRow + session.personalAcc_MaxRows)-1>
			<cfset money_endrow = session.personalAcc_StartRow + session.personalAcc_MaxRows-1>
		<cfelse>
			<cfset money_endrow = TransactionHistory.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset money_endrow = TransactionHistory.RecordCount>
	
	</cfif>
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.personalAcc_StartRow GT session.personalAcc_MaxRows>
		<cfset prev = session.personalAcc_StartRow - session.personalAcc_MaxRows>
	
	<cfelse>
		<cfset prev = session.personalAcc_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif money_endrow LT TransactionHistory.RecordCount>
		<cfset next = (money_endrow + 1)>
	
	<cfelse>
		<cfset next = session.personalAcc_StartRow>
	
	</cfif>
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.personalAcc_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(TransactionHistory.RecordCount / session.personalAcc_MaxRows)>
		<cfset moneyNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset moneyNumberCount=1>
		
	</cfif>
	
		
	<tr>
	<td width="100%" bgcolor="White">
	
		
	
			
		<cfif TransactionHistory.RecordCount>
			
			<table width="100%" cellpadding="6" cellspacing="0" border="0">
			
			<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
			<td class="small" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;"><strong>#TransactionHistory.RecordCount#</strong> transaction records. Displaying records <strong>#session.personalAcc_StartRow# - #money_endrow#</strong></td>
			<td align="right" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_MaxRows=10&personalAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_MaxRows=20&personalAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_MaxRows=50&personalAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_MaxRows=ALL&personalAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">ALL</a></td>
			</tr>
			
			</table>
	
	
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
							
			<tr>
			<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
			</tr>
			
			<tr>
			<td width="80" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=transaction_date&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Date</a></td>
			<td width="*" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.transaction_description&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Description</a></td>
			<td style="font-size:11px;" align="center"></td>
			<td width="50" align="right" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.transaction_amount&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">In</a></td>
			<td width="50" align="right" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.transaction_amount&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Out</a></td>
			<td width="70" align="right" style="font-size:11px;">Balance</td>
			<td width="40"></td>
			</tr>
			
			<tr>
			<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
			</tr>
			
			
				<cfset CurrentTotal=0>
		
		
				<cfloop query="TransactionHistory">
				
				
				<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
					<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
						<cfset CurrentTotal=(CurrentTotal - TransactionHistory.Transaction_amount)>
					<cfelse>
						<cfset CurrentTotal=(CurrentTotal + TransactionHistory.Transaction_amount)>
					</cfif>
				</cfif>
				
				
				</cfloop>
				
				
				<tr>
				<td colspan="5" class="small" style="color:###TRIM(AllSettings.TextColour)#;"><strong>Current balance:</strong></td>
				<td width="70" align="right" class="small"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif>#DollarFormat(CurrentTotal)#</span></strong></td>
				<td align="right" width="40"></td>
				</tr>
				
				<tr>
				<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
				</tr>
				
				<cfset thistotal=0>
				
				
				<cfloop query="TransactionHistory" startrow="#session.personalAcc_StartRow#" endrow="#money_endrow#">
				
				<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
					<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
						<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
					<cfelse>
						<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
					</cfif>
				</cfif>
				
				
				
				<tr>
				<td width="80" style="font-size:11px;" valign="top">#DateFormat(TransactionHistory.Transaction_Date, "d-mmm-yy")#<br>#TimeFormat(TransactionHistory.Transaction_Date, "HH:MM TT")#</td>
				<td width="*" style="font-size:11px;" valign="top">#TRIM(TransactionHistory.Transaction_Description)#</td>
				<td style="font-size:11px;" valign="top" align="center"></td>
				<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></td>
				<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></td>
				<td width="70" align="right" style="font-size:11px;" valign="top"></td>
				<td></td>
				</tr>
				
				<cfif currentrow NEQ money_endrow>
					
					<tr>
					<td colspan="7"><hr width="100%" color="e2e2e2" size="1"></td>
					</tr>
				
				<cfelse>
				
					<tr>
					<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
					</tr>
				
				</cfif>
				
				</cfloop>
				
				<tr>
				<td colspan="5" style="font-size:11px;color:###TRIM(AllSettings.TextColour)#;"><strong>Current balance:</strong></td>
				<td width="70" align="right" style="font-size:11px;"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif>#DollarFormat(CurrentTotal)#</span></strong></td>
				<td align="right" width="40"></td>
				</tr>
				
				<tr>
				<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1">
				
				<div align="right" style="font-size:11px;"><cfif session.personalAcc_StartRow GT session.personalAcc_MaxRows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_StartRow=#prev#&documentID=#DocumentID#">Prev Page</a> | </cfif><cfif money_endrow LT TransactionHistory.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_StartRow=#next#&documentID=#DocumentID#">Next Page</a> &gt;</cfif><cfif session.personalAcc_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#moneyNumberCount#" index="NumberCount"><cfset thisStartRow=(session.personalAcc_MaxRows*NumberCount-session.personalAcc_MaxRows+1)><cfif thisStartRow EQ session.personalAcc_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&personalAcc_StartRow=#thisStartRow#&documentID=#DocumentID#"></cfif>#NumberCount#<cfif thisStartRow EQ session.personalAcc_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ moneyNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


				</td>
				</tr>
			
				</table>
			
	<cfelse>
		
		<table width="100%" cellpadding="6" cellspacing="0" border="0">
			
		<tr bgcolor="##e2e2e2">
		<td class="small" style="color:###TRIM(AllSettings.DkTextColor)#;">No transactions were found for this account</td>
		</tr>
		
		</table>
		
	</cfif>
		
			
	
	

	</td>
	</tr>


	</table><br>
	
</td>
</tr>
	
</table>

	
</cfoutput>