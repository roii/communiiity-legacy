<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">

<cfparam name="session.InviteweekWon_StartRow" default="1">
<cfif isdefined("InviteweekWon_StartRow")>	
	<cfset session.InviteweekWon_StartRow = InviteweekWon_StartRow>
</cfif>

<cfparam name="session.InviteweekWon_MaxRows" default="20">
<cfif isdefined("InviteweekWon_MaxRows")>	
	<cfset session.InviteweekWon_MaxRows = InviteweekWon_MaxRows>
</cfif>

</cflock>
	
<!--- SET THE IdeaFunL_endrow VALUE --->
<cfif session.InviteweekWon_MaxRows NEQ 'ALL'>	
	<cfif qry_invite_week.RecordCount GT (session.InviteweekWon_StartRow+session.InviteweekWon_MaxRows)-1>
		<cfset InviteweekWon_endrow = session.InviteweekWon_StartRow+session.InviteweekWon_MaxRows-1>
	<cfelse>
		<cfset InviteweekWon_endrow = qry_invite_week.RecordCount>
	</cfif>	
<cfelse>
	<cfset InviteweekWon_endrow = qry_invite_week.RecordCount>	
</cfif>	
	
<!--- SET THE PREV VALUE --->
<cfif session.InviteweekWon_Startrow GT session.InviteweekWon_Maxrows>
	<cfset prev = session.InviteweekWon_Startrow-session.InviteweekWon_Maxrows>	
<cfelse>
	<cfset prev = session.InviteweekWon_StartRow>	
</cfif>
	
<!--- SET THE NEXT VALUE --->
<cfif InviteweekWon_endrow LT qry_invite_week.RecordCount>
	<cfset next = (InviteweekWon_endrow+1)>	
<cfelse>
	<cfset next = session.InviteweekWon_StartRow>	
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.InviteweekWon_MaxRows NEQ 'ALL'>	
	<cfset NumberCount=(qry_invite_week.RecordCount/session.InviteweekWon_Maxrows)>
	<cfset InviteweekWonNumberCount=Ceiling(NumberCount)>	
<cfelse>	
	<cfset InviteweekWonNumberCount=1>		
</cfif>
<a name="weekly"></a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="font-size:12px;color:##ffffff;padding:4px;" bgcolor="###TRIM(AllSettings.BoxColour)#"><strong>Weekly Prize Winners</strong></td>
</tr>

</table>


<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td colspan="5" style="font-size:11px;padding-top:6px;">::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_maxrows=20&InviteweekWon_StartRow=1&InviteFriendList=1&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_maxrows=50&InviteweekWon_StartRow=1&InviteFriendList=1&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_maxrows=100&InviteweekWon_StartRow=1&InviteFriendList=1&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_maxrows=ALL&InviteweekWon_StartRow=1&InviteFriendList=1&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a>
<hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr>
<td width="120" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"><br>
<strong>Date</strong></td>
<td width="190" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="190" height="1"  border="0"><br>
<strong>Winners</strong></td>
<td width="140" align="center" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"><br>
<strong>Total Invites</strong></td>
<td width="120" align="center" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"><br>
<strong>Points Per Winner</strong></td>
<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>
	
<tr>
<td colspan="5"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<cfloop query="qry_invite_week" startrow="#session.InviteweekWon_StartRow#" endrow="#InviteweekWon_endrow#">

<cfset this_InviteDrawStart = qry_invite_week.start_date>
<cfset this_InviteDrawEnd = qry_invite_week.draw_date>
<cfset this_InviteWinners = TRIM(qry_invite_week.winners)>
<cfset this_Type = TRIM(qry_invite_week.Type)>	
	
<tr>
<td style="font-size:12px;" valign="top">#Dateformat(this_InviteDrawStart,"D-MMM-YYYY")#<cfif TRIM(this_Type) DOES NOT CONTAIN 'week'> -<br>#Dateformat(this_InviteDrawEnd, "d-mmm-yyyy")#</cfif></td>
<td style="font-size:12px;" colspan="2" valign="top">
	
	<table width="310" cellpadding="0" cellspacing="0" border="0">
	
	<cfif this_InviteWinners NEQ 0>
	
		<cfloop list="#this_InviteWinners#" index="loopitem" delimiters=",">
		
		<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, FirstName, ScreenName
		FROM Contacts
		WHERE ContactID=#loopitem#
		</cfquery>
		
		
		<!--- GET NUMBER OF INVITES --->	
	<cfif this_type CONTAINS 'week'>
	
		<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Count(ContactID) AS TotalInvites, ReferralCode
		FROM Contacts
		WHERE ContactStatus LIKE '%Active%'
		AND DateJoined BETWEEN ('#DateFormat(this_InviteDrawStart, 'mm/dd/yyyy')# 00:00:00')
		AND ('#DateFormat(this_InviteDrawStart, 'mm/dd/yyyy')# 23:59:59')
		AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
		GROUP BY ReferralCode
		ORDER BY TotalInvites DESC
		</cfquery>
		
	
	<cfelse>
	
		<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Count(ContactID) AS TotalInvites, ReferralCode
		FROM Contacts
		WHERE ContactStatus LIKE '%Active%'
		AND DateJoined BETWEEN ('#DateFormat(this_InviteDrawStart, 'mm/dd/yyyy')# 00:00:00')
AND ('#DateFormat(this_InviteDrawEnd, 'mm/dd/yyyy')# 23:59:59')
		AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
		GROUP BY ReferralCode
		ORDER BY TotalInvites DESC
		</cfquery>
	
	</cfif>	
		
		<tr>
		<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#loopitem#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#loopitem#" title="View Profile"><cfif TRIM(WinnerDetails.ScreenName) NEQ ''>#TRIM(WinnerDetails.ScreenName)#<cfelse>#TRIM(WinnerDetails.FirstName)#</cfif></a></td>
		<td style="font-size:12px;" align="center" valign="top">#PrizeEntries.TotalInvites#</td>
		</tr>
		
		</cfloop>
	
	<cfelse>
	
		<tr>
		<td valign="top">No Successful Invites</td>
		<td style="font-size:12px;" align="center" valign="top"></td>
		</tr>
		
	</cfif>	
	
	<tr>
	<td width="190"><img src="#request.imageroot#/transparent_spc.gif" width="190" height="1"  border="0"></td>
	<td width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"></td>
	</tr>
	
	</table>

</td>
<td style="font-size:12px;" align="center" valign="top">#qry_invite_week.pointsperwinner#</td>
<td></td>
</tr>
			
<tr>
<td colspan="5"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

</cfloop>

<tr>
<td colspan="5" style="font-size:11px;" align="right"><cfif session.InviteweekWon_Startrow GT session.InviteweekWon_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_Startrow=#prev#&InviteFriendList=1&documentID=#documentID#">Prev Page</a> | </cfif><cfif InviteweekWon_endrow LT qry_invite_week.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_Startrow=#next#&InviteFriendList=1&documentID=#documentID#">Next Page</a> &gt;</cfif><cfif session.InviteweekWon_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#InviteweekWonNumberCount#" index="NumberCount"><cfset thisStartRow=(session.InviteweekWon_Maxrows*NumberCount-session.InviteweekWon_Maxrows+1)><cfif thisStartRow EQ session.InviteweekWon_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&InviteweekWon_Startrow=#thisStartRow#&InviteFriendList=1&documentID=#documentID#"></cfif>#NumberCount#<cfif thisStartRow EQ session.InviteweekWon_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ InviteweekWonNumberCount> - </cfif></cfloop></cfif></td>
</tr>	

</table><br>

</cfoutput>