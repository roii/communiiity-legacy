<cfquery name="PartnerStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Organisations
WHERE OrganisationID=#OrganisationID#
</cfquery>


<cfparam name="UpdateMode" default="viewprofile">


<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Manage Partner</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Manage Partner</strong></span></td>
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
	<span style="font-size:14px;color:black;"><strong>#TRIM(PartnerStuff.Organisation_Name)#</strong></span>
	<hr width="100%" size="1" color="silver">
	<input type="button" class="whitefield" value="VIEW PROFILE" onclick="javascript:location='#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=viewprofile';"<cfif updatemode EQ 'viewprofile'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="UPDATE PROFILE" onclick="javascript:location='#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=updatedetails';"<cfif updatemode EQ 'updatedetails'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="PROFILE CONTENT" onclick="javascript:location='#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=content';"<cfif updatemode EQ 'content'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="STAFF LIST" onclick="javascript:location='#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=stafflist';"<cfif updatemode EQ 'stafflist' OR updatemode EQ 'editstaff' OR updatemode EQ 'addstaff'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>> <input type="button" class="whitefield" value="POINTS" onclick="javascript:location='#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=points';"<cfif updatemode EQ 'points' OR updatemode EQ 'editpoints' OR updatemode EQ 'addpoints'> style="background-color:###TRIM(AllSettings.BoxColour)#;color:white;"</cfif>>
<hr width="100%" size="1" color="silver"><br></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>
	
		<cfif updatemode EQ 'viewprofile'>
		
			<cfinclude template="dsp_partner_profile.cfm">
		
		<cfelseif updatemode EQ 'updatedetails'>
		
			<cfinclude template="dsp_edit_partner.cfm">
		
		<cfelseif updatemode EQ 'stafflist'>
		
			<cfinclude template="dsp_partner_stafflist.cfm">
		
		<cfelseif updatemode EQ 'addstaff'>
		
			<cfinclude template="dsp_partner_addstaff.cfm">
		
		<cfelseif updatemode EQ 'editstaff'>
		
			<cfinclude template="dsp_partner_editstaff.cfm">
		
		<cfelseif updatemode EQ 'points'>
		
			<cfinclude template="dsp_partner_points.cfm">
		
		<cfelseif updatemode EQ 'editpoints'>
		
			<cfinclude template="dsp_partner_edit_points.cfm">
		
		<cfelseif updatemode EQ 'addpoints'>
		
			<cfinclude template="dsp_partner_add_points.cfm">
		
		<cfelseif updatemode EQ 'content'>
		
			<cfinclude template="dsp_partner_content.cfm">
		
		
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