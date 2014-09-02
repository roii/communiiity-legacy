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



<table width="100%" cellpadding="1" cellspacing="1" border="0">

<cfoutput>
<tr bgcolor="###AllSettings.DkBoxColour#" height="25">
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;padding-left:5px;" width="*"><b>Current Projects</b></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%;padding-left:5px;padding-right:5px;" nowrap align="center"><strong>Status</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%" style="color:white;" align="center" nowrap><strong>Value</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#; line-height:110%" style="color:white;" align="center" nowrap><strong>Paid In</strong></td>
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><td>&nbsp;</td></cfif>
</tr>
</cfoutput>


<cfoutput query="CatDetails">

<tr>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"><b>#TRIM(CategoryTitle)#</b></td>
<td align="center" bgcolor="##EAEAEA" height="12" style="color:###TRIM(AllSettings.DkTextColor)#"><cfif CatDetails.Active EQ 1>Active<cfelse>Inactive</cfif></td>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"> </td>
<td bgcolor="##EAEAEA" height="22" style="color:###TRIM(AllSettings.DkTextColor)#"> </td>
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><td align="right" width="40" bgcolor="##EAEAEA"><a href="#request.webroot#/admin/dsp_cashprojectcat_edit.cfm?projectcategoryID=#CatDetails.projectcategoryID#&documentID=#documentID#" target="editArt" onclick="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=550,height=300,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Category" border="0"></a> <a href="javascript:confirmCategoryDelete('#request.webroot#/admin/act_cashprojectcat_delete.cfm?projectcategoryID=#CatDetails.projectcategoryID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Category" border="0"></a></td></cfif>
</tr>


<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM Projects
WHERE Projects.ProjectCategoryID=#CatDetails.ProjectCategoryID#
</cfquery>

<cfloop query="ProjectDetails">
<tr>
<td width="*" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#">#TRIM(ProjectDetails.IntroText)#</a></td>
<td nowrap valign="top" align="center" style="padding-left:5px;padding-right:5px;"><cfif TRIM(ProjectDetails.currentstatus) NEQ ''>#TRIM(ProjectDetails.currentstatus)#<cfelse>&ndash;</cfif></td>
<td nowrap valign="top" align="center"><cftry><cfif projectDetails.PaymentType CONTAINS 'Money'>#DecimalFormat(ProjectDetails.CreditsOffered)#<cfelse>#INT(ProjectDetails.CreditsOffered)#</cfif><cfcatch>&ndash;</cfcatch></cftry></td>
<td nowrap valign="top" align="center">#TRIM(ProjectDetails.PaidIn)#</td>
<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'><td align="right" width="40"><a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a></td></cfif>
</tr>
</cfloop>

<tr>
<td <cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>colspan="5"<cfelse>colspan="4"</cfif>>&nbsp;</td>
</tr>

</cfoutput>



</table><br><br>
