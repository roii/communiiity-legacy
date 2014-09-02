<cfquery name="qry_invitefriend_draws" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes 
WHERE DrawID=#this_DrawID#
</cfquery>

<cfset this_type = qry_invitefriend_draws.type>
<cfset this_start = qry_invitefriend_draws.start_date>
<cfset this_end = qry_invitefriend_draws.draw_date>

<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, ScreenName
FROM Contacts
WHERE ContactID=#winnerID#
</cfquery>

<!--- GET INVITES --->	
<cfif this_type CONTAINS 'Day'>

	<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, ScreenName, EmailAddress, MobilePhone
	FROM Contacts
	WHERE ContactStatus LIKE '%Active%'
	AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(this_Start, 'mm/dd/yyyy')# 23:59:59')
	AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
	</cfquery>	

<cfelse>

	<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, ScreenName, EmailAddress, MobilePhone
	FROM Contacts
	WHERE ContactStatus LIKE '%Active%'
	AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
AND ('#DateFormat(this_End, 'mm/dd/yyyy')# 23:59:59')
	AND ReferralCode='#TRIM(WinnerDetails.ScreenName)#'
	</cfquery>

</cfif>

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Invite Friend - Winner Invites</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Invite Friend - Winner Invites</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><strong>INVITE FRIEND DRAW (#this_type#)</strong> - #DateFormat(this_start)# to #DateFormat(this_end)#
	<hr width="100%" size="1" color="silver">
	WINNER: #WinnerDetails.FirstName# #WinnerDetails.LastName# - #WinnerDetails.Screenname#
	<hr width="100%" size="1" color="silver">
	
	<cfdump var="#PrizeEntries#">
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</table><br><br>
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>