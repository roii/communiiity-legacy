<!--- UPDATE ARTICLE DETAILS --->
	<cfquery name="UpdateSubArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE SubArticles
	SET SubArticleTitle = '#form.SubArticletitle#',
	SubDetails = '#form.Subdetails#',
	SubReleased = #form.released#,
	
	<cfif #IsDate(form.pubdate)#>
		PubDate=#CreateODBCDate(form.pubdate)#,
	<cfelse>
		PubDate=NULL,
	</cfif>
	
	<cfif #IsDate(form.SubExpireDate)#>
		SubExpireDate=#CreateODBCDate(form.SubExpireDate)#,
	<cfelse>
		SubExpireDate=NULL,
	</cfif>
	
	UserType='#form.usertype#',
	Author='#form.author#'
	WHERE SubArticleID = #form.SubArticleID#
	</cfquery>


	
	<!--- UPDATE THE LINK ORDER --->
	<cfquery name="UpdateLinkOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ArticleSubArticle_Link
	SET DisplayOrder = #form.displayorder#
	WHERE SubArticleID = #form.SubArticleID#
	AND ArticleID = #form.ArticleID#
	</cfquery>
	
	<!--- GET DOC INFO FOR LOG --->
	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleTitle
	FROM Articles
	WHERE ArticleID = #form.ArticleID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Edit SubArticle - (Article: #ArtStuff.ArticleTitle# | SubArticle: #form.SubArticleTitle#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=subarticle&DocumentID=#DocumentID#&articleID=#articleID#&subarticleID=#subarticleID#')"></body>
	
	
	</cfoutput>