


<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.points_view" default="list">
</cflock>

<cfif isdefined("points_view")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.points_view = points_view>
	</cflock>
</cfif>



<cfif session.points_view EQ 'list'>

	<cfoutput>

	<cflock Type="exclusive" scope="session" timeout="10">
		<cfparam name="session.PointsAcc_StartRow" default="1">
	</cflock>
	
	<cfif isdefined("PointsAcc_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.PointsAcc_StartRow = PointsAcc_StartRow>
		</cflock>
	</cfif>
	
	
	<cflock Type="exclusive" scope="session" timeout="10">	
		<cfparam name="session.PointsAcc_MaxRows" default="20">
	</cflock>
	
	<cfif isdefined("PointsAcc_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.PointsAcc_MaxRows = PointsAcc_MaxRows>
		</cflock>
	</cfif>
	
	
	<cfparam name="url.transactions_sortby" default="transaction_date">
	<cfparam name="url.transactions_sortby_mode" default="DESC">
	
	
	<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contact_transactions.*, Organisations.Organisation_Name, Organisations.LogoFile
	FROM Contact_transactions, Organisations
	WHERE Contact_transactions.Transaction_Account = 'Points'
	AND Contact_transactions.ContactID=#session.UserID#
	AND Contact_transactions.Transaction_SponsorID=Organisations.OrganisationID
	ORDER BY #url.transactions_sortby# #url.transactions_sortby_mode#
	</cfquery>
	
	
	<table border="0" cellpadding="0" cellspacing="2" width="100%">
	
	<tr>
	<td>
	
		<table cellpadding="0" cellspacing="0" border="0" style="padding-bottom:10px;">
		
		<tr>
		<td>View:&nbsp; <strong><span style="color:##444444;">Transaction List &nbsp;|&nbsp; </span><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&points_view=partner&documentID=#documentID#">Points from Partner's</a></strong></td>
		</tr>
		
		</table>
		
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<!--- SET THE money_endrow VALUE --->
		<cfif session.PointsAcc_MaxRows NEQ 'ALL'>
		
			<cfif TransactionHistory.RecordCount GT (session.PointsAcc_StartRow + session.PointsAcc_MaxRows)-1>
				<cfset money_endrow = session.PointsAcc_StartRow + session.PointsAcc_MaxRows-1>
			<cfelse>
				<cfset money_endrow = TransactionHistory.RecordCount>
			</cfif>
		
		<cfelse>
			<cfset money_endrow = TransactionHistory.RecordCount>
		
		</cfif>
		
		
		<!--- SET THE PREV VALUE --->
		<cfif session.PointsAcc_StartRow GT session.PointsAcc_MaxRows>
			<cfset prev = session.PointsAcc_StartRow - session.PointsAcc_MaxRows>
		
		<cfelse>
			<cfset prev = session.PointsAcc_StartRow>
		
		</cfif>
		
		
		
		<!--- SET THE NEXT VALUE --->
		<cfif money_endrow LT TransactionHistory.RecordCount>
			<cfset next = (money_endrow + 1)>
		
		<cfelse>
			<cfset next = session.PointsAcc_StartRow>
		
		</cfif>
		
		
		<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
		<cfif session.PointsAcc_MaxRows NEQ 'ALL'>
		
			<cfset NumberCount=(TransactionHistory.RecordCount / session.PointsAcc_MaxRows)>
			<cfset moneyNumberCount=Ceiling(NumberCount)>
		
		<cfelse>
		
			<cfset moneyNumberCount=1>
			
		</cfif>
		
			
		<tr>
		<td width="100%" bgcolor="White">
		
			
		
				
			<cfif TransactionHistory.RecordCount>
				
				<table width="100%" cellpadding="6" cellspacing="0" border="0">
				
				<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
				<td class="small" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;"><strong>#TransactionHistory.RecordCount#</strong> transaction records. Displaying records <strong>#session.PointsAcc_StartRow# - #money_endrow#</strong></td>
				<td align="right" style="color:###TRIM(AllSettings.DkBoxTextColour)#;font-size:11px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_MaxRows=10&PointsAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_MaxRows=20&PointsAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_MaxRows=50&PointsAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_MaxRows=ALL&PointsAcc_StartRow=1&documentID=#DocumentID#" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">ALL</a></td>
				</tr>
				
				</table>
		
		
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
								
				<tr>
				<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
				</tr>
				
				<tr>
				<td width="80" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=transaction_date&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Date</a></td>
				<td width="*" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.transaction_description&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Description</a></td>
				<td style="font-size:11px;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_sortby=Contact_transactions.Transaction_SponsorID&transactions_sortby_mode=<cfif url.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&documentID=#DocumentID#" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Partner</a></td>
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
					<td width="70" align="right" class="small"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif>#INT(CurrentTotal)#</span></strong></td>
					<td align="right" width="40"></td>
					</tr>
					
					<tr>
					<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1"></td>
					</tr>
					
					<cfset thistotal=0>
					
					
					<cfloop query="TransactionHistory" startrow="#session.PointsAcc_StartRow#" endrow="#money_endrow#">
					
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
					<td style="font-size:11px;" valign="top" align="center"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'><cfif FileExists("#request.fileroot#\images\partners\#TRIM(TransactionHistory.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(TransactionHistory.LogoFile)#" border="0" title="#TRIM(TransactionHistory.Organisation_Name)#"><cfelse>#TRIM(TransactionHistory.Organisation_Name)#</cfif></cfif></td>
					<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'>#INT(TransactionHistory.Transaction_Amount)#</cfif></td>
					<td width="50" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>#INT(TransactionHistory.Transaction_Amount)#</cfif></td>
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
					<td width="70" align="right" style="font-size:11px;"><strong><cfif CurrentTotal LT 0><span style="color:###TRIM(AllSettings.BoxColour)#;">- <cfelse><span  style="color:###TRIM(AllSettings.TextColour)#;"></cfif>#INT(CurrentTotal)#</span></strong></td>
					<td align="right" width="40"></td>
					</tr>
					
					<tr>
					<td colspan="7"><hr width="100%" color="###TRIM(AllSettings.TextColour)#" size="1">
					
					<div align="right" style="font-size:11px;"><cfif session.PointsAcc_StartRow GT session.PointsAcc_MaxRows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_StartRow=#prev#&documentID=#DocumentID#">Prev Page</a> | </cfif><cfif money_endrow LT TransactionHistory.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_StartRow=#next#&documentID=#DocumentID#">Next Page</a> &gt;</cfif><cfif session.PointsAcc_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#moneyNumberCount#" index="NumberCount"><cfset thisStartRow=(session.PointsAcc_MaxRows*NumberCount-session.PointsAcc_MaxRows+1)><cfif thisStartRow EQ session.PointsAcc_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&PointsAcc_StartRow=#thisStartRow#&documentID=#DocumentID#"></cfif>#NumberCount#<cfif thisStartRow EQ session.PointsAcc_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ moneyNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>
	
	
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
	
	
<cfelse>

	<cfoutput>
	
	<cfparam name="url.transactions_sortby" default="Transaction_SponsorID">
	<cfparam name="url.transactions_sortby_mode" default="DESC">
	
	
	<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Contact_transactions.Transaction_Amount) AS TotalPoints, Organisations.Organisation_Name, Organisations.LogoFile
	FROM Contact_transactions, Organisations
	WHERE Contact_transactions.Transaction_Account = 'Points'
	AND Contact_transactions.ContactID=#session.UserID#
	AND Contact_transactions.Transaction_Type='Credit'
	AND Contact_transactions.Transaction_SponsorID=Organisations.OrganisationID
	AND Organisations.Organisation_Name <> 'Self'
	GROUP BY Organisations.Organisation_Name, Organisations.LogoFile
	ORDER BY Organisations.Organisation_Name
	</cfquery>
	
	

	<table border="0" cellpadding="0" cellspacing="2" width="100%">
	
	<tr>
	<td>
	
		<table cellpadding="0" cellspacing="0" border="0" style="padding-bottom:10px;">
				
		<tr>
		<td>View:&nbsp; <strong><span style="color:##444444;">Points from Partner's</span> &nbsp;|&nbsp; <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&points_view=list&documentID=#documentID#">Transaction List</a></strong></td>
		</tr>
		
		
		</table>
		
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5"  border="0"></td>
		</tr>
		
		<tr>
		<td>
		
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
						
			<cfset partners_total = 0>
			
			<tr>
			<cfloop query="TransactionHistory">
			
			<cfif IsDefined("TransactionHistory.TotalPoints") AND IsNumeric("#TransactionHistory.TotalPoints#")>
				<cfset partners_total = partners_total + TransactionHistory.TotalPoints>
			</cfif>
			
			
			<td width="30%" align="center" height="100%">
			
				<table width="100%" height="100%" cellpadding="5" cellspacing="0" style="border:solid 1px ##b4b4b4;">
				
				<tr>
				<td width="100%" height="100%">
					
					<table width="100%" height="100%" cellpadding="0" cellspacing="0">
					
					<tr>
					<td style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;" align="center" height="100%" valign="middle"><cfif FileExists("#request.fileroot#\images\partners\#TRIM(TransactionHistory.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(TransactionHistory.LogoFile)#" border="0" title="#TRIM(TransactionHistory.Organisation_Name)#"><cfelse>#TRIM(TransactionHistory.Organisation_Name)#</cfif></td>
					</tr>
					
					<tr>
					<td height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5"  border="0"></td>
					</tr>
					
					<tr>
					<td style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;" align="center" valign="bottom">Points Earned:&nbsp; <strong>#INT(TransactionHistory.TotalPoints)#</strong></td>
					</tr>
					
					</table>				
				
				</td>
				</tr>
				
				</table>
			
			
			</td>
			<td width="20"></td>
			
			<cfif TransactionHistory.CurrentRow MOD 3 IS 0>
			</tr>
			
			<tr>
			<td colspan="5"><br></td>
			</tr>
			
		 	<tr>
		</cfif>
			
			</cfloop>
			</tr>
			
			</table>
			
			
		</td>
		</tr>
			
		</table><br>
		
		
	</td>
	</tr>
		
	</table>
	
	</cfoutput>
	
</cfif>



	
