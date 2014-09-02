<cfoutput>
<script language="JavaScript">
	<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles.\nAre you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfquery name="AllSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Sections
WHERE Admin=1
ORDER BY MenuFrenchTitle
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE SECTIONS</strong></td>
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
<td class="small"><!--- <a href="#request.webroot#/admin/dsp_section_add.cfm" target="addArt" onclick="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A SECTION &raquo;</strong></a>

<hr width="100%" size="1" color="##e2e2e2"> --->
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><strong>Menu French Title</strong></td>
	<td><strong>Page French Title</strong></td>
	<td><strong>Viewers</strong></td>
	<td align="right"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="allsections">
	
	<tr>
	<td valign="top">#MenuFrenchTitle#</td>
	<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#allsections.fuseaction#">#FrenchTitle#</a></td>
	<td valign="top"><cfif allsections.AdminView CONTAINS 1>Administrators<br></cfif><cfif allsections.PublicView CONTAINS 1>Public<br></cfif>
	<cfloop list="#AllSections.ContactTypeView#" index="loopitem">
	<cftry><cfquery name="ContactTypeDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactType
	FROM ContactTypes
	WHERE ContactTypeID=#loopitem#
	</cfquery><cfif ContactTypeDetails.RecordCount>#TRIM(ContactTypeDetails.ContactType)#<br></cfif><cfcatch></cfcatch></cftry></cfloop></td>
	<td align="right" valign="top"><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#allsections.sectionID#&fuseaction=administration&fusesubaction=#attributes.fusesubaction#" target="editsection" onclick="fdbackwindow=window.open ('','editsection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Section" border="0"></a>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#allsections.sectionID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Section" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="9" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	

</td>
</tr>

</table>


</cfoutput>