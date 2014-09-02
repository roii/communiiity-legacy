<cfoutput>

<script language="JavaScript">
	<!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Administrator?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfinclude template="qry_administrators.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="page_header">Website Administrators</td>
<td align="right" width="10"><img src="#request.imageroot#/where_icon.gif" width="9" height="15" alt="Membership Directory" border="0"></td>
</tr>

<tr>
<td bgcolor="222222" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small"><a href="#request.webroot#/admin/dsp_administrator_add.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" target="addAdmin" ONCLICK="fdbackwindow=window.open ('','addAdmin','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=240,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD AN ADMNISTRATOR »</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	<tr>
	<td><span class="normal"><b>Name</b></span></td>
	<td><span class="normal"><b>Email Address</b></span></td>
	<td><span class="normal"><b>Password</b></span></td>	
	<td align="right"><span class="normal">&nbsp;</span></td>
	</tr>
	
	<cfloop query="alladministrators">
	<tr>
	<td><span class="normal">#LastName#, #FirstName#</span></td>
	<td><span class="normal">#EmailAddress#</span></td>
	<td><span class="normal">#Password#</span></td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_administrator_edit.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&administratorID=#administratorID#" target="editAdmin" ONCLICK="fdbackwindow=window.open ('','editAdmin','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=240,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a>&nbsp;<a 
	href="javascript:confirmAdministratorDelete('#request.webroot#/admin/act_administrator_delete.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&administratorID=#administratorID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
	</tr>
	</cfloop>
	
	</table>
	
	
<hr width="100%" size="1" color="e2e2e2">
	
	<cfinclude template="dsp_adminlog_table.cfm">
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table></cfoutput>