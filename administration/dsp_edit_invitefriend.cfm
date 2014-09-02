<cfquery name="DrawStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes
WHERE DrawID=#DrawID#
</cfquery>

<cfinclude template="../templates/qry_all_countries.cfm">

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Invite Friend Draw</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Invite Friend Draw</strong></span></td>
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
	
	<form name="editPrize" action="#request.webroot#/administration/act_edit_invitefriend.cfm" method="post">

	<input type="hidden" name="drawID" value="#drawID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Winners</td>
	<td valign="top"><cfloop list="#TRIM(DrawStuff.winners)#" index="Winner" delimiters=",">
	
	<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Screenname
	FROM Contacts
	WHERE ContactID=#Winner#
	</cfquery>
	
	<input type="checkbox" value="#Winner#" name="winners" class="whitefield" checked> #ContactStuff.Screenname#<br>
	</cfloop></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Points Per Winner</td>
	<td><input type="text" value="#TRIM(DrawStuff.PointsPerWinner)#" name="PointsPerWinner" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="UPDATE DRAW NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table>


	
</td>
</tr>

</table>

</body>
</html>
</cfoutput>