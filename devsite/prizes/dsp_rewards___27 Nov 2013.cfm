<cfoutput>

<cfquery name="rewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE reward=1
AND deleted=0
AND Display=1
AND (country=0<cfif session.UserIsAuthenticated EQ 'Yes'> OR country=#session.User_CountryID#</cfif>)
ORDER BY pointsvalue
</cfquery>



<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.ContactID=Contacts.ContactID

<cfif session.UserIsAuthenticated EQ 'Yes'>
AND Contacts.ContactID=#session.UserID#
</cfif>
</cfquery>

<cfset thistotal=0>

<cfloop query="TransactionHistory">


<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
	<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
		<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
	<cfelse>
		<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
	</cfif>
</cfif>

</cfloop>


<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">
<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=50" style="color:###TRIM(AllSettings.BoxColour)#;">Click here</a> to see how to earn points.<cfif session.UserIsAuthenticated EQ 'Yes'><br><br>
Your current point balance is: <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#thistotal# pts</strong></span></cfif><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="4"  border="0">

	<hr width="100%" size="1" color="##b4b4b4">



	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="90" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1"  border="0"></td>
	<td width="20" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
	<td width="100%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="300" height="1"  border="0"></td>
	</tr>
	
	<cfif rewards.RecordCount>
	
		
		<cfloop query="rewards">
		
	
		<tr bgcolor="white">
		<td>
		
			<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
			<tr>
			<td align="center" valign="center">			
			<cfif FileExists("#request.fileroot#\images\prize\#TRIM(rewards.image)#")>
				<img src="#request.imageroot#/prize/#TRIM(rewards.image)#" border="0" width="80" height="60">
			<cfelse>
				<img src="#request.imageroot#/prize_placeholder.gif" width="80" height="60" border="0">
			</cfif>
			</td>
			</tr>
			
			</table>
		
		
		</td>
		<td valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" alt="" border="0"></td>
		<td valign="top">
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><strong>#TRIM(rewards.description)#</strong></span><br>
			Points Value: <strong>#rewards.pointsvalue#</strong></td>
			<td valign="top" align="right"><cfif session.UserIsAuthenticated EQ 'Yes'><cfif thistotal GT rewards.pointsvalue><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=91&RewardID=#rewards.PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;">Buy Now!</a><cfelse>You need more points<br>to get this reward</cfif></cfif></td>
			</tr>
			
			</table>
		
		
		
		
		<!---<hr width="100%" size="1" color="##b4b4b4">
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
			<tr>
				<td>The Request Reward system is currently unavailable. Please read the <a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=100">site announcements</a> page for more details.</td>
			</tr>
			
			</table>--->
		
		
		</td>
		</tr>
		
		<tr>
		<td colspan="3">
		<hr width="100%" size="1" color="##b4b4b4">
		</td>
		</tr>
		</cfloop>
	
	</cfif>
	
	</table>
	
</td>
</tr>

</table>


</cfoutput>