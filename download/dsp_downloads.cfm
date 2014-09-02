<cfoutput>


 <cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmDownloadDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Library File?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmLibraryCatDelete(aURL) {
	    if(confirm('Deleting a Library Category also deletes any linked Files. Are you sure you want to delete this library Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">
		
<table border="0" cellpadding="0" cellspacing="2" width="100%">
		
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;">#SectionDetails.Title#</a></td>
<td align="right" width="30"> </td>
</tr>


</table>

</cfoutput><br>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<cfoutput>
		<tr>
		<td class="small" colspan="2"><a href="#request.webroot#/admin/dsp_LibraryCat_add.cfm?fuseaction=#fuseaction#" target="addLibraryCat" ONCLICK="fdbackwindow=window.open ('','addLibraryCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A LIBRARY CATEGORY »</strong></a> &nbsp;&nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_file_add.cfm?fuseaction=#fuseaction#" target="addFile" ONCLICK="fdbackwindow=window.open ('','addFile','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>UPLOAD A FILE »</strong></a><br><br></td>
		</tr>
		</cfoutput>
</cfif>
	
	

<cfoutput query="DownloadCats" group="LibraryCatID">
<TR>
<td><ul><li class="normal" style="color:#TRIM(sectionDetails.barColor)#;"><a href="###LibraryCatTitle#" style="color:gray;">#LibraryCatTitle#</a></td>
<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<td align="right"><a href="#request.webroot#/admin/dsp_librarycat_edit.cfm?LibraryCatID=#LibraryCatID#" target="editEventCat" ONCLICK="fdbackwindow=window.open ('','editEventCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a> <a href="javascript:confirmLibraryCatDelete('#request.webroot#/admin/act_LibraryCat_delete.cfm?LibraryCatID=#LibraryCatID#&caller=downloads')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Category" border="0"></a></td>
</cfif>
</tr>
</cfoutput>
</table>

<cfoutput><br>
<img src="#request.imageroot#/transparent_spc.gif" width="5" height="6" border="0"><br>
</cfoutput>

<table width="100%" border="0" cellspacing="2" cellpadding="0">
	
	
<cfoutput query="DownloadCats" group="LibraryCatID">

<a name="#LibraryCatTitle#"> </a>
<table width="100%" cellpadding="0" cellspacing="2" border="0">
<tr>
<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="FF3300"</cfif> width="17">

	<table width="17" cellpadding="1" cellspacing="0" border="0">
	<tr>
	<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
	</tr>
	</table>

</td>
<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif>>

	<table width="100%" cellpadding="1" cellspacing="0" border="0">
	<tr>
	<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1" border="0"></td>
	<td><span class="small" style="letter-spacing:.2em; color:white;"><b>#UCASE(LibraryCatTitle)#</b></span></td>
	</tr>
	</table>

</td>
</tr>

<cfquery name="LibraryDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM Library		
WHERE LibraryCatID=#LibraryCatID#

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>
	
AND (DateExpires > #now()# 
OR DateExpires IS NULL)
</cfif>
ORDER BY DisplayOrder
</cfquery>


<tr>
<td>&nbsp;</td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"><br>

	<cfloop query="LibraryDetails">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	<td class="normal">

	<hr width="100%" size="1" color="Silver">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td width="40" valign="top"><a href="#request.webroot#/download/files/#filename#" target="_Blank"><img src="#request.imageroot#/download_icon.gif" width="13" height="13" alt="Download Now" border="0" align="absmiddle"></a>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=template&libraryID=#recordid#"><img src="#request.imageroot#/icon_question.gif" width="13" height="13" alt="Details" border="0" align="absmiddle"></a></td>
		<td><span class="normal"><b>#Title#</b></span>
		
		<hr width="100%" size="1" color="Silver">
	
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
			<td width="33%"><span class="small" style="color:gray;"><b>Published:</b> #Dateformat(DateUploaded, "d/mm/yy")#</td>
			<td width="33%"><span class="small" style="color:gray;"><b>Format:</b> #FileFormat#</span></td>
			<td width="33%"><span class="small" style="color:gray;"><b>File Size:</b> #int(Filesize/1000)#k</span></td>
			<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
				<td align="right" valign="top" width="28"><img src="#request.imageroot#/transparent_spc.gif" width="28" height="1" border="0"><br><a href="#request.webroot#/admin/dsp_file_edit.cfm?LibraryID=#recordid#&fuseaction=#fuseaction#" target="editFile" ONCLICK="fdbackwindow=window.open ('','editFile','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit File" border="0"></a> <a href="javascript:confirmDownloadDelete('#request.webroot#/admin/act_file_delete.cfm?LibraryID=#RecordID#&caller=downloads')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Event" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=download&LibraryID=#recordID#&fuseaction=#attributes.fuseaction#&fusesubaction=#attributes.fusesubaction#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
			</cfif>
			</tr>
			
			
			<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
			<tr>
			<td colspan="4"><a href="#request.webroot#/download/files/#filename#" target="_Blank">#request.webroot#/download/files/#filename#</a></td>
			</tr>
			</cfif>
			
			</table>
		
		</td>
		</tr>
		</table>
		
	
		
		<hr width="100%" size="1" color="Silver">
				
	</td>
	</tr>

		
	<tr>
	<td height="1" colspan="2"><img src="#request.imageroot#/transperant_spc.gif" width="1" height="15" border="0"></td>
	</tr>
	</table>

	</cfloop>	

</td>
</tr>
</table><br>



</cfoutput>