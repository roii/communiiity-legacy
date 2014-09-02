

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SubArticleID
	FROM SubArticles
	ORDER BY SubArticleID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.SubArticleID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddSubArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO SubArticles(SubArticleID, SubArticleTitle, SubDetails, SubReleased,<cfif #IsDate(form.pubdate)#> PubDate,</cfif><cfif #IsDate(form.SubExpireDate)#> SubExpireDate,</cfif> UserType, AllowDelete, Author)
	VALUES(#newid#, '#form.subarticletitle#', '#form.subdetails#', #form.released#,<cfif #IsDate(form.pubdate)#> #CreateODBCDate(form.pubdate)#,</cfif><cfif #IsDate(form.SubExpireDate)#> #CreateODBCDate(form.SubExpireDate)#,</cfif> '#form.usertype#', 1, '#form.author#')
	</cfquery>

	

<!--- GENERATE NEW LINK ID --->
	
	<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ArtSubArtID
	FROM ArticleSubArticle_Link
	ORDER BY ArtSubArtID DESC
	</cfquery>
	
	<cfif #lastlinkid.recordcount# GT 0>
		<cfset newlinkid = (#LastLinkID.ArtSubArtID# + 1)>
	<cfelse>
		<cfset newlinkid = 1>
	</cfif>

	

<!--- LINK TO DOCUMENT --->

	<cfquery name="ArtSubArtLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO ArticleSubArticle_Link(ArtSubArtID, ArticleID, SubArticleID, DisplayOrder)
	VALUES(#newlinkid#, #form.ArticleID#, #newid#, #form.DisplayOrder#)
	</cfquery>


<!--- GET Article INFO FOR LOG --->

	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleTitle
	FROM Articles
	WHERE ArticleID=#form.ArticleID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Add SubArticle - (Article: #ArtStuff.ArticleTitle# | SubArticle: #form.SubArticleTitle#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=SubArticle&DocumentID=#DocumentID#&articleID=#ArticleID#&SubArticleID=#newID#')"></body>
	
	
	</cfoutput>
