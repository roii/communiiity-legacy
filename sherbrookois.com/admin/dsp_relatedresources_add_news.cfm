<cfoutput>


<cfquery name="AllNews" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT RecordID, Title
FROM News
ORDER BY ReleasedDate DESC
</cfquery>

<cfparam name="CurrentNewsLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'docs'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsID
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	AND NewsID <> ''
	</cfquery>
	
	<cfset CurrentNewsLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentNewsLinks= '#CurrentNewsLinks#' & ',' & '#CurrentLinks.NewsID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND NewsID <> ''
	</cfquery>
	
	<cfset CurrentNewsLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentNewsLinks= '#CurrentNewsLinks#' & ',' & '#CurrentLinks.NewsID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND NewsID <> ''
	</cfquery>
	
	<cfset CurrentNewsLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentNewsLinks= '#CurrentNewsLinks#' & ',' & '#CurrentLinks.NewsID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsID
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	AND NewsID <> ''
	</cfquery>
	
	<cfset CurrentNewsLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentNewsLinks= '#CurrentNewsLinks#' & ',' & '#CurrentLinks.NewsID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND NewsID <> ''
	</cfquery>
	
	<cfset CurrentNewsLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentNewsLinks= '#CurrentNewsLinks#' & ',' & '#CurrentLinks.NewsID#'>
	</cfloop>

</cfif>




<input type="hidden" name="NewsRecords" value="#AllNews.RecordCount#">
<a name="news"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>MEDIA RELEASES</strong></td>
	</tr>
	</table>
	
	

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllNews">
	<input type="hidden" name="NewsAssociate#AllNews.currentrow#" value="0">
	<input type="hidden" name="NewsID#AllNews.currentrow#" value="#AllNews.RecordID#">
	<tr>
	<td><input type="checkbox" name="NewsAssociate#currentrow#" value="1" class="whitefield"<cfif #ListFind(CurrentNewsLinks, AllNews.RecordID, ',')#> checked</cfif>></td>
	<td class="normal" width="100%">#AllNews.Title#</td>
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