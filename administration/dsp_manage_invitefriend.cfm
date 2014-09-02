<cfoutput>

<cfinclude template="qry_invitefriend_draws.cfm">


<script language="JavaScript">
<!--
function confirmDrawDelete(aURL) {
    if(confirm('Are you sure you want to delete this Invite-a-Friend Draw?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Draws_StartRow" default="1">
</cflock>
<cfif isdefined("Draws_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Draws_StartRow = Draws_StartRow>
	</cflock>
</cfif>	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Draws_Maxrows" default="10">
</cflock>
<cfif isdefined("Draws_Maxrows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Draws_Maxrows = Draws_Maxrows>
	</cflock>
</cfif>

<cfif session.Draws_Maxrows NEQ 'ALL'>
	<cfif qry_invitefriend_draws.RecordCount GT (session.Draws_StartRow+session.Draws_Maxrows)-1>
		<cfset Prizes_endrow = session.Draws_StartRow+session.Draws_Maxrows-1>
	<cfelse>
		<cfset Prizes_endrow = qry_invitefriend_draws.RecordCount>
	</cfif>
<cfelse>
	<cfset Prizes_endrow = qry_invitefriend_draws.RecordCount>
</cfif>

<!--- SET THE PREV VALUE --->
<cfif session.Draws_StartRow GT session.Draws_Maxrows>
	<cfset prev = session.Draws_StartRow-session.Draws_Maxrows>
<cfelse>
	<cfset prev = session.Draws_StartRow>
</cfif>

<!--- SET THE NEXT VALUE --->
<cfif Prizes_endrow LT qry_invitefriend_draws.RecordCount>
	<cfset next = (Prizes_endrow+1)>
<cfelse>
	<cfset next = session.Draws_StartRow>
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.Draws_Maxrows NEQ 'ALL'>
	<cfset NumberCount=(qry_invitefriend_draws.RecordCount/session.Draws_Maxrows)>
	<cfset PrizesNumberCount=Ceiling(NumberCount)>
<cfelse>
	<cfset PrizesNumberCount=1>	
</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE INVITE-A-FRIEND PRIZES</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

</table><br>


<cfif qry_invitefriend_draws.recordcount>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td colspan="7"><hr width="100%" size="1" color="e2e2e2">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>PRIZES WON</strong> &nbsp;&nbsp;&nbsp; Displaying records &nbsp;<strong>#session.Draws_StartRow#</strong> - <strong>#Prizes_endrow#</strong></td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_Maxrows=20&Draws_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_Maxrows=50&Draws_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_Maxrows=100&Draws_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_Maxrows=ALL&Draws_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</tr>
	
	</table>

<hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="font-size:11px;"><b>Date</b></td>
<td style="font-size:11px;" align="center"><b>Type</b></td>
<td style="font-size:11px;"><b>Winners</b></td>
<td style="font-size:11px;" align="center"><b>Invites</b></td>
<td style="font-size:11px;" align="center"><b>Pts Per Winner</b></td>
<td style="font-size:11px;" align="center"><b>Show Winners</b></td>
<td style="font-size:11px;"></td>
</tr>

<tr>
<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="200" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="100%" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfloop query="qry_invitefriend_draws" startrow="#session.Draws_StartRow#" endrow="#Prizes_endrow#">

<cfset this_DrawID = qry_invitefriend_draws.DrawID>
<cfset this_type = qry_invitefriend_draws.type>
<cfset this_start = qry_invitefriend_draws.start_date>
<cfset this_end = qry_invitefriend_draws.draw_date>
<cfset this_winners = qry_invitefriend_draws.Winners>
<cfset this_showWinner = qry_invitefriend_draws.showWinner>
<cfset this_PointsPaid = qry_invitefriend_draws.PointsPaid>
<cfset this_PointsPerWinner = qry_invitefriend_draws.PointsPerWinner>
	


<tr>
<td valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_invitefriend_allinvites.cfm?this_DrawID=#this_DrawID#" target="Invites" ONCLICK="fdbackwindow=window.open ('','Invites','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=550,top=10,left=10')">#DateFormat(this_start)#<cfif TRIM(this_type) DOES NOT CONTAIN 'Day'> -<br>#DateFormat(this_end)#</cfif></a></td>
<td valign="top" style="font-size:11px;" align="center"><cfif TRIM(this_type) CONTAINS 'Day'>Daily Draw<cfelseif TRIM(Type) CONTAINS 'Week'>Weekly Draw<cfelse>Monthly Draw</cfif></td>
<td valign="top" style="font-size:11px;" colspan="2">

	<table width="260" cellpadding="0" cellspacing="0" border="0">
	
	<cfif this_winners NEQ 0>
	
		<cfloop list="#this_winners#" index="loopitem" delimiters=",">
		
		<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, FirstName, ScreenName
		FROM Contacts
		WHERE ContactID=#loopitem#
		</cfquery>
		
		<!--- GET NUMBER OF INVITES --->	
		<cfif this_type CONTAINS 'Day'>
		
			<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Count(ContactID) AS TotalInvites, ReferralCode
			FROM Contacts
			WHERE ContactStatus LIKE '%Active%'
			AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
			AND ('#DateFormat(this_Start, 'mm/dd/yyyy')# 23:59:59')
			AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
			GROUP BY ReferralCode
			ORDER BY TotalInvites DESC
			</cfquery>	
		
		<cfelse>
		
			<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Count(ContactID) AS TotalInvites, ReferralCode
			FROM Contacts
			WHERE ContactStatus LIKE '%Active%'
			AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(this_End, 'mm/dd/yyyy')# 23:59:59')
			AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
			GROUP BY ReferralCode
			ORDER BY TotalInvites DESC
			</cfquery>
		
		</cfif>
		
		
		
		<tr>
		<td width="200" style="font-size:11px;" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#loopitem#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#loopitem#" title="View Profile"><cfif TRIM(WinnerDetails.ScreenName) NEQ ''>#TRIM(WinnerDetails.ScreenName)#<cfelse>#TRIM(WinnerDetails.FirstName)#</cfif></a></td>
		<td style="font-size:11px;" align="center" width="60" valign="top"><a href="#request.webroot#/administration/dsp_invitefriend_invites.cfm?winnerID=#loopitem#&this_DrawID=#this_DrawID#" target="Invites" ONCLICK="fdbackwindow=window.open ('','Invites','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=550,top=10,left=10')">#PrizeEntries.TotalInvites#</a></td>
		</tr>
		
		</cfloop>
	
	<cfelse>
		
		<tr>
		<td width="200" style="font-size:11px;" valign="top">No successful invites</td>
		<td style="font-size:11px;" align="center" width="60" valign="top"></td>
		</tr>
		
	</cfif>
	
	
	<tr>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1"  border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1"  border="0"></td>
	</tr>
	
	</table>

</td>
<td valign="top" align="center" style="font-size:11px;">#this_PointsPerWinner#</td>
<td valign="top" align="center" style="font-size:11px;"><cfif this_ShowWinner EQ 1><strong>Yes</strong> &nbsp;|&nbsp; <a href="#request.webroot#/administration/act_invitefriend_hidewinner.cfm?DrawID=#this_DrawID#">No</a><cfelse><a href="#request.webroot#/administration/act_invitefriend_showwinner.cfm?DrawID=#this_DrawID#">Yes</a> &nbsp;|&nbsp; <strong>No</strong></cfif><cfif ListLen(this_winners) GT 0><br><cfif this_PointsPaid EQ 1>Points Paid<cfelse><a href="#request.webroot#/administration/act_invitefriend_paypoints.cfm?DrawID=#this_DrawID#" style="color:###TRIM(AllSettings.BoxColour)#;">Pay Points</a></cfif></cfif></td>
<td valign="top" align="right" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_invitefriend.cfm?drawID=#this_drawID#" target="EditPrize" onclick="fdbackwindow=window.open ('','EditPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Draw" border="0"></a> <a href="javascript:confirmDrawDelete('#request.webroot#/administration/act_del_invitefriend.cfm?drawID=#this_drawID#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Draw" border="0"></a></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>


<tr>
<td colspan="7" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
</tr>

<tr>
<td colspan="7" align="right"><cfif session.Draws_StartRow GT session.Draws_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_StartRow=#prev#">Prev Page</a> | </cfif><cfif Prizes_endrow LT qry_invitefriend_draws.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_StartRow=#next#">Next Page</a> &gt;</cfif><cfif session.Draws_Maxrows NEQ 'ALL'> ::: <cfloop from="1" to="#PrizesNumberCount#" index="NumberCount"><cfset thisStartRow = (session.Draws_Maxrows * NumberCount - session.Draws_Maxrows + 1)><cfif thisStartRow EQ session.Draws_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Draws_StartRow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Draws_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ PrizesNumberCount> - </cfif></cfloop></cfif></td>
</tr>

<tr>
<td colspan="7" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
</cfif>





<cfif qry_active_invitefriend_draws.recordcount>
<br><br>
<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td colspan="7">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>ACTIVE PRIZES</strong></td>
	<td align="right"></td>
	</tr>
	
	</table>

<hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="font-size:11px;"><b>Date</b></td>
<td style="font-size:11px;" align="center"><b>Type</b></td>
<td style="font-size:11px;"><b>Winners</b></td>
<td style="font-size:11px;" align="center"><b>Invites</b></td>
<td style="font-size:11px;" align="center"><b></b></td>
<td style="font-size:11px;" align="center"><b></b></td>
<td style="font-size:11px;"></td>
</tr>

<tr>
<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="200" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="100%" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfloop query="qry_active_invitefriend_draws" startrow="#session.Draws_StartRow#" endrow="#Prizes_endrow#">

<cfset this_DrawID = qry_active_invitefriend_draws.DrawID>
<cfset this_type = qry_active_invitefriend_draws.type>
<cfset this_start = qry_active_invitefriend_draws.start_date>
<cfset this_end = qry_active_invitefriend_draws.draw_date>
<cfset this_winners = qry_active_invitefriend_draws.Winners>
<cfset this_showWinner = qry_active_invitefriend_draws.showWinner>
<cfset this_PointsPaid = qry_active_invitefriend_draws.PointsPaid>
<cfset this_PointsPerWinner = qry_active_invitefriend_draws.PointsPerWinner>


<tr>
<td valign="top" style="font-size:11px;">#DateFormat(this_start)#<cfif TRIM(this_type) DOES NOT CONTAIN 'Day'> -<br>#DateFormat(this_end)#</cfif></td>
<td valign="top" style="font-size:11px;" align="center"><cfif TRIM(this_type) CONTAINS 'Day'>Daily Draw<cfelseif TRIM(Type) CONTAINS 'Week'>Weekly Draw<cfelse>Monthly Draw</cfif></td>
<td valign="top" style="font-size:11px;" colspan="2">

	<table width="260" cellpadding="0" cellspacing="0" border="0">
	
		
		
		<!--- GET NUMBER OF INVITES --->	
		<cfif this_type CONTAINS 'Day'>
		
			<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Count(ContactID) AS TotalInvites, ReferralCode
			FROM Contacts
			WHERE ContactStatus LIKE '%Active%'
			AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
			AND ('#DateFormat(this_Start, 'mm/dd/yyyy')# 23:59:59')
			AND ReferralCode<>''
			GROUP BY ReferralCode
			ORDER BY TotalInvites DESC
			</cfquery>	
		
		<cfelse>
		
			<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Count(ContactID) AS TotalInvites, ReferralCode
			FROM Contacts
			WHERE ContactStatus LIKE '%Active%'
			AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
			AND ('#DateFormat(this_End, 'mm/dd/yyyy')# 23:59:59')
			AND ReferralCode<>''
			GROUP BY ReferralCode
			ORDER BY TotalInvites DESC
			</cfquery>
		
		</cfif>
		
		<cfloop query="PrizeEntries">
		
		<tr>
		<td width="200" style="font-size:11px;" valign="top"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle">&nbsp;#TRIM(PrizeEntries.ReferralCode)#</td>
		<td style="font-size:11px;" align="center" width="60" valign="top">#PrizeEntries.TotalInvites#</td>
		</tr>
		
		</cfloop>
	
	
	
	<tr>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1"  border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1"  border="0"></td>
	</tr>
	
	</table>

</td>
<td valign="top" align="center" style="font-size:11px;"></td>
<td valign="top" align="center" style="font-size:11px;"></td>
<td valign="top" align="right" style="font-size:11px;"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>



</table>
</cfif>

</cfoutput>