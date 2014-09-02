<cfoutput>


<cfquery name="prizepoolQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE draw_date <= #localDateTime#
<!--- AND (country=0<cfif session.UserIsAuthenticated EQ 'Yes'> OR country=#session.User_CountryID#</cfif>) --->
AND status=1
AND deleted=0
AND ShowWinner=1
AND InviteFriend=0
ORDER BY draw_date DESC
</cfquery>



<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">

<cfif prizepoolQ.RecordCount>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="100%" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;padding-right:10px;"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1"  border="0"><br>
	<strong>Prize</strong></td>
	<td width="175" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="175" height="1"  border="0"><br>
	<strong>Winner</strong></td>
	<td width="100" align="center" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1"  border="0"><br>
	<strong>Date Drawn</strong></td>
	<td width="80" align="center" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"><br>
	<strong>Points Value</strong></td>
	</tr>
		
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<cfloop query="prizepoolQ">
		
	<cfset this_start = prizepoolQ.start_date>
	<cfset this_end = prizepoolQ.draw_date>
		
	<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, ScreenName
	FROM Contacts
	WHERE ContactID=#prizepoolQ.winner#
	</cfquery>
		
		
	<tr>
	<td style="font-size:12px;padding-right:10px;"><strong>#TRIM(prizepoolQ.name)#</strong></td>
	<td style="font-size:12px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#prizepoolQ.winner#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#prizepoolQ.winner#" title="View Profile"><cfif TRIM(WinnerDetails.ScreenName) NEQ ''>#TRIM(WinnerDetails.ScreenName)#<cfelse>#TRIM(WinnerDetails.FirstName)#</cfif></a></td>
	<td style="font-size:12px;" align="center">#Dateformat(prizepoolQ.draw_date,"D-MMM-YYYY")#</td>
	<td style="font-size:12px;" align="center">#prizepoolQ.pointsvalue#</td>
	</tr>
				
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	</cfloop>


	</table>
	
	

</cfif>

</td>
</tr>

</table>



</cfoutput>