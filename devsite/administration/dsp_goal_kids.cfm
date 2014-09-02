
<!--- GET ALL CATEGORIES --->
<cfquery name="GoalCatStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryName
FROM GoalCats
WHERE GoalCatID=#GoalCatID#
</cfquery>


<cfquery name="ActiveKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
FROM Goals, GoalKidsLink, Contacts
WHERE Goals.GoalCatID=#GoalCatID#
AND Goals.GoalID=GoalKidsLink.GoalID
AND GoalKidsLink.KidsID=Contacts.ContactID
GROUP BY Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
ORDER BY FirstName
</cfquery>
	

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Goal Cateogry - Active Members</title>
<cfinclude template="../templates/styles.cfm">

	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Goal Cateogry - Active Members</strong></span></td>
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
	<td colspan="2" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:12px;"><strong>#TRIM(GoalCatStuff.CategoryName)#</strong></td>
	<td align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(activekids.contactID)#" target="mymainwindow">Email All Members</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	
	<cfloop query="activekids">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>#TRIM(activekids.FirstName)# #TRIM(activekids.LastName)#</td>
	<td><a href="mailto:#TRIM(activekids.emailaddress)#">#TRIM(activekids.emailaddress)#</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>