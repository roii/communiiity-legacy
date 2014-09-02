	<!--- GET ART INFO FOR LOG --->
	
	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleTitle
	FROM Articles
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	
	<!--- DELETE ARTICLE --->
	
	<cfquery name="DeleteArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Articles
	WHERE ArticleID = #ArticleID#
	</cfquery>
	
	
	<!--- DELETE LINK --->
	<cfquery name="DeleteLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM DocumentArticles_Link
	WHERE ArticleID = #ArticleID#
	</cfquery>
	
	
	<!--- DELETE LINKED SUBARTICLES --->
	<cfquery name="AllSubarticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubArticleID
	FROM ArticleSubArticle_Link
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	<cfloop query="AllSubarticles">
	
		<!--- DELETE LINKED LEVEL4 ARTICLES --->
		<cfquery name="AllLevel4articles" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Level4ArticleID
		FROM SubArticleLevel4Link
		WHERE SubArticleID=#AllSubarticles.SubArticleID#
		</cfquery>
	
		<cfloop query="AllLevel4articles">
	
			<cfquery name="deleteLevel4" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM level4articles
			WHERE Level4articleID=#AllLevel4articles.Level4articleID#
			</cfquery>
		
			<!--- DELETE ANY LINKS --->
	
			<cfquery name="DeleteSubLibraryLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM LibraryLinks
			WHERE Level4articleID=#AllLevel4articles.Level4articleID#
			</cfquery>
	
	
			<!--- DELETE WHATS NEW --->
	
			<cfquery name="DeleteSubwhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM WhatsNew
			WHERE Level4articleID=#AllLevel4articles.Level4articleID#
			</cfquery>
	
		</cfloop>
			
			
	
		<cfquery name="deleteSubs" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM SubArticles
		WHERE SubArticleID=#AllSubarticles.SubArticleID#
		</cfquery>
		
		<!--- DELETE ANY LINKS --->

		<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE SubArticleID=#AllSubarticles.SubArticleID#
		</cfquery>
	
	
		<!--- DELETE WHATS NEW --->
	
		<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM WhatsNew
		WHERE Type='content'
		AND Details='SubArt'
		AND RelatedID=#AllSubarticles.SubArticleID#
		</cfquery>
	
	</cfloop>
	
	
	<cfquery name="deleteSubLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ArticleSubArticle_Link
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	
	<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	
	
	<!--- GET DOC INFO FOR LOG --->
	<cfquery name="DocStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title
	FROM Documents
	WHERE DocumentID=#DocumentID#
	</cfquery>
	
	
	<cfset logdetails = 'Delete Article - (Document: #DocStuff.title# | Article: #ArtStuff.Articletitle#)'>
	<cfinclude template="act_adminlog.cfm">


<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&DocumentID=#DocumentID#">