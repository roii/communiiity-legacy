<cfoutput>

<script language="JavaScript">
	<!--
	function confirmFileDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Download ?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfquery name="AllLibraryFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Library.LibraryID, Library.Title, Library.FileSize, LibraryCats.LibraryCatTitle
FROM Library, LibraryCats
WHERE LibraryCats.LibraryCatID=Library.LibraryCatID
ORDER BY LibraryCats.DisplayOrder
</cfquery>

<cfparam name="CurrentDownloadLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'index'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE SectionID=#SectionID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>
	
	


<cfelseif #fusesubaction# EQ 'docs'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LibraryID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND LibraryID <> ''
	</cfquery>
	
	<cfset CurrentDownloadLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDownloadLinks= '#CurrentDownloadLinks#' & ',' & '#CurrentLinks.LibraryID#'>
	</cfloop>

</cfif>



<input type="hidden" name="DownloadRecords" value="#AllLibraryFiles.RecordCount#">

</cfoutput>

<a name="downloads"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></cfoutput></td>
<td class="normal" valign="top">

	<cfoutput>
	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>FILE DOWNLOADS</strong> - <a href="#request.webroot#/admin/dsp_file_upload.cfm?fuseaction=#fuseaction#&fusesubaction=#attributes.fusesubaction#<cfif IsDefined("attributes.sectionID")>&sectionID=#attributes.sectionID#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.articleID")>&articleID=#attributes.articleID#</cfif><cfif IsDefined("attributes.subarticleID")>&subarticleID=#attributes.subarticleID#</cfif><cfif IsDefined("attributes.newsID")>&newsID=#attributes.newsID#</cfif><cfif IsDefined("attributes.eventID")>&eventID=#attributes.eventID#</cfif><cfif IsDefined("attributes.LibraryID")>&LibraryID=#attributes.LibraryID#</cfif>" target="uploadFile" ONCLICK="fdbackwindow=window.open ('','uploadFile','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=20,left=20')" style="color:red; text-decoration:none;"><strong>Upload File >></strong></a></td>
	</tr>
	</table>
	</cfoutput>

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></cfoutput></td>
	<td></td>
	<td></td>
	<td></td>
	</tr>
	
	<cfoutput query="AllLibraryFiles" group="LibraryCatTitle">
	
	<tr>
	<td colspan="4"><strong><br>#AllLibraryFiles.LibraryCatTitle#</strong><br><br></td>
	</tr>
	
	<cfoutput>
	<input type="hidden" name="DownloadAssociate#AllLibraryFiles.currentrow#" value="0">
	<input type="hidden" name="DownloadID#AllLibraryFiles.currentrow#" value="#AllLibraryFiles.LibraryID#">
	<tr>
	<td><input type="checkbox" name="DownloadAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentDownloadLinks, LibraryID, ',')#> checked</cfif>></td>
	<td class="normal">#AllLibraryFiles.Title#</td>
	<td width="80"><cfif IsNumeric(#AllLibraryFiles.FileSize#)>#INT(AllLibraryFiles.FileSize /1024)# k</cfif> </td>
	<td width="40" align="right"><a href="#request.webroot#/admin/dsp_file_edit.cfm?libraryID=#LibraryID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&caller=relatedresources<cfif IsDefined("attributes.sectionID")>&sectionID=#attributes.sectionID#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.articleID")>&articleID=#attributes.articleID#</cfif><cfif IsDefined("attributes.subarticleID")>&subarticleID=#attributes.subarticleID#</cfif><cfif IsDefined("attributes.newsID")>&newsID=#attributes.newsID#</cfif><cfif IsDefined("attributes.eventID")>&eventID=#attributes.eventID#</cfif>" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=20,left=20')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This File" border="0"> <a href="javascript:confirmFileDelete('#request.webroot#/admin/act_file_delete.cfm?libraryID=#LibraryID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&caller=relatedresources<cfif IsDefined("attributes.sectionID")>&sectionID=#attributes.sectionID#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.articleID")>&articleID=#attributes.articleID#</cfif><cfif IsDefined("attributes.subarticleID")>&subarticleID=#attributes.subarticleID#</cfif><cfif IsDefined("attributes.newsID")>&newsID=#attributes.newsID#</cfif><cfif IsDefined("attributes.eventID")>&eventID=#attributes.eventID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This File" border="0"></a></td>
	</tr>	
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="silver"></td>
	</tr>
	</cfoutput>
	</cfoutput>
	
	
	<cfoutput>
	<tr>
	<td colspan="4"><input type="submit" class="whitefield" value="UPDATE RELATED LINKS >>>"> &nbsp; <input type="button" class="whitefield" value=":: CLOSE ::" onclick="javascript:window.close();">
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	</cfoutput>
	</table>



</td>
</tr>


</table>
