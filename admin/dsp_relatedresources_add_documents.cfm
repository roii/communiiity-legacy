<cfoutput>


<cfquery name="AllDocuments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT DocumentID, Title
FROM Documents
ORDER BY Title
</cfquery>


<cfparam name="CurrentDocumentLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM LibraryLinks
	WHERE LibraryID=#LibraryID#
	AND DocumentID <> ''
	</cfquery>
	
	<cfset CurrentDocumentLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDocumentLinks= '#CurrentDocumentLinks#' & ',' & '#CurrentLinks.DocumentID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND DocumentID <> ''
	</cfquery>
	
	<cfset CurrentDocumentLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDocumentLinks= '#CurrentDocumentLinks#' & ',' & '#CurrentLinks.DocumentID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND DocumentID <> ''
	</cfquery>
	
	<cfset CurrentDocumentLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDocumentLinks= '#CurrentDocumentLinks#' & ',' & '#CurrentLinks.DocumentID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND DocumentID <> ''
	</cfquery>
	
	<cfset CurrentDocumentLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDocumentLinks= '#CurrentDocumentLinks#' & ',' & '#CurrentLinks.DocumentID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND DocumentID <> ''
	</cfquery>
	
	<cfset CurrentDocumentLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentDocumentLinks= '#CurrentDocumentLinks#' & ',' & '#CurrentLinks.DocumentID#'>
	</cfloop>

</cfif>



<input type="hidden" name="DocumentRecords" value="#AllDocuments.RecordCount#">
<a name="documents"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>DOCUMENTS</strong></td>
	</tr>
	</table>

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllDocuments">
	<input type="hidden" name="DocumentAssociate#AllDocuments.currentrow#" value="0">
	<input type="hidden" name="DocumentID#AllDocuments.currentrow#" value="#AllDocuments.DocumentID#">
	<tr>
	<td><input type="checkbox" name="DocumentAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentDocumentLinks, DocumentID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllDocuments.Title#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>

	</cfloop>
	
	<tr>
	<td colspan="2"><input type="submit" class="whitefield" value="UPDATE RELATED LINKS >>>"> &nbsp; <input type="button" class="whitefield" value=":: CLOSE ::" onclick="javascript:window.close();">
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</table>



</td>
</tr>


</table>


</cfoutput>