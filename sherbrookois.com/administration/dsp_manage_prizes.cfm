<cfoutput>

<cfparam name="session.viewArchived" default="0">
<cfif IsDefined("viewArchived")>
	<cfset session.viewArchived=viewArchived>
</cfif>

<script language="JavaScript">
<!--
function confirmPrizeDelete(aURL) {
    if(confirm('Are you sure you want to delete this Prize?')) {
      location.href = aURL;
    }
  }
//-->
</script>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Prizes_StartRow" default="1">
</cflock>

	<cfif isdefined("Prizes_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Prizes_StartRow = Prizes_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Prizes_MaxRows" default="10">
</cflock>

	<cfif isdefined("Prizes_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Prizes_MaxRows = Prizes_MaxRows>
		</cflock>
	</cfif>
	

<cfinclude template="qry_prizepool.cfm">



<!--- SET THE members_endrow VALUE --->
<cfif session.Prizes_MaxRows NEQ 'ALL'>
	<cfif ArchivedPrizes.RecordCount GT (session.Prizes_StartRow+session.Prizes_MaxRows)-1>
		<cfset Prizes_endrow = session.Prizes_StartRow+session.Prizes_MaxRows-1>
	<cfelse>
		<cfset Prizes_endrow = ArchivedPrizes.RecordCount>
	</cfif>
<cfelse>
	<cfset Prizes_endrow = ArchivedPrizes.RecordCount>
</cfif>

<!--- SET THE PREV VALUE --->
<cfif session.Prizes_Startrow GT session.Prizes_Maxrows>
	<cfset prev = session.Prizes_Startrow-session.Prizes_Maxrows>
<cfelse>
	<cfset prev = session.Prizes_StartRow>
</cfif>

<!--- SET THE NEXT VALUE --->
<cfif Prizes_endrow LT ArchivedPrizes.RecordCount>
	<cfset next = (Prizes_endrow+1)>
<cfelse>
	<cfset next = session.Prizes_StartRow>
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.Prizes_MaxRows NEQ 'ALL'>
	<cfset NumberCount=(ArchivedPrizes.RecordCount/session.Prizes_Maxrows)>
	<cfset PrizesNumberCount=Ceiling(NumberCount)>
<cfelse>
	<cfset PrizesNumberCount=1>	
</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE PRIZES</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td style="font-size:11px;"><a href="#request.webroot#/administration/dsp_add_prizepool.cfm" target="AddPrize" onclick="fdbackwindow=window.open ('','AddPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A PRIZE &raquo;</strong></a></td>
<td></td>
</tr>

</table><br>


<cfif AllPrize.recordcount>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td colspan="7" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#;"><hr width="100%" size="1" color="e2e2e2">
<strong>ACTIVE PRIZES</strong>
<hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="padding-right:10px;font-size:11px;"><b>Name</b></td>
<td align="center" style="font-size:11px;"><b>Start Date</b></td>
<td align="center" style="font-size:11px;"><b>Draw Date</b></td>
<td align="center" style="font-size:11px;"><b>Entries</b></td>
<td align="center" style="font-size:11px;"><b>Country</b></td>
<td align="center" style="font-size:11px;"><strong>Invite Prize</strong></td>
<td align="center" style="font-size:11px;"></td>
</tr>

<tr>
<td width="*" height="2"> </td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="50" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="70" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
<td width="40" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfset i=1>

<cfloop query="AllPrize">

<cfset this_PrizePoolID = AllPrize.PrizePoolID>
<cfset this_Country = INT(AllPrize.Country)>
<cfset this_start = AllPrize.start_date>
<cfset this_end = AllPrize.draw_date>


<cfif this_Country NEQ 0>
	
	<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries 
	WHERE CountryID=#this_Country#
	</cfquery>
	
</cfif>


<cfif AllPrize.InviteFriend EQ 1>
	
	<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT InvitationFrom
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
	
<tr>
<td valign="top" style="padding-right:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=prizedetails&prizepoolid=#AllPrize.prizepoolid#">#TRIM(AllPrize.Name)#</a><br>
#TRIM(AllPrize.Description)#</td>
<td valign="top" align="center" style="font-size:11px;">#dateformat(AllPrize.start_date,'d-mmm-yy')#</td>
<td valign="top" align="center" style="font-size:11px;">#dateformat(AllPrize.draw_date,'d-mmm-yy')#</td>
<td valign="top" align="center" style="font-size:11px;">#PrizeEntries.recordcount#</td>
<td valign="top" align="center" style="font-size:11px;"><cfif this_Country NEQ 0>#TRIM(CountryDetails.Name)#<cfelse>All Countries</cfif></td>
<td align="center" style="font-size:11px;" valign="top"><cfif AllPrize.InviteFriend EQ 1>YES<cfelse>NO</cfif></td>
<td align="right" valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_prizepool.cfm?prizepoolid=#prizepoolid#" target="EditPrize" onclick="fdbackwindow=window.open ('','EditPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Prize" border="0"></a> <a href="javascript:confirmPrizeDelete('#request.webroot#/administration/act_del_prizepool.cfm?prizepoolID=#prizepoolid#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Prize" border="0"></a></td>
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


</table><br><br>
</cfif>




<cfif ArchivedPrizes.recordcount>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td colspan="8"><hr width="100%" size="1" color="e2e2e2">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>PRIZES WON</strong> &nbsp;&nbsp;&nbsp; Displaying records &nbsp;<strong>#session.Prizes_StartRow#</strong> - <strong>#Prizes_endrow#</strong></td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_maxrows=20&Prizes_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_maxrows=50&Prizes_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_maxrows=100&Prizes_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_maxrows=ALL&Prizes_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</tr>
	
	</table>

<hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="padding-right:10px;font-size:11px;"><b>Name</b></td>
<td align="center" style="font-size:11px;"><b>Winner</b></td>
<td align="center" style="font-size:11px;"><b>Show Winner</b></td>
<td align="center" style="font-size:11px;"><b>Draw Date</b></td>
<td align="center" style="font-size:11px;"><b>Entries</b></td>
<td align="center" style="font-size:11px;"><b>Country</b></td>
<td align="center" style="font-size:11px;"><strong>Invite Prize</strong></td>
<td align="center" style="font-size:11px;"></td>
</tr>

<tr>
<td width="*" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="120" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="50" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="70" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
<td width="40" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfloop query="ArchivedPrizes" startrow="#session.Prizes_StartRow#" endrow="#Prizes_endrow#">

<cfset this_PrizePoolID = ArchivedPrizes.PrizePoolID>
<cfset this_Country = INT(ArchivedPrizes.Country)>
<cfset this_start = ArchivedPrizes.start_date>
<cfset this_end = ArchivedPrizes.draw_date>
<cfset this_winner = ArchivedPrizes.Winner>
<cfset this_InviteFriend = ArchivedPrizes.InviteFriend>
<cfset this_PointsPaid = ArchivedPrizes.PointsPaid>
<cfset this_Daily500 = ArchivedPrizes.Daily500>


<cfif this_Country NEQ 0>
	
	<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries 
	WHERE CountryID=#this_Country#
	</cfquery>
	
</cfif>

<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_entry 
WHERE EntryDate >= #CreateODBCDateTime(this_start)#
AND EntryDate <= #CreateODBCDateTime(this_end)#
</cfquery>

<cfif this_winner NEQ '' AND this_winner NEQ 0>
	
	<cfquery name="WinnerStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactID=#this_winner#
	</cfquery>

</cfif>

<tr>
<td valign="top" style="padding-right:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=prizedetails&prizepoolid=#this_PrizePoolID#">#TRIM(ArchivedPrizes.Name)#</a><br>
#TRIM(ArchivedPrizes.Description)#</td>
<td valign="top" align="center" style="font-size:11px;"><cfif this_winner NEQ '' AND this_winner NEQ 0 AND IsDefined("WinnerStuff.FirstName")><a href="#request.webroot#/administration/dsp_contact_details_popup.cfm?contactID=#WinnerStuff.contactID#" target="ContactDetails" onclick="fdbackwindow=window.open ('','ContactDetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=350,top=10,left=10')">#TRIM(WinnerStuff.FirstName)# #TRIM(WinnerStuff.LastName)# (#TRIM(WinnerStuff.ScreenName)#)</a><br>
<a href="#request.webroot#/administration/act_prize_draw.cfm?prizepoolid=#this_PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;">Re-Draw</a><cfelse><cfif this_Daily500 EQ 1><a href="#request.webroot#/act_prizedraw_daily500.cfm?prizepoolid=#this_PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;"><cfelse><a href="#request.webroot#/administration/act_prize_draw.cfm?prizepoolid=#this_PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif>Draw A Winner!</a></cfif></td>
<td valign="top" align="center" style="font-size:11px;">
<cfif ArchivedPrizes.ShowWinner EQ 1><strong>Yes</strong> &nbsp;|&nbsp; <a href="#request.webroot#/administration/act_prizepool_hidewinner.cfm?PrizePoolID=#this_PrizePoolID#">No</a><cfelse><a href="#request.webroot#/administration/act_prizepool_showwinner.cfm?PrizePoolID=#this_PrizePoolID#">Yes</a> &nbsp;|&nbsp; <strong>No</strong></cfif>
<cfif (this_winner NEQ '' AND this_winner NEQ 0 AND IsDefined("WinnerStuff.FirstName")) AND (this_Daily500 EQ 1 OR this_InviteFriend EQ 1)> 
	<br>
	<cfif this_PointsPaid EQ 1>
		Points Paid
	<cfelse>
		<a href="#request.webroot#/administration/act_prizepool_paypoints.cfm?PrizePoolID=#this_PrizePoolID#" style="color:###TRIM(AllSettings.BoxColour)#;">Pay Points</a>
	</cfif>
	
</cfif></td>
<td valign="top" align="center" style="font-size:11px;">#dateformat(ArchivedPrizes.draw_date,'d-mmm-yy')#</td>
<td align="center" valign="top" style="font-size:11px;">#PrizeEntries.recordcount#</td>
<td valign="top" align="center" style="font-size:11px;"><cfif this_Country NEQ 0>#TRIM(CountryDetails.Name)#<cfelse>All Countries</cfif></td>
<td align="center" valign="top" style="font-size:11px;"><cfif ArchivedPrizes.InviteFriend EQ 1>YES<cfelse>NO</cfif></td>
<td align="right" valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_prizepool.cfm?prizepoolid=#prizepoolid#" target="EditPrize" onclick="fdbackwindow=window.open ('','EditPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Prize" border="0"></a> <a href="javascript:confirmPrizeDelete('#request.webroot#/administration/act_del_prizepool.cfm?prizepoolID=#prizepoolid#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Prize" border="0"></a></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>


<tr>
<td colspan="8" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
</tr>

<tr>
<td colspan="8" align="right"><cfif session.Prizes_Startrow GT session.Prizes_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_Startrow=#prev#">Prev Page</a> | </cfif><cfif Prizes_endrow LT ArchivedPrizes.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Prizes_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#PrizesNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Prizes_Maxrows*NumberCount-session.Prizes_Maxrows+1)><cfif thisStartRow EQ session.Prizes_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Prizes_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Prizes_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ PrizesNumberCount> - </cfif></cfloop></cfif></td>
</tr>

<tr>
<td colspan="8" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
</cfif>

</cfoutput>