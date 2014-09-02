<cfoutput>

<script language="JavaScript">
	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmFileDelete(aURL) {
	    if(confirm('Are you sure you want to delete this file?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>
	
	

<cfquery name="DownloadCats" datasource="#dsn#">
SELECT *
FROM LibraryCats
ORDER BY DisplayOrder
</cfquery>
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(session.AllSettings_DkTextColor)#" height="20"><strong>MANAGE DOWNLOADS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<a href="#request.webroot#/admin/dsp_add_filecat.cfm" target="AddCharity" onclick="fdbackwindow=window.open ('','AddCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(session.AllSettings_BoxColour)#; text-decoration:none;"><strong>ADD A CATEGORY &raquo;</strong></a> &nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_file_add.cfm" target="AddFile" onclick="fdbackwindow=window.open ('','AddFile','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(session.AllSettings_BoxColour)#; text-decoration:none;"><strong>ADD A FILE &raquo;</strong></a><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<cfloop query="DownloadCats">
	<cfset this_LibraryCatID = DownloadCats.LibraryCatID>
	<cfset this_LibraryCatTitle = DownloadCats.LibraryCatTitle>
	
	
	<cfquery name="qry_all_files" datasource="#dsn#">
	SELECT *
	FROM Library
	WHERE LibraryCatID=#this_LibraryCatID#
	</cfquery>
	
	<tr>
	<td bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20" style="color:white;padding:3px;"><strong>#TRIM(this_LibraryCatTitle)#</strong></td>
	<td bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20" style="color:white;padding:3px;" align="right"><a href="#request.webroot#/admin/dsp_FileCat_edit.cfm?LibraryCatID=#this_LibraryCatID#" target="editsection" onclick="fdbackwindow=window.open ('','editsection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a>&nbsp;<a href="javascript:confirmCategoryDelete('#request.webroot#/admin/act_FileCat_delete.cfm?LibraryCatID=#this_LibraryCatID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Category" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td colspan="2" style="color:white;padding:3px;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">	
		
		<cfloop query="qry_all_files">
		
		<cfset this_LibraryID=qry_all_files.LibraryID>
		<cfset this_title=qry_all_files.Title>
		<cfset this_FileSize=qry_all_files.FileSize>
		<cfset this_Filename=qry_all_files.Filename>
		
		<tr>
		<td>#TRIM(this_title)#<br> 
		<a href="#request.webroot#/download/files/#this_Filename#" target="_Blank">#request.webroot#/download/files/#this_Filename#</a></td>
		<td>#TRIM(this_FileSize)#kb</td>	
		<td align="right"><a href="#request.webroot#/admin/dsp_File_edit.cfm?LibraryID=#this_LibraryID#" target="editfile" onclick="fdbackwindow=window.open ('','editfile','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit File" border="0"></a>&nbsp;<a href="javascript:confirmFileDelete('#request.webroot#/admin/act_File_delete.cfm?LibraryID=#this_LibraryID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete File" border="0"></a></td>
		</tr>
	
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		</cfloop>	
		</table>	
			
		
	</td>
	</tr>
	
	</cfloop>	
	</table>


</td>
</tr>

</table>


</cfoutput>