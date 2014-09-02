<cfoutput>

<script language="JavaScript">
	<!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure want to delete the Skill?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfinclude template="qry_manageskills.cfm">

<cfif IsDefined("URL.suc") and URL.suc eq 1>
      <p style="color: blue;">
	       New Skill is added into site.
	  </p> 
<cfelseif IsDefined("URL.suc") and URL.suc eq 2>
      <p style="color: blue;">
	       Skill has been updated into site.
	  </p> 	 
<cfelseif IsDefined("URL.suc") and URL.suc eq 3>
      <p style="color: blue;">
	       Skill has been deleted into site.
	  </p> 	 	   
<cfelse> 
</cfif>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>Manage Skills</strong></td>
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
<td class="small"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=dspSkillsAdd" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>Add a Skill »</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	<tr>
	<td><span class="normal"><b>ID</b></span></td>
	<td><span class="normal"><b>Skill</b></span></td>
	<td><span class="normal"><b>Keyword</b></span></td>	
	<td align="right"><span class="normal">&nbsp;</span></td>
	</tr>
	
	<cfloop query="allmanageskills">
	<tr>
	<td><span class="normal">#id#</span></td>
	<td><span class="normal">#skillName#</span></td>
	<td><span class="normal">#skillKeyword#</span></td>	
	<td align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=dspSkillsEdit&skillID=#id#" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a>&nbsp;<a 
	href="javascript:confirmAdministratorDelete('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=DeleteSkills&skillID=#id#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
	</tr>
	</cfloop>
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>