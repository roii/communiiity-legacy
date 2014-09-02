<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)#</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###TRIM(session.AllSettings_TextColour)#">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<!--- HEADER BAR - Logo / Subnav / Advert --->
<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_topbar.cfm">
</td>
</tr>

<!--- NAVIGATION BAR - Main Navigation --->
<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_menubar.cfm">
</td>
</tr>

<!--- MAIN LAYOUT - Leftside column, main column, rightside column --->
<tr>
<td width="170" valign="top">
	<cfinclude template="dsp_homepage_Lsidebar.cfm">
</td>

<td width="*" valign="top" style="padding-left:10px;padding-right:10px;padding-top:8px;">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	<td width="*" style="padding-left:5px;padding-right:5px;">
		
		<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
		#TRIM(sectiondetails.details)#<br>
		</cfif>
		
		<!---<cfinclude template="dsp_homepage_displaypane.cfm">--->
		<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
		
		
		<cfinclude template="dsp_community_articles.cfm">
		<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">

		<!---<cfinclude template="dsp_stats.cfm">
		<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">--->
		
	</td>	
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	</tr>	
	</table>	
	
</td>
<td width="170" valign="top" align="right">
	<cfinclude template="dsp_homepage_Rsidebar.cfm">	
</td>
</tr>

<!--- BOTTOM BAR - Copyright --->
<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_bottombar.cfm">
</td>
</tr>

</table>
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>

</cfoutput>