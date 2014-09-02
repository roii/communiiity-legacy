<cfif isdefined("attributes.level4articleID")>

	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE level4articleID = #attributes.level4articleID#	
	</cfquery>
	
	
<cfelseif isdefined("attributes.subarticleID")>

	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE SubArticleID = #attributes.SubArticleID#	
	</cfquery>
	

<cfelseif isdefined("attributes.articleID")>

	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE ArticleID = #attributes.ArticleID#	
	</cfquery>
	
	
<cfelseif isdefined("attributes.documentID")>
	
	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE DocumentID = #attributes.DocumentID#	
	</cfquery>
	
	
<cfelseif isdefined("attributes.newsID")>
	
	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE NewsID = #attributes.NewsID#
	</cfquery>
	
	
<cfelseif isdefined("attributes.LibraryID")>
	
	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE LibraryID = #attributes.LibraryID#
	</cfquery>
	
	
<cfelseif isdefined("sectionDetails.SectionID") and sectionDetails.SectionID neq ''>
	
	<cfquery name="librarylinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM LibraryLinks
	WHERE SectionID = #sectionDetails.SectionID#
	</cfquery>

	
</cfif>