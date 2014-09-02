<cfquery name="qry_invitefriend_draws" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes 
WHERE DrawID=#this_DrawID#
</cfquery>

<cfset this_type = qry_invitefriend_draws.type>
<cfset this_start = qry_invitefriend_draws.start_date>
<cfset this_end = qry_invitefriend_draws.draw_date>

<!--- GET NUMBER OF INVITES --->	
<cfif this_type CONTAINS 'Day'>

	<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ReferralCode, FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactStatus LIKE '%Active%'
	AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(this_Start, 'mm/dd/yyyy')# 23:59:59')
	AND ReferralCode<>''
	ORDER BY ReferralCode
	</cfquery>	

<cfelse>

	<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ReferralCode, FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactStatus LIKE '%Active%'
	AND DateVerified BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(this_End, 'mm/dd/yyyy')# 23:59:59')
	AND ReferralCode<>''
	ORDER BY ReferralCode
	</cfquery>

</cfif>



<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Invite Friend - ALL Invites</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Invite Friend - ALL Invites</strong></span></td>
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
	<td colspan="2"><strong>INVITE FRIEND DRAW (#this_type#)</strong>&nbsp;&nbsp; - &nbsp;&nbsp;#DateFormat(this_start)# &nbsp;to&nbsp; #DateFormat(this_end)#
	<hr width="100%" size="1" color="silver">
</cfoutput>

	
		<table width="100%" cellpadding="0" cellspacing="5" border="0">
		
		<cfoutput group="ReferralCode" query="PrizeEntries">
				
		<tr>
		<td width="140" style="font-size:11px;" valign="top"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle">&nbsp;#TRIM(PrizeEntries.ReferralCode)#</td>
		<td style="font-size:11px;" align="center" width="200" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"><br>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
			<cfoutput>
			
			<tr>
			<td style="font-size:11px;" valign="top">#PrizeEntries.FirstName# #PrizeEntries.LastName# (#PrizeEntries.ScreenName#)<br></td>
			</tr>
			
			</cfoutput>
			
			</table>
		
		
		
		</td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		</cfoutput>
		
		</table>
		
<cfoutput>

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