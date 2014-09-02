<cfparam name="selStatus" default="">
<cfparam name="selPriority" default="">
<cfparam name="sortBy" default="">
<cfparam name="sortDir" default="desc">
<cfset amarCounter = 1>
<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Project?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	</script>

</cfif>


<cfoutput>

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>


<a href="#request.webroot#/admin/dsp_cashproject_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A CASH PROJECT &raquo;</strong></a> &nbsp;&nbsp;&nbsp; 
<a href="#request.webroot#/admin/dsp_cashprojectcat_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=550,height=300,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A CATEGORY &raquo;</strong></a><br>
<br>

</cfif>

</cfoutput>
<cfquery name="amarCatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ProjectCategoryID, Title AS CategoryTitle
FROM ProjectCategories
WHERE GroupID=#GroupID#
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
<cfelse>
	AND Active = 1
</cfif>
ORDER BY Active DESC, displayorder
</cfquery>

<SELECT NAME="selCategory" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Category...
	<cfoutput><OPTION VALUE="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">Show them all!</cfoutput>
	<cfloop query="amarCatDetails">
		<cfoutput>
		<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selCategory=#amarCatDetails.ProjectCategoryID#&groupID=#groupID#">#amarCatDetails.CategoryTitle#
		</cfoutput>
	</cfloop>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selStatus" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Status...
	<cfoutput>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">Show them all!
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=Being Planned&groupID=#groupID#" <cfif selStatus eq "Being Planned">Selected</cfif>>Being Planned</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=Available Now&groupID=#groupID#" <cfif selStatus eq "Available Now">Selected</cfif>>Available Now</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=In progress&groupID=#groupID#" <cfif selStatus eq "In progress">Selected</cfif>>In progress</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=All Done&groupID=#groupID#" <cfif selStatus eq "All Done">Selected</cfif>>All Done</option>
	</cfoutput>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selPriority" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Priority...
	<cfoutput>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">Show them all!
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=High&groupID=#groupID#" <cfif selPriority eq "High">Selected</cfif>>High</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=Normal&groupID=#groupID#" <cfif selPriority eq "Normal">Selected</cfif>>Normal</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=Low&groupID=#groupID#" <cfif selPriority eq "Low">Selected</cfif>>Low</option>
	</cfoutput>
</SELECT>
<p/>

<table width="100%" cellpadding="1" cellspacing="1" border="0">

<cfoutput>
<tr bgcolor="###AllSettings.DkBoxColour#" height="25">
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;" width="*"><b>pID</b></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;padding-left:5px;" width="*"><b>Current Projects</b></td>
<!--- <td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;padding-left:5px;" width="*"><b>Category</b></td> --->
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#&sortBy=category&sortDir=asc"><b>Category</b></a></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#&sortBy=Priority&sortDir=asc"><b>Priority</b></a></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;padding-left:5px;padding-right:5px;" nowrap align="center"><a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#&sortBy=Status&sortDir=asc"><strong>Status</strong></a></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%" style="color:white;" align="center" nowrap><strong>Value</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%" style="color:white;" align="center" nowrap><a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#&sortBy=Paid In&sortDir=asc"><strong>Paid In</strong></a></td>
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><td>&nbsp;</td></cfif>
</tr>
</cfoutput>

<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#>
<!--- <cfoutput query="CatDetails"> --->


<!--- <td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"><b>#TRIM(CategoryTitle)#</b></td>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"> </td>
<td align="center" bgcolor="##EAEAEA" height="12" style="color:###TRIM(AllSettings.DkTextColor)#"><cfif CatDetails.Active EQ 1>Active<cfelse>Inactive</cfif></td>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"> </td>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"> </td> --->
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><tr><td align="right" width="40" bgcolor="##EAEAEA"><a href="#request.webroot#/admin/dsp_cashprojectcat_edit.cfm?projectcategoryID=#CatDetails.projectcategoryID#&documentID=#documentID#" target="editArt" onclick="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=550,height=300,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Category" border="0"></a> <a href="javascript:confirmCategoryDelete('#request.webroot#/admin/act_cashprojectcat_delete.cfm?projectcategoryID=#CatDetails.projectcategoryID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Category" border="0"></a></td></tr></cfif>
<cfset sortCol = "projectID">
<cfif sortBy eq "category">
	<cfset sortCol = "ProjectCategory">
<cfelseif sortBy eq "Priority">
	<cfset sortCol = "Priority">
<cfelseif sortBy eq "Status">
	<cfset sortCol = "CurrentStatus">
<cfelseif sortBy eq "Paid In">
	<cfset sortCol = "PaidIn">
</cfif>
<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT P.ProjectID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered
FROM Projects P INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
WHERE P.ProjectCategoryID in (#ProjectCatIDList#) <!--- #CatDetails.ProjectCategoryID#  --->
<!--- 
SELECT * 
FROM Projects
WHERE Projects.ProjectCategoryID=#CatDetails.ProjectCategoryID#
 --->
<cfif isdefined("url.selStatus")>
	<cfif url.selStatus neq ''>
		and currentstatus='#trim(url.selStatus)#'
	</cfif> 
</cfif>
<cfif isDefined("url.selCategory")>
	<cfif url.selCategory neq ''>
		and P.ProjectCategoryID='#trim(url.selCategory)#'
	</cfif> 
</cfif>
<cfif isDefined("url.selPriority")>
	<cfif url.selPriority neq ''>
		and Priority='#trim(url.selPriority)#'
	</cfif> 
</cfif>
Order by #sortCol# #sortDir#
</cfquery>

<cfoutput query="ProjectDetails">
<cfif amarCounter mod 2 eq 0>
	<tr bgcolor="##EFEFEF">	
<cfelse>
	<tr>
</cfif>
<td nowrap valign="top" align="center">#TRIM(ProjectID)#</td>
<td width="*" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#">#TRIM(ProjectDetails.IntroText)#</a></td>
<td nowrap valign="top" align="center">#TRIM(ProjectCategory)#</td>
<td nowrap valign="top" align="center">#TRIM(Priority)#</td>
<td nowrap valign="top" align="center" style="padding-left:5px;padding-right:5px;"><cfif TRIM(currentstatus) NEQ ''>#TRIM(currentstatus)#<cfelse>&ndash;</cfif></td>
<td nowrap valign="top" align="center"><cftry><cfif PaymentType CONTAINS 'Money'>#DecimalFormat(CreditsOffered)#<cfelse>#INT(CreditsOffered)#</cfif><cfcatch>&ndash;</cfcatch></cftry></td>
<td nowrap valign="top" align="center">#TRIM(PaidIn)#</td>
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><td align="right" width="40"><a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a></td></cfif>
</tr>
<cfset amarCounter = amarCounter + 1>
</cfoutput>

<!--- <tr>
<td <cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>colspan="5"<cfelse>colspan="4"</cfif>>&nbsp;</td>
</tr> --->

<!--- </cfoutput> --->



</table><br><br>
