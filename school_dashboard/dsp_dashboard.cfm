<cfoutput>

<cfquery name="SchoolStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Schools
WHERE SchoolID=#session.User_SchoolID#
</cfquery>

<table width="100%" cellpadding="0" cellspacing="10" border="0">


<cfif fileExists("#request.fileroot#\images\schools\#TRIM(SchoolStuff.LogoFile)#")>
<tr>
<td colspan="2" align="center"><img src="#request.imageroot#/schools/#TRIM(SchoolStuff.LogoFile)#" border="0"><br></td>
</tr>
</cfif>

<tr>
<td colspan="2" style="font-size:14px;color:black;" align="center">
<hr width="100%" size="1" color="b4b4b4">
<strong>#TRIM(session.User_SchoolName)# #TRIM(allsettings.SiteName)# Dashboard</strong>
<hr width="100%" size="1" color="b4b4b4">
</td>
</tr>


<tr>
<td width="50%" valign="top">
	<cfinclude template="dsp_dash_community.cfm">
	<br>
	<cfinclude template="dsp_dash_business.cfm">
	<br>
	<cfinclude template="dsp_dash_ideas.cfm">
	<br>
	<cfinclude template="dsp_dash_projects.cfm">
</td>
<td width="50%" valign="top">
	<cfinclude template="dsp_dash_goals.cfm">
	<br>
	<cfinclude template="dsp_dash_points.cfm">
	<br>
	<cfinclude template="dsp_dash_rewards.cfm">
	<br>
	<cfinclude template="dsp_dash_feedback.cfm">
</td>
</tr>

<tr>
<td colspan="2"><cfinclude template="dsp_dash_benchmark.cfm"></td>
</tr>

</table>


</cfoutput>