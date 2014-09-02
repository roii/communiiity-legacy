

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT Level4articleID
	FROM dbo.level4articles
	ORDER BY Level4articleID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.Level4articleID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddLevel4Article" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO dbo.level4articles(Level4articleID, Level4ArticleTitle, Level4Details, Level4Released,<cfif #IsDate(form.pubdate)#> PubDate,</cfif><cfif #IsDate(form.Level4ExpireDate)#> Level4ExpireDate,</cfif> UserType, AllowDelete, Author)
	VALUES(#newid#, '#form.Level4ArticleTitle#', '#form.Level4Details#', #form.Level4Released#,<cfif #IsDate(form.pubdate)#> #CreateODBCDate(form.pubdate)#,</cfif><cfif #IsDate(form.Level4ExpireDate)#> #CreateODBCDate(form.Level4ExpireDate)#,</cfif> '#form.usertype#', 1, '#form.author#')
	</cfquery>

	

<!--- GENERATE NEW LINK ID --->
	
	<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SubArtLevel4LinkID
	FROM dbo.SubArticleLevel4Link
	ORDER BY SubArtLevel4LinkID DESC
	</cfquery>
	
	<cfif #lastlinkid.recordcount# GT 0>
		<cfset newlinkid = (#LastLinkID.SubArtLevel4LinkID# + 1)>
	<cfelse>
		<cfset newlinkid = 1>
	</cfif>

	

<!--- LINK TO DOCUMENT --->

	<cfquery name="AddLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO dbo.SubArticleLevel4Link(SubArtLevel4LinkID, SubArticleID, Level4ArticleID, DisplayOrder)
	VALUES(#newlinkid#, #form.SubArticleID#, #newid#, #form.DisplayOrder#)
	</cfquery>


<!--- GET Article INFO FOR LOG --->

	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubArticleTitle
	FROM SubArticles
	WHERE SubArticleID=#form.SubArticleID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Add level4 Article - (SubArticle: #ArtStuff.SubArticleTitle# | Level 4 Article: #form.Level4ArticleTitle#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=Level4&DocumentID=#DocumentID#&articleID=#ArticleID#&SubArticleID=#subarticleID#&Level4ArticleID=#newID#')"></body>
	
	
	</cfoutput>
