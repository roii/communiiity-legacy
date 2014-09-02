<cfoutput>

<!--- GENERATE NEW ID --->

	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT WNID
	FROM WhatsNew
	ORDER BY WNID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.WNID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>



	<cfparam name="insert_details" default="">


	<cfif isDefined("details")>
		<cfset insert_details = '#details#'>
	</cfif>

		
	
	
<!--- INSERT THE RECORD --->	
	
	<cfquery name="Addwhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO WhatsNew(WNID, DateSet, DateExpires, Type, Fuseaction,<cfif IsDefined("url.Fusesubaction")> Fusesubaction,</cfif><cfif IsDefined("url.DocumentID")> DocumentID,</cfif><cfif IsDefined("url.ArticleID")> ArticleID,</cfif><cfif IsDefined("url.SubArticleID")> SubArticleID,</cfif><cfif IsDefined("url.NewsID")> NewsID,</cfif><cfif IsDefined("url.EventID")> EventID,</cfif><cfif IsDefined("url.LibraryID")> LibraryID,</cfif><cfif IsDefined("url.LinkID")> LinkID,</cfif><cfif IsDefined("url.GuidelineID")> GuidelineID,</cfif><cfif IsDefined("url.Level4ArticleID")> Level4ArticleID,</cfif> SideBar, Details)
	
	VALUES(#newID#, #localDateTime#, #DateAdd('d', 30, localDateTime)#, '#type#', '#Fuseaction#',<cfif IsDefined("url.Fusesubaction")> '#url.Fusesubaction#',</cfif><cfif IsDefined("url.DocumentID")> #url.DocumentID#,</cfif><cfif IsDefined("url.ArticleID")> #url.ArticleID#,</cfif><cfif IsDefined("url.SubArticleID")> #url.SubArticleID#,</cfif><cfif IsDefined("url.NewsID")> #url.NewsID#,</cfif><cfif IsDefined("url.EventID")> #url.EventID#,</cfif><cfif IsDefined("url.LibraryID")> #url.LibraryID#,</cfif><cfif IsDefined("url.LinkID")> #url.LinkID#,</cfif><cfif IsDefined("url.GuidelineID")> #url.GuidelineID#,</cfif><cfif IsDefined("url.Level4ArticleID")> #url.Level4ArticleID#,</cfif> 1, '#insert_details#')
	</cfquery>



	<script>
		self.location="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#<cfif IsDefined("url.Fusesubaction")>&Fusesubaction=#url.Fusesubaction#</cfif><cfif IsDefined("url.DocumentID")>&DocumentID=#url.DocumentID#</cfif><cfif IsDefined("url.ArticleID")>&ArticleID=#url.ArticleID#</cfif><cfif IsDefined("url.SubArticleID")>&SubArticleID=#url.SubArticleID#</cfif><cfif IsDefined("url.NewsID")>&NewsID=#url.NewsID#</cfif><cfif IsDefined("url.EventID")>&EventID=#url.EventID#</cfif><cfif IsDefined("url.LibraryID")>&LibraryID=#url.LibraryID#</cfif><cfif IsDefined("url.LinkID")>&LinkID=#url.LinkID#</cfif><cfif IsDefined("url.Level4ArticleID")>&Level4ArticleID=#url.Level4ArticleID#</cfif>";
	</script>


</cfoutput>


