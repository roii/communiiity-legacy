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


<cfoutput><cfif session.UserIsAuthenticated EQ 'Yes' AND #session.UserType# EQ 'Administrator'>


<a href="#request.webroot#/admin/dsp_cashproject_add.cfm" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A CASH PROJECT »</strong></a> &nbsp;&nbsp;&nbsp; 
<a href="#request.webroot#/admin/dsp_cashprojectcat_add.cfm" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=150,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A CATEGORY »</strong></a><br>
<br>

</cfif>

</cfoutput>



<table width="100%" cellpadding="1" cellspacing="1" border="0">

<tr bgcolor="004080" height="35">
<td style="color:white; line-height:110%" width="*">&nbsp;<b>Current Project Summaries</b></td>
<td style="color:white; line-height:110%" width="50" align="center">Project<br>Status</td>
<td style="color:white; line-height:110%" style="color:white;" align="center" width="100">Cash<br>Offered</td>
<td style="color:white; line-height:110%" width="50" align="center">Current<br>Progress</td>
<td>&nbsp;</td>
</tr>

<cfoutput query="ProjectDetails" group="ProjectCategoryID">
<tr>
<td colspan="4" bgcolor="e3f4f6" height="12"><b>#TRIM(CategoryTitle)#</b></td>
<td align="right" width="40" bgcolor="e3f4f6"><cfif session.UserIsAuthenticated EQ 'Yes' AND #session.UserType# EQ 'Administrator'><a href="#request.webroot#/admin/dsp_cashprojectcat_edit.cfm?projectcategoryID=#ProjectDetails.projectcategoryID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=150,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Category" border="0"></a> <a href="javascript:confirmCategoryDelete('#request.webroot#/admin/act_cashprojectcat_delete.cfm?projectcategoryID=#ProjectDetails.projectcategoryID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Category" border="0"></a></cfif></td>
</tr>
<cfoutput>

<tr>
<td width="*" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&projectmode=template&ProjectCategoryID=#ProjectCategoryID#&ProjectID=#ProjectID#" style="color:blue; text-decoration:underline;">#TRIM(IntroText)#</a></td>
<td width="50" valign="top" align="center"><cfif #TRIM(currentstatus)# NEQ ''>#TRIM(currentstatus)#<cfelse>&ndash;</cfif></td>
<td width="100" valign="top" align="center"><cftry>#DollarFormat(CreditsOffered)#<cfcatch>&ndash;</cfcatch></cftry></td>
<td width="50" valign="top" align="center"><cfif #IsNumeric(percentcomplete)#>#percentcomplete#%<cfelse>&ndash;</cfif></td>
<td align="right" width="40"><cfif session.UserIsAuthenticated EQ 'Yes' AND #session.UserType# EQ 'Administrator'><a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#ProjectDetails.projectID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete.cfm?projectID=#ProjectDetails.projectID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a></cfif></td>
</tr>

<tr>
<td colspan="5"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>
</cfoutput>

</cfoutput>

<tr bgcolor="004080">
<td colspan="5" height="3"> </td>
</tr>

</table><br><br>
