<cfoutput>


<cfquery name="AllLevel4Articles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Level4ArticleID, Level4ArticleTitle
FROM Level4Articles
ORDER BY Level4ArticleID DESC
</cfquery>


<cfparam name="CurrentLevel4ArticleLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Level4ArticleID
	FROM LibraryLinks
	WHERE LibraryID=#LibraryID#
	AND Level4ArticleID <> ''
	</cfquery>
	
	<cfset CurrentLevel4ArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentLevel4ArticleLinks= '#CurrentLevel4ArticleLinks#' & ',' & '#CurrentLinks.Level4ArticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Level4ArticleID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND Level4ArticleID <> ''
	</cfquery>
	
	<cfset CurrentLevel4ArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentLevel4ArticleLinks= '#CurrentLevel4ArticleLinks#' & ',' & '#CurrentLinks.Level4ArticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Level4ArticleID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND Level4ArticleID <> ''
	</cfquery>
	
	<cfset CurrentLevel4ArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentLevel4ArticleLinks= '#CurrentLevel4ArticleLinks#' & ',' & '#CurrentLinks.Level4ArticleID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Level4ArticleID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND Level4ArticleID <> ''
	</cfquery>
	
	<cfset CurrentLevel4ArticleLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentLevel4ArticleLinks= '#CurrentLevel4ArticleLinks#' & ',' & '#CurrentLinks.Level4ArticleID#'>
	</cfloop>

</cfif>



<input type="hidden" name="Level4ArticleRecords" value="#AllLevel4Articles.RecordCount#">
<a name="subarticles"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>LEVEL4-ARTICLES</strong></td>
	</tr>
	</table>

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllLevel4Articles">
	<input type="hidden" name="Level4ArticleAssociate#AllLevel4Articles.currentrow#" value="0">
	<input type="hidden" name="Level4ArticleID#AllLevel4Articles.currentrow#" value="#AllLevel4Articles.Level4ArticleID#">
	<tr>
	<td width="35"><input type="checkbox" name="Level4ArticleAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentLevel4ArticleLinks, Level4ArticleID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllLevel4Articles.Level4ArticleTitle#</td>
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