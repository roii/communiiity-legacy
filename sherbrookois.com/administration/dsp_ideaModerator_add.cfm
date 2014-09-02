<cfoutput>

<cfquery name="qry_contacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, ScreenName, Roles
FROM Contacts
WHERE ContactTypeID IN (1,2)
AND ContactStatus LIKE '%Active%'
AND FirstName <> ''
AND Screenname <> ''
ORDER BY FirstName
</cfquery>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)# - Add Idea Moderator</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Idea Moderator</strong></span></td>
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
	
	<form action="#request.webroot#/administration/act_ideaModerator_add.cfm" method="post">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><strong>Tick contacts below to assign to Idea Moderator role...</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>
	
		<cfset ContactList = "">
		
		<cfloop query="qry_contacts">
		<cfif NOT ListFind(qry_contacts.roles, '2', ',')>
			<cfset ContactList = ListAppend(ContactList, qry_contacts.ContactID, ",")>
		</cfif>
		</cfloop>
		
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">		
		
		<tr>
		
		<cfset thisrow = 0>
		<cfloop list="#ContactList#" index="loopitem" delimiters=",">
		<cfset thisrow = thisrow + 1>
		
		<cfquery name="qry_contact_details" dbtype="query">
		SELECT FirstName, LastName, ScreenName, Roles
		FROM qry_contacts
		WHERE ContactID=#loopitem#
		</cfquery>
		
		<td width="20"><input type="checkbox" class="whitefield" name="ContactID" value="#loopitem#"></td>
		<td width="150" style="font-size:11px;">#TRIM(qry_contact_details.FirstName)# #TRIM(qry_contact_details.LastName)#</td>
		<td width="100" style="font-size:11px;">#TRIM(qry_contact_details.ScreenName)#</td>
		<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
		<cfif Evaluate(thisrow MOD 2) EQ 1>
			</tr>
			<tr>
		</cfif>
		
		</cfloop>
		
		</tr>
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><input type="submit" value="ADD MODERATOR NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>