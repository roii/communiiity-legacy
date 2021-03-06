<cfquery name="CharityStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Organisations
WHERE OrganisationID=#OrganisationID#
</cfquery>


<cfparam name="UpdateMode" default="viewprofile">


<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>
<cfinclude template="../templates/set_language.cfm">
#TRIM(AllSettings.SiteName)# - #managecharity#</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#managecharity#</strong></span></td>
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
	<td>
	<span style="font-size:14px;color:black;"><strong>#TRIM(CharityStuff.Organisation_Name)#</strong></span>
	<hr width="100%" size="1" color="silver">
	<input type="button" class="whitefield" value="#viewprofile#" onClick="javascript:location='#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#OrganisationID#&updatemode=viewprofile';"<cfif updatemode EQ 'viewprofile'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="#updateprofile#" onClick="javascript:location='#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#OrganisationID#&updatemode=updatedetails';"<cfif updatemode EQ 'updatedetails'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="#stafflist#" onClick="javascript:location='#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#OrganisationID#&updatemode=stafflist';"<cfif updatemode EQ 'stafflist' OR updatemode EQ 'editstaff' OR updatemode EQ 'addstaff'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="#memberlist#" onClick="javascript:location='#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#OrganisationID#&updatemode=members';"<cfif updatemode EQ 'members'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>>
<hr width="100%" size="1" color="silver"><br></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>
	
		<cfif updatemode EQ 'viewprofile'>
		
			<cfinclude template="dsp_charity_profile.cfm">
		
		<cfelseif updatemode EQ 'updatedetails'>
		
			<cfinclude template="dsp_edit_charity.cfm">
		
		<cfelseif updatemode EQ 'stafflist'>
		
			<cfinclude template="dsp_charity_stafflist.cfm">
		
		<cfelseif updatemode EQ 'addstaff'>
		
			<cfinclude template="dsp_charity_addstaff.cfm">
		
		<cfelseif updatemode EQ 'editstaff'>
		
			<cfinclude template="dsp_charity_editstaff.cfm">
		
		
		
		<cfelseif updatemode EQ 'members'>
		
			<cfinclude template="dsp_charity_members.cfm">
		
		
		 </cfif>
	
	
	</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>