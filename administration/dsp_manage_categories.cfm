<cfoutput>

<cfquery name="qry_groups" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY ProjectCategoryID
</cfquery>


<script language="JavaScript">
<!--
function confirmGroupDelete(aURL) {
    if(confirm('Are you sure you want to delete this Category?')) {
      location.href = aURL;
    }
  }
//-->
</script>

	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>Manage Categories</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><a href="#request.webroot#/admin/dsp_cashprojectcat_add_manage.cfm" target="addGroup" onclick="fdbackwindow=window.open ('','addGroup','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=200,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD Category &raquo;</strong></a>

	<hr width="100%" size="1" color="e2e2e2">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td><b>Category Name</b></td>
	<td align="center"><b>Project Category ID</b></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_groups">
	
	<tr>
	<td>#TRIM(qry_groups.title)#</td>
	<td align="center">#qry_groups.ProjectCategoryID#</td>
	<td align="right"><a href="#request.webroot#/admin/dsp_cashprojectcat_edit_manage.cfm?ProjectCategoryID=#qry_groups.ProjectCategoryID#" target="EditGroup" onclick="fdbackwindow=window.open ('','EditGroup','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=200,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Group" border="0"></a>&nbsp;<a href="javascript:confirmGroupDelete('#request.webroot#/admin/act_delete_projectgroup_manage.cfm?ProjectCategoryID=#qry_groups.ProjectCategoryID#')"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Group" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>	
	
	
	</table>


</td>
</tr>

</table>

</cfoutput>