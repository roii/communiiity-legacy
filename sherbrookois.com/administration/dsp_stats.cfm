<cfoutput>

<cfquery name="BaseSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Fuseaction, Title
FROM Sections
WHERE MainMenu=1
ORDER BY Fuseaction
</cfquery>

<cfparam name="LogMode" default="Search">
<cfparam name="LogPeriod" default="0">
<cfparam name="SiteArea" default="All">
<cfparam name="Status" default="All">


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="section_subheader" width="100%">#TRIM(SectionDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>


<tr>
<td class="section_header" width="100%">Website Statistics</td>
<td align="right" width="30"> </td>
</tr>


</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
<form method="post" action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&LogMode=results">

<tr>
<td><select name="LogPeriod" class="whitefield">
<option value="1"<cfif #LogPeriod# EQ '1'> selected</cfif>>TODAY</option>
<option value="7"<cfif #LogPeriod# EQ '7'> selected</cfif>>Last 7 days</option>
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