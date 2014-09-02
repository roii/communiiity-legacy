<cfoutput>

<cfparam name="session.current_account" default="personal">

<cfif IsDefined("DocumentID") AND DocumentID EQ 81>
	<cfset session.current_account="personal">
<cfelseif IsDefined("DocumentID") AND DocumentID EQ 82>
	<cfset session.current_account="education">
<cfelseif IsDefined("DocumentID") AND DocumentID EQ 83>
	<cfset session.current_account="points">
</cfif>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.money_StartRow" default="1">
</cflock>

<cfif isdefined("money_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.money_StartRow = money_StartRow>
	</cflock>
</cfif>


<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.money_MaxRows" default="20">
</cflock>

<cfif isdefined("money_MaxRows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.money_MaxRows = money_MaxRows>
	</cflock>
</cfif>


<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.points_view" default="20">
</cflock>

<cfif isdefined("points_view")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.points_view = points_view>
	</cflock>
</cfif>



<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<cfparam name="url.transactions_sortby" default="transaction_date">
	<cfparam name="url.transactions_sortby_mode" default="DESC">
		
		
	<cfif session.current_account EQ 'personal'>
		
		<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
		FROM Contact_transactions, Contacts
		WHERE Contact_transactions.Transaction_Account = 'Personal'
		AND Contact_transactions.ContactID=Contacts.ContactID
		AND Contacts.ContactID=#session.UserID#
		ORDER BY #url.transactions_sortby# #url.transactions_sortby_mode#
		</cfquery>
	
	<cfelseif session.current_account EQ 'points'>
		
		<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName, Organisations.Organisation_Name, Organisations.LogoFile
		FROM Contact_transactions, Contacts, Organisations
		WHERE Contact_transactions.Transaction_Account = 'Points'
		AND Contact_transactions.ContactID=Contacts.ContactID
		AND Contacts.ContactID=#session.UserID#
		AND Contact_transactions.Transaction_SponsorID=Organisations.OrganisationID
		ORDER BY #url.transactions_sortby# #url.transactions_sortby_mode#
		</cfquery>
		
	<cfelse>
	
		<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
		FROM Contact_transactions, Contacts
		WHERE Contact_transactions.Transaction_Account = 'Education'
		AND Contact_transactions.ContactID=Contacts.ContactID
		AND Contacts.ContactID=#session.UserID#	
		ORDER BY #url.transactions_sortby# #url.transactions_sortby_mode#
		</cfquery>
	
	</cfif>		


<!--- SET THE money_endrow VALUE --->
	<cfif session.money_MaxRows NEQ 'ALL'>
	
		<cfif TransactionHistory.RecordCount GT (session.money_StartRow+session.money_MaxRows)-1>
			<cfset money_endrow = session.money_StartRow+session.money_MaxRows-1>
		<cfelse>
			<cfset money_endrow = TransactionHistory.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset money_endrow = TransactionHistory.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.money_Startrow GT session.money_Maxrows>
		<cfset prev = session.money_Startrow-session.money_Maxrows>
	
	<cfelse>
		<cfset prev = session.money_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif money_endrow LT TransactionHistory.RecordCount>
		<cfset next = (money_endrow+1)>
	
	<cfelse>
		<cfset next = session.money_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.money_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(TransactionHistory.RecordCount/session.money_Maxrows)>
		<cfset moneyNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset moneyNumberCount=1>
		
	</cfif>
	
		
	<tr>
	<td width="100%" bgcolor="White">
	
		
	
			
			<cfif TransactionHistory.RecordCount>
				
				<table width="100%" cellpadding="6" cellspacing="0" border="0">
				
				<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
				<td class="small" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;"><strong>#TransactionHistory.RecordCount#</strong> transaction records. Displaying records <strong>#session.money_StartRow# - #money_endrow#</strong></td>
				<td align="right" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_maxrows=10&money_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_maxrows=20&money_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_maxrows=50&money_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_maxrows=ALL&money_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">ALL</a></td>
				</tr>
				
				</table>
		
		
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
								
				<tr>
				<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
				</tr>
				
				<tr>
				<td width="80" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=transaction_date&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Date</a></td>
				<td width="*" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.transaction_description&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Description</a></td>
				<td style="font-size:11px;" align="center"><cfif session.current_account EQ 'points'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.Transaction_SponsorID&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Sponsor</a></cfif></td>
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
					<td width="70" align="right" class="small"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif><cfif session.current_account EQ 'points'>#INT(CurrentTotal)#<cfelse>#DollarFormat(CurrentTotal)#</cfif></span></strong></td>
					<td align="right" width="40"></td>
					</tr>
					
					<tr>
					<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
					</tr>
					
					<cfset thistotal=0>
					
					
					<cfloop query="TransactionHistory" startrow="#session.money_StartRow#" endrow="#money_endrow#">
					
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
					<td style="font-size:11px;" valign="top" align="center"><cfif session.current_account EQ 'points' AND TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'><cfif FileExists("#request.fileroot#\images\partners\#TRIM(TransactionHistory.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(TransactionHistory.LogoFile)#" border="0" title="#TRIM(TransactionHistory.Organisation_Name)#"><cfelse>#TRIM(TransactionHistory.Organisation_Name)#</cfif></cfif></td>
					<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'><cfif session.current_account EQ 'points'>#INT(TransactionHistory.Transaction_Amount)#<cfelse>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></cfif></td>
					<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'><cfif session.current_account EQ 'points'>#INT(TransactionHistory.Transaction_Amount)#<cfelse>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></cfif></td>
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
					<td width="70" align="right" style="font-size:11px;"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif><cfif session.current_account EQ 'points'>#INT(CurrentTotal)#<cfelse>#DollarFormat(CurrentTotal)#</cfif></span></strong></td>
					<td align="right" width="40"></td>
					</tr>
					
					<tr>
					<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1">
					
					<div align="right" style="font-size:11px;"><cfif session.money_Startrow GT session.money_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_Startrow=#prev#&documentID=#DocumentID#">Prev Page</a> | </cfif><cfif money_endrow LT TransactionHistory.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_Startrow=#next#&documentID=#DocumentID#">Next Page</a> &gt;</cfif><cfif session.money_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#moneyNumberCount#" index="NumberCount"><cfset thisStartRow=(session.money_Maxrows*NumberCount-session.money_Maxrows+1)><cfif thisStartRow EQ session.money_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&money_Startrow=#thisStartRow#&documentID=#DocumentID#"></cfif>#NumberCount#<cfif thisStartRow EQ session.money_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ moneyNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


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