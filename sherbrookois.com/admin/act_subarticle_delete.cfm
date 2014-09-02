<!--- DELETE LINKED LEVEL4 ARTICLES --->
<cfquery name="AllLevel4articles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Level4ArticleID
FROM SubArticleLevel4Link
WHERE SubArticleID=#SubArticleID#
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
			
			
			
				<!--- GET ART INFO FOR LOG --->
	
	<cfquery name="SubArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubArticleTitle
	FROM SubArticles
	WHERE SubArticleID=#SubArticleID#
	</cfquery>
	
	
<!--- DELETE ARTICLE --->
	
	<cfquery name="DeleteSubArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM SubArticles
	WHERE SubArticleID = #SubArticleID#
	</cfquery>
	
	
<!--- DELETE LINK --->
	
	<cfquery name="DeleteLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ArticleSubArticle_Link
	WHERE SubArticleID = #SubArticleID#
	</cfquery>
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE SubArticleID=#SubArticleID#
	</cfquery>
	
	
	<!--- GET DOC INFO FOR LOG --->
	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleTitle
	FROM Articles
	WHERE ArticleID=#ArticleID#
	</cfquery>
	
	
	<cfset logdetails = 'Delete SubArticle - (Article: #ArtStuff.ArticleTitle# | SubArticle: #SubArtStuff.SubArticletitle#)'>
	<cfinclude template="act_adminlog.cfm">


<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=article&DocumentID=#DocumentID#&articleID=#articleID#">