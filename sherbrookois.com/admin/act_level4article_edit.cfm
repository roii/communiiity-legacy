<!--- UPDATE ARTICLE DETAILS --->
	<cfquery name="UpdateLevel4Article" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE level4articles
	SET Level4ArticleTitle = '#form.Level4ArticleTitle#',
	Level4Details = '#form.Level4Details#',
	Level4Released = #form.Level4Released#,
	
	<cfif #IsDate(form.pubdate)#>
		PubDate=#CreateODBCDate(form.pubdate)#,
	<cfelse>
		PubDate=NULL,
	</cfif>
	
	<cfif #IsDate(form.Level4ExpireDate)#>
		Level4ExpireDate=#CreateODBCDate(form.Level4ExpireDate)#,
	<cfelse>
		Level4ExpireDate=NULL,
	</cfif>
	
	UserType='#form.usertype#',
	Author='#form.author#'
	WHERE Level4articleID = #form.Level4articleID#
	</cfquery>


	
	<!--- UPDATE THE LINK ORDER --->
	<cfquery name="UpdateLinkOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE SubArticleLevel4Link
	SET DisplayOrder = #form.displayorder#
	WHERE SubArticleID = #form.SubArticleID#
	AND Level4ArticleID = #form.Level4ArticleID#
	</cfquery>
	
	<!--- GET DOC INFO FOR LOG --->
	<cfquery name="ArtStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubArticleTitle
	FROM SubArticles
	WHERE SubArticleID = #form.SubArticleID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Edit Level4Article - (SubArticle: #ArtStuff.SubArticleTitle# | Level4 Article: #form.Level4ArticleTitle#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=level4&DocumentID=#DocumentID#&articleID=#articleID#&subarticleID=#subarticleID#&level4articleID=#level4articleID#')"></body>
	
	
	</cfoutput>