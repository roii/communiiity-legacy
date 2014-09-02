<!--- AUTHORISATION REQUIRED - ADMINISTRATION USERS --->
<cfif session.permission95_view EQ 1 OR session.permission1_view EQ 1> 

	<cfoutput>
	
	<cfquery name="qry_role_details" datasource="#dsn#">
	SELECT RoleID, RoleName
	FROM Roles
	WHERE RoleID=#RoleID#
	</cfquery>
	
	<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

	<html>
	<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Roles</title>
	<cfinclude template="../templates/styles.cfm">
	</head>
	
	<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">
	
	
	
	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr height="40">
	<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
	<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Role</strong></span></td>
	</tr>	
	
	<tr>
	<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td valign="top">
	<br>
	
	
		<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
		
		<form method="post" action="#request.webroot#/administration/act_role_edit.cfm" name="roleform">
		<input type="hidden" name="RoleID" value="#RoleID#">
		
		<tr>
		<td><br>
		
		
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
			
			<tr>
			<td width="100" align="right" style="padding-right:5px;"><b>Role Name:</b></td>
			<td width="205"><input Type="text" style="width:200px;" class="whitefield" name="RoleName" value="#TRIM(qry_role_details.RoleName)#"></td>
			<td><input type="submit" value="Update Role" class="whitefield" border="0"></td>
			</tr>
			
			</table>
		
		
		</td>
		</tr>
		
		</form>
		</table><br>
	
	
	</td>
	</tr>
	
	</table>
	
	</body>
	</html>
	
	</cfoutput>

<cfelse>

	<script>
	alert("You don't have permission to access this page.");
	window.close();
	</script>
	<cfabort>

</cfif>