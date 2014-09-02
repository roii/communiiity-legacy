<cfoutput>

<cfquery name="BaseSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Fuseaction, Title
FROM dbo.Sections
WHERE MainMenu=1
ORDER BY Fuseaction
</cfquery>

<cfparam name="LogMode" default="Search">
<cfparam name="LogPeriod" default="0">
<cfparam name="SiteArea" default="All">
<cfparam name="Status" default="All">


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="page_header">Website Statistics</td>
<td align="right" width="10"><img src="#request.imageroot#/where_icon.gif" width="9" height="15" alt="Membership Directory" border="0"></td>
</tr>

<tr>
<td bgcolor="222222" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
<form method="post" action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&LogMode=results">

<tr>
<td><select name="LogPeriod" class="whitefield">
<option value="1"<cfif #LogPeriod# EQ '1'> selected</cfif>>TODAY</option>
<option value="30"<cfif #LogPeriod# EQ '30'> selected</cfif>>Last 30 days</option>
<option value="61"<cfif #LogPeriod# EQ '61'> selected</cfif>>Last 2 months</option>
<option value="92"<cfif #LogPeriod# EQ '92'> selected</cfif>>Last 3 months</option>
<option value="122"<cfif #LogPeriod# EQ '122'> selected</cfif>>Last 4 months</option>
<option value="153"<cfif #LogPeriod# EQ '153'> selected</cfif>>Last 5 months</option>
<option value="183"<cfif #LogPeriod# EQ '183'> selected</cfif>>Last 6 months</option>
<option value="365"<cfif #LogPeriod# EQ '365'> selected</cfif>>Last 12 months</option>
</select> <select name="SiteArea" class="whitefield">
<option value="All"<cfif #sitearea# EQ 'All'> selected</cfif>>WHOLE SITE</option>
<cfloop query="BaseSections">
<option value="#BaseSections.Fuseaction#"<cfif #sitearea# EQ '#BaseSections.Fuseaction#'> selected</cfif>>#BaseSections.Title#</option>
</cfloop>
</select> <select name="Status" class="whitefield">
<option value="All"<cfif #Status# EQ 'All'> selected</cfif>>ALL VISITORS</option>
<option value="Members"<cfif #Status# EQ 'Members'> selected</cfif>>Members</option>
<option value="NonMembers"<cfif #Status# EQ 'NonMembers'> selected</cfif>>Non-members</option>
</select> <input type="submit" class="whitefield" value=">>"></td>
</tr>

</form>

</table>

<hr width="100%" size="1" color="e2e2e2">

<cfif #LogMode# EQ 'results'>
	
	<cfinclude template="qry_accessLog_results.cfm">
	<cfinclude template="dsp_accessLog_results.cfm">
	
</cfif>


</cfoutput>