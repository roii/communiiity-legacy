<cfoutput>


<cfquery name="AllLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT LinkID, Title
FROM Links
ORDER BY Title
</cfquery>

<cfparam name="CurrentWebLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'docs'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT WebLinkID
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	AND WebLinkID <> ''
	</cfquery>
	
	<cfset CurrentWebLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentWebLinks= '#CurrentWebLinks#' & ',' & '#CurrentLinks.WebLinkID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT WebLinkID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND WebLinkID <> ''
	</cfquery>
	
	<cfset CurrentWebLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentWebLinks= '#CurrentWebLinks#' & ',' & '#CurrentLinks.WebLinkID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT WebLinkID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND WebLinkID <> ''
	</cfquery>
	
	<cfset CurrentWebLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentWebLinks= '#CurrentWebLinks#' & ',' & '#CurrentLinks.WebLinkID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT WebLinkID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND WebLinkID <> ''
	</cfquery>
	
	<cfset CurrentWebLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentWebLinks= '#CurrentWebLinks#' & ',' & '#CurrentLinks.WebLinkID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT WebLinkID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND WebLinkID <> ''
	</cfquery>
	
	<cfset CurrentWebLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentWebLinks= '#CurrentWebLinks#' & ',' & '#CurrentLinks.WebLinkID#'>
	</cfloop>

</cfif>



<input type="hidden" name="WebLinkRecords" value="#AllLinks.RecordCount#">
<a name="links"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>WEB LINKS</strong></td>
	</tr>
	</table>
	
	

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllLinks">
	<input type="hidden" name="WebLinkAssociate#AllLinks.currentrow#" value="0">
	<input type="hidden" name="LinkID#AllLinks.currentrow#" value="#AllLinks.LinkID#">
	<tr>
	<td><input type="checkbox" name="WebLinkAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentWebLinks, LinkID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllLinks.Title#</td>
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