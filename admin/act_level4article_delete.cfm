	<!--- GET ART INFO FOR LOG --->
	
	<cfquery name="Level4ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Level4ArticleTitle
	FROM Level4Articles
	WHERE Level4ArticleID=#Level4ArticleID#
	</cfquery>
	
	
<!--- DELETE ARTICLE --->
	
	<cfquery name="DeleteLevel4Article" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Level4Articles
	WHERE Level4ArticleID=#Level4ArticleID#
	</cfquery>
	
	
<!--- DELETE LINK --->
	
	<cfquery name="DeleteLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SubArticleLevel4Link
	WHERE Level4ArticleID=#Level4ArticleID#
	</cfquery>
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE Level4ArticleID=#Level4ArticleID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Level4ArticleID=#Level4ArticleID#
	</cfquery>
	
		
	
	<cfset logdetails = 'Delete Level4 Article - (Article: #Level4ArtStuff.Level4Articletitle#)'>
	<cfinclude template="act_adminlog.cfm">


<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=subarticle&DocumentID=#DocumentID#&articleID=#articleID#&subarticleID=#subarticleID#">