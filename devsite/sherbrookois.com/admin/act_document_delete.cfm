<!--- GET DOC TITLE FOR LOG --->
	<cfquery name="DocTitle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title, PluginModule
	FROM Documents
	WHERE DocumentID = #DocumentID#
	</cfquery>
	
	
<!--- DELETE DOC --->
	<cfquery name="DeleteDoc" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Documents
	WHERE DocumentID = #DocumentID#
	</cfquery>
	
	
		
<!--- DELETE LINK --->
	<cfquery name="DeleteSectionLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SectionDocuments_Link
	WHERE DocumentID = #documentID#
	</cfquery>
	
	
<!--- DELETE LINKED ARTICLES --->
	<cfquery name="Allarticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleID
	FROM DocumentArticles_Link
	WHERE DocumentID=#DocumentID#
	</cfquery>
	
	<cfloop query="Allarticles">
	
	
		<!--- DELETE LINKED SUBARTICLES --->
		<cfquery name="AllSubarticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SubArticleID
		FROM ArticleSubArticle_Link
		WHERE ArticleID=#Allarticles.ArticleID#
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
	
			<cfquery name="DeleteSubLibraryLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM LibraryLinks
			WHERE SubArticleID=#AllSubarticles.SubArticleID#
			</cfquery>
	
	
			<!--- DELETE WHATS NEW --->
	
			<cfquery name="DeleteSubwhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM WhatsNew
			WHERE SubArticleID=#AllSubarticles.SubArticleID#
			</cfquery>
	
		</cfloop>
		
		<!--- DELETE ARTICLE LINKS --->
		<cfquery name="AllDeleteSubArtLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM ArticleSubArticle_Link
		WHERE ArticleID=#Allarticles.ArticleID#
		</cfquery>
	
	
		<cfquery name="deleteArts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM Articles
		WHERE ArticleID=#Allarticles.ArticleID#
		</cfquery>
		
		<!--- DELETE ANY LINKS --->

		<cfquery name="DeleteArtLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE ArticleID=#Allarticles.ArticleID#
		</cfquery>
	
	
		<!--- DELETE WHATS NEW --->
	
		<cfquery name="DeleteArtwhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM WhatsNew
		WHERE ArticleID=#Allarticles.ArticleID#
		</cfquery>
	
	
	</cfloop>
	
	
<!--- DELETE ARTICLE LINKS --->
	<cfquery name="DeleteAllarticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM DocumentArticles_Link
	WHERE DocumentID=#DocumentID#
	</cfquery>
	
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteDocLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="DeleteDocwhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE DocumentID=#DocumentID#
	</cfquery>
	
	
	
	
	
	
	
	
	
	
	
<cfif #DocTitle.PluginModule# EQ 'News'>



	<!--- SELECT LINKED CATEGORIES --->
	<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT NewsCatID
	FROM NewsCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>

	
	
	<cfloop query="AllCats">
	
	<!--- DELETE NEWS ID --->
		<cfquery name="AllNews" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT  RecordID
		FROM News
		WHERE NewsCatID = #AllCats.NewsCatID#
		</cfquery>
		
			
	<!--- DELETE NEWS ITEMS --->
		<cfquery name="DeleteNews" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE 
		FROM News
		WHERE NewsCatID = #AllCats.NewsCatID#
		</cfquery>
		
	
	<!--- DELETE ANY LINKS --->
	
		<cfquery name="DeleteDocLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE NewsID=#AllNews.RecordID#
		</cfquery>
		
		
		
	<!--- DELETE WHATS NEW --->
		
		<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM WhatsNew
		WHERE Type='news'
		AND RelatedID=#AllNews.RecordID#
		</cfquery>
		
		
	</cfloop>
		
	
	
	<!--- DELETE CATEGORIES --->
	<cfquery name="DeleteCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM NewsCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>
	
	
		
		


<cfelseif #DocTitle.PluginModule# EQ 'Events'>



	<!--- SELECT LINKED CATEGORIES --->
	<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventCatID
	FROM EventCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>

	
	
	<cfloop query="AllCats">
	
	<!--- SELECT EVENT ID --->
		<cfquery name="AllEvents" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT  EventID
		FROM Events
		WHERE EventCatID = #AllCats.EventCatID#
		</cfquery>
		
			
	<!--- DELETE NEWS ITEMS --->
		<cfquery name="DeleteEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE 
		FROM Events
		WHERE EventCatID = #AllCats.EventCatID#
		</cfquery>
		
	
	<!--- DELETE ANY LINKS --->
	
		<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE EventID=#AllEvents.EventID#
		</cfquery>
		
		
		
	<!--- DELETE WHATS NEW --->
		
		<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM WhatsNew
		WHERE Type='event'
		AND RelatedID=#AllEvents.EventID#
		</cfquery>
		
		
	</cfloop>
		
	
	
	<!--- DELETE CATEGORIES --->
	<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM EventCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>
	

	
	
	
<cfelseif #DocTitle.PluginModule# EQ 'Links'>



	<!--- SELECT LINKED CATEGORIES --->
	<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT LinkCatID
	FROM LinkCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>

	
	
	<cfloop query="AllCats">
	
	<!--- SELECT EVENT ID --->
		<cfquery name="AllEvents" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT  LinkID
		FROM Links
		WHERE LinkCatID = #AllCats.LinkCatID#
		</cfquery>
		
			
	<!--- DELETE NEWS ITEMS --->
		<cfquery name="DeleteEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE 
		FROM Links
		WHERE LinkCatID = #AllCats.LinkCatID#
		</cfquery>
		
	
	<!--- DELETE ANY LINKS --->
	
		<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE WebLinkID=#AllEvents.LinkID#
		</cfquery>
		
		
		
	<!--- DELETE WHATS NEW --->
		
		<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM WhatsNew
		WHERE Type='link'
		AND RelatedID=#AllEvents.LinkID#
		</cfquery>
		
		
	</cfloop>
		
	
	
	<!--- DELETE CATEGORIES --->
	<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM LinkCats
	WHERE Fuseaction = '#TRIM(Fuseaction)#'
	</cfquery>
	
	
</cfif>





	
	
	<cfset logdetails = 'Delete Document - (Document: #DocTitle.title# | Section: #fuseaction#)'>
		<cfinclude template="act_adminlog.cfm">

<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#">