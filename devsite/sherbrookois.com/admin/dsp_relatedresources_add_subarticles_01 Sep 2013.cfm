<cfoutput>


<cfquery name="AllSubArticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SubArticleID, SubArticleTitle
FROM SubArticles
ORDER BY SubArticleTitle
</cfquery>


<cfparam name="CurrentSubArticleLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubarticleID
	FROM LibraryLinks
	WHERE LibraryID=#LibraryID#
	AND SubarticleID <> ''
	</cfquery>
	
	<cfset CurrentSubArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentSubArticleLinks= '#CurrentSubArticleLinks#' & ',' & '#CurrentLinks.SubarticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubarticleID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND SubarticleID <> ''
	</cfquery>
	
	<cfset CurrentSubArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentSubArticleLinks= '#CurrentSubArticleLinks#' & ',' & '#CurrentLinks.SubarticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubarticleID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND SubarticleID <> ''
	</cfquery>
	
	<cfset CurrentSubArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentSubArticleLinks= '#CurrentSubArticleLinks#' & ',' & '#CurrentLinks.SubarticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubarticleID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND SubarticleID <> ''
	</cfquery>
	
	<cfset CurrentSubArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentSubArticleLinks= '#CurrentSubArticleLinks#' & ',' & '#CurrentLinks.SubarticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubarticleID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND SubarticleID <> ''
	</cfquery>
	
	<cfset CurrentSubArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentSubArticleLinks= '#CurrentSubArticleLinks#' & ',' & '#CurrentLinks.SubarticleID#'>
	</cfloop>

</cfif>



<input type="hidden" name="SubArticleRecords" value="#AllSubArticles.RecordCount#">
<a name="subarticles"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>SUB-ARTICLES</strong></td>
	</tr>
	</table>
	
	

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllSubArticles">
	<input type="hidden" name="SubArticleAssociate#AllSubArticles.currentrow#" value="0">
	<input type="hidden" name="SubArticleID#AllSubArticles.currentrow#" value="#AllSubArticles.SubArticleID#">
	<tr>
	<td width="35"><input type="checkbox" name="SubArticleAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentSubArticleLinks, SubArticleID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllSubArticles.SubArticleTitle#</td>
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