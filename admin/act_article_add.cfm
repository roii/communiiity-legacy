

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ArticleID
	FROM Articles
	ORDER BY ArticleID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.ArticleID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Articles(ArticleID, ArticleTitle, Details, Released,<cfif IsDate("#form.pubdate#")> PubDate,</cfif><cfif IsDate("#form.ExpireDate#")> ExpireDate,</cfif> AdminView, PublicView, ContactTypeView, AllowDelete, Author, PageTitle, MetaContent, MetaKeywords)
	VALUES(#newid#, '#form.articletitle#', '#form.details#', #form.released#,<cfif IsDate("#form.pubdate#")> #CreateODBCDate(form.pubdate)#,</cfif><cfif IsDate("#form.ExpireDate#")> #CreateODBCDate(form.ExpireDate)#,</cfif> <cfif IsDefined("form.AdminView")>1<cfelse>0</cfif>, <cfif IsDefined("form.PublicView")>1<cfelse>0</cfif>, <cfif IsDefined("form.ContactTypeView")>'#form.ContactTypeView#'<cfelse>'0'</cfif>, 1, '#form.author#', '#form.PageTitle#', '#form.MetaContent#', '#form.MetaKeywords#')
	</cfquery>

	

<!--- GENERATE NEW LINK ID --->
	
	<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT DocArtID
	FROM DocumentArticles_Link
	ORDER BY DocArtID DESC
	</cfquery>
	
	<cfif #lastlinkid.recordcount# GT 0>
		<cfset newlinkid = (#LastLinkID.DocArtID# + 1)>
	<cfelse>
		<cfset newlinkid = 1>
	</cfif>

	

<!--- LINK TO DOCUMENT --->

	<cfquery name="ArtDocLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO DocumentArticles_Link(DocArtID, DocumentID, ArticleID, DisplayOrder)
	VALUES(#newlinkid#, #form.DocumentID#, #newid#, #form.DisplayOrder#)
	</cfquery>


<!--- GET DOC INFO FOR LOG --->

	<cfquery name="DocStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title
	FROM Documents
	WHERE DocumentID=#form.DocumentID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Add Article - (Document: #DocStuff.title# | Article: #form.ArticleTitle#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=Docs&DocumentID=#DocumentID#')"></body>
	
	
	</cfoutput>
