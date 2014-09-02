 <cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles.\nAre you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>
 
 <cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">




<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
<td align="right" width="30" height="20"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onclick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
</tr>

<!---<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2" width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>--->

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
	
	
	<tr>
	<td colspan="2">#TRIM(sectiondetails.details)#</td>
	</tr>

</cfif>


</table>


</cfoutput>