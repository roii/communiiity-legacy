<cfoutput>


<cfquery name="prizepoolQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT prize_pool.*
FROM Prize_Watchlist, prize_pool
WHERE Prize_Watchlist.ContactID=#session.UserID#
AND Prize_Watchlist.PrizeID=prize_pool.PrizePoolID
AND prize_pool.deleted=0
ORDER BY prize_pool.draw_date
</cfquery>



<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">


	<hr width="100%" size="1" color="##b4b4b4">


	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="120" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"></td>
	<td width="20" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
	<td width="100%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="300" height="1"  border="0"></td>
	</tr>
	
	<cfif prizepoolQ.RecordCount>
	
		
		<cfloop query="prizepoolQ">
		
		
		<cfset this_start = prizepoolQ.start_date>
		<cfset this_end = prizepoolQ.draw_date>
	
		<tr bgcolor="white">
		<td>
		
			<table width="120" height="120" cellpadding="10" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
			<tr>
			<td align="center" valign="center">			
			<cfif FileExists("#request.fileroot#\images\prize\#TRIM(prizepoolQ.image)#")>
				<img src="#request.imageroot#/prize/#TRIM(prizepoolQ.image)#" border="0">
			<cfelse>
				<img src="#request.imageroot#/prize_placeholder.gif" width="100" height="100" border="0">
			</cfif>
			</td>
			</tr>
			
			</table>
		
		
		</td>
		<td valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" alt="" border="0"></td>
		<td valign="top">
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><strong>#TRIM(prizepoolQ.name)#</strong><br>
		#TRIM(prizepoolQ.description)#</span></td>
			<td valign="top" align="right"><a href="#request.webroot#/prizes/act_delete_watchlist.cfm?PrizePoolID=#prizepoolQ.PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;">(-) Remove</a></td>
			</tr>
			
			</table>
		
		
		
		
		<hr width="100%" size="1" color="##b4b4b4">
		
			<table width="250" cellpadding="0" cellspacing="0" border="0">
			
			<cfif prizepoolQ.status EQ 1 AND prizepoolQ.winner NEQ ''>
			
				<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT FirstName, LastName
				FROM Contacts
				WHERE ContactID=#prizepoolQ.winner#
				</cfquery>
				
				
				<tr>
				<td width="100">Winner:</td>
				<td width="150" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(WinnerDetails.FirstName)# #TRIM(WinnerDetails.LastName)#</strong></td>
				</tr>
				
			</cfif>
			
			
			<tr>
			<td width="100">Date Drawn:</td>
			<td width="150"><strong>#Dateformat(prizepoolQ.draw_date,"D-MMM-YYYY")#</strong></td>
			</tr>
			
			<tr>
			<td width="100">Points Value:</td>
			<td width="150"><strong>#prizepoolQ.pointsvalue#</strong></td>
			</tr>
			
			
			<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * 
			FROM prize_entry 
			WHERE EntryDate >= #CreateODBCDate(this_start)#
			AND EntryDate <= #CreateODBCDate(this_end)#
			</cfquery>
			
			
			
			<tr>
			<td width="100">Total Entries:</td>
			<td width="150"><strong>#PrizeEntries.recordcount#</strong></td>
			</tr>
			
			
			<cfif session.UserIsAuthenticated EQ 'Yes'>
			
				
				
				<cfquery name="YourEntries" dbtype="query">
				SELECT Prize_entryID
				FROM PrizeEntries 
				WHERE contactid = #session.userid#
				</cfquery>
			
				<tr>
				<td width="100">Your Entries:</td>
				<td width="150" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#YourEntries.recordcount#</strong></td>
				</tr>
			
			</cfif>
			
			</table>
		
		
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