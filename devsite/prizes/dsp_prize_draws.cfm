<cfoutput>

<cfquery name="prizepoolQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE Start_Date <=#localDateTime#
AND draw_date >= #localDateTime#
AND (country=0<cfif session.UserIsAuthenticated AND IsNumeric("#session.User_CountryID#")> OR country=#session.User_CountryID#</cfif>)
AND PrizeDraw=1
AND deleted=0
ORDER BY DisplayOrder
</cfquery>




<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=50" style="color:###TRIM(AllSettings.BoxColour)#;">Click here</a> to see how to go in the draw.<br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="4"  border="0">


	<hr width="100%" size="1" color="##b4b4b4">



	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="90" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1"  border="0"></td>
	<td width="20" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
	<td width="100%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="300" height="1"  border="0"></td>
	</tr>
	
	<cfif prizepoolQ.RecordCount>
	
		
		<cfloop query="prizepoolQ">
		
		
		<cfset this_start = prizepoolQ.start_date>
		<cfset this_end = prizepoolQ.draw_date>
	
		<tr bgcolor="white">
		<td>
		
			<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
			<tr>
			<td align="center" valign="center">			
			<cfif FileExists("#request.fileroot#\images\prize\#TRIM(prizepoolQ.image)#")>
				<img src="#request.imageroot#/prize/#TRIM(prizepoolQ.image)#" border="0" width="80" height="60">
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
			<td valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><strong>#TRIM(prizepoolQ.description)#</strong></span></td>
			<td valign="top" align="right"><cfif session.UserIsAuthenticated><a href="#request.webroot#/prizes/act_add_watchlist.cfm?PrizePoolID=#prizepoolQ.PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;">(+) WatchList</a></cfif></td>
			</tr>
			
			</table>
		
		
		
		
		<hr width="100%" size="1" color="##b4b4b4">
		
			<table width="400" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="75">Date Drawn:</td>
			<td width="175"><strong>#Dateformat(prizepoolQ.draw_date,"D-MMM-YYYY")#</strong></td>
			<td width="75">Points Value:</td>
			<td width="75"><strong>#prizepoolQ.pointsvalue#</strong></td>
			</tr>
			
			<cfif prizepoolQ.InviteFriend EQ 1>
	
				<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT InvitationID, InvitationFrom
				FROM Invitations
				WHERE InvitationStatus LIKE '%Successful%'
				AND DateResponded >= #CreateODBCDate(this_start)#
				AND DateResponded <= #CreateODBCDate(this_end)#
				</cfquery>
				
			<cfelse>
			
				<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT * 
				FROM prize_entry 
				WHERE EntryDate >= #CreateODBCDate(this_start)#
				AND EntryDate <= #CreateODBCDate(this_end)#
				</cfquery>
			
			</cfif>
			
			<cfif session.UserIsAuthenticated EQ 'Yes'>
				
				<cfif prizepoolQ.InviteFriend EQ 1>
				
					<cfquery name="YourEntries" dbtype="query">
					SELECT InvitationID
					FROM PrizeEntries 
					WHERE InvitationFrom = #session.userid#
					</cfquery>
					
				<cfelse>
				
					<cfquery name="YourEntries" dbtype="query">
					SELECT Prize_entryID
					FROM PrizeEntries 
					WHERE contactid = #session.userid#
					</cfquery>
					
				</cfif>
				
				
			</cfif>	
			
			<tr>
			<td width="75">Total Entries:</td>
			<td width="175"><strong>#PrizeEntries.recordcount#</strong></td>
			<td width="75"><cfif session.UserIsAuthenticated EQ 'Yes'>Your Entries:</cfif></td>
			<td width="75" style="color:###TRIM(AllSettings.BoxColour)#;"><cfif session.UserIsAuthenticated EQ 'Yes'><strong>#YourEntries.recordcount#</strong></cfif></td>
			</tr>
			
			<cfif prizepoolQ.InviteFriend EQ 1>
			<tr>
			<td colspan="4" style="font-size:11px;color:333333;">Entries for the weekly "Invite a Friend" prize are based on the number of <u>successful invitations</u> you have sent during the week.<br>
			The member with the <u>highest number</u> successful invitations wins.</td>
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