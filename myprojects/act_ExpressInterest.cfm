<cfinclude template="../app_globals.cfm">
<cfquery name="AllSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Settings
WHERE ParserURL LIKE '%www.sherbrookois.com%' 
</cfquery>

<cfif NOT IsDefined("session.AllSettings_SiteName")>

	
	<cfset session.AllSettings_SiteName = AllSettings.SiteName>
	<cfset session.AllSettings_Logo_file = AllSettings.Logo_file>
	<cfset session.AllSettings_MenubarBG_file = AllSettings.MenubarBG_file>
	<cfset session.AllSettings_TextColour = AllSettings.TextColour>
	<cfset session.AllSettings_DkTextColor = AllSettings.DkTextColor>
	<cfset session.AllSettings_HeadingColor = AllSettings.HeadingColor>
	<cfset session.AllSettings_DkHeadingColor = AllSettings.DkHeadingColor>
	<cfset session.AllSettings_LinkColour = AllSettings.LinkColour>
	<cfset session.AllSettings_SubMenuLinkColour = AllSettings.SubMenuLinkColour>
	<cfset session.AllSettings_BoxColour = AllSettings.BoxColour>
	<cfset session.AllSettings_BoxTextColour = AllSettings.BoxTextColour>
	<cfset session.AllSettings_EmailAlertFrom = AllSettings.EmailAlertFrom>
	<cfset session.AllSettings_DkBoxColour = AllSettings.DkBoxColour>
	<cfset session.AllSettings_DkBoxTextColour = AllSettings.DkBoxTextColour>

</cfif>
<cfparam name="application.emailserver" default="maila46.webcontrolcenter.com">

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>www.sherbrookois.com submit interest</title>
</head>

<body>

<!--- <cfif isdefined("form")>
	<cfdump var="#form#">
</cfif> --->

<!--- SEND THE HTML EMAIL --->				
<cfmail server="#application.emailserver#" to="roiipatterson@gmail.com" cc="#trim(form.memberemail)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(form.membername)# has asked about the project: #trim(form.projecttitle)#">
user name: #TRIM(form.membername)#
user email: #trim(form.memberemail)#

project id: #trim(form.CampaignsID)#
project name: #trim(form.projecttitle)#

can finish by: #trim(form.TXTENDDATE)#
user comments: #trim(form.LIMITEDTEXTAREA)#
</cfmail>

Your interest in this campaign has been email to the administrator and cc'd to you. You can now close this window.

</body>
</html>
</cfoutput>