<cfoutput>
	
<!--- DELETE LINK --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE LinkID=#LibraryLinkID#
	</cfquery>	
	
<cfif #fusesubaction# EQ 'template'>
	
	<cfset calledfrom = 'libraryID=#libraryID#'>


<cfelseif #fusesubaction# EQ 'docs'>

	<cfset calledfrom = 'DocumentID=#DocumentID#'>


<cfelseif #fusesubaction# EQ 'article'>

	<cfset calledfrom = 'DocumentID=#DocumentID#&ArticleID=#ArticleID#'>
	

<cfelseif #fusesubaction# EQ 'subarticle'>

	<cfset calledfrom = 'DocumentID=#DocumentID#&ArticleID=#ArticleID#&subArticleID=#SubArticleID#'>
	

<cfelseif #fusesubaction# EQ 'Level4'>

	<cfset calledfrom = 'DocumentID=#DocumentID#&ArticleID=#ArticleID#&subArticleID=#SubArticleID#&Level4ArticleID=#Level4ArticleID#'>
	

<cfelseif #fusesubaction# EQ 'news_template'>

	<cfset calledfrom = 'NewsID=#NewsID#'>
	

<cfelseif #fusesubaction# EQ 'index'>

	<cfset calledfrom = ''>
	
</cfif>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&#calledfrom#">


</cfoutput>