<cfoutput>


<cfquery name="AllArticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ArticleID, ArticleTitle
FROM Articles
ORDER BY ArticleID DESC
</cfquery>


<cfparam name="CurrentArticleLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE LibraryID=#LibraryID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'docs'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT articleID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND articleID <> ''
	</cfquery>
	
	<cfset CurrentArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentArticleLinks= '#CurrentArticleLinks#' & ',' & '#CurrentLinks.articleID#'>
	</cfloop>

</cfif>



<input type="hidden" name="articleRecords" value="#AllArticles.RecordCount#">
<a name="articles"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">


	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>ARTICLES</strong></td>
	</tr>
	</table>




<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllArticles">
	<input type="hidden" name="ArticleAssociate#AllArticles.currentrow#" value="0">
	<input type="hidden" name="ArticleID#AllArticles.currentrow#" value="#AllArticles.ArticleID#">
	<tr>
	<td><input type="checkbox" name="ArticleAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentArticleLinks, ArticleID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllArticles.ArticleTitle#</td>
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