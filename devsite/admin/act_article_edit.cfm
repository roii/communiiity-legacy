<!--- UPDATE ARTICLE DETAILS --->
	<cfquery name="UpdateArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Articles
	SET ArticleTitle = '#form.Articletitle#',
	Details = '#form.details#',
	Released = #form.released#,
	
	
	<cfif IsDate("#form.pubdate#")>
		PubDate=#CreateODBCDate(form.pubdate)#,
	<cfelse>
		PubDate=NULL,
	</cfif>
	
	
	<cfif IsDate("#form.ExpireDate#")>
		ExpireDate=#CreateODBCDate(form.ExpireDate)#,
	<cfelse>
		ExpireDate=NULL,
	</cfif>
	
	<cfif IsDefined("form.AdminView")>
		AdminView=1,
	<cfelse>
		AdminView=0,
	</cfif>
	
	<cfif IsDefined("form.PublicView")>
		PublicView=1,
	<cfelse>
		PublicView=0,
	</cfif>
	
	<cfif IsDefined("form.ContactTypeView")>
		ContactTypeView='#form.ContactTypeView#',
	<cfelse>
		ContactTypeView='0',
	</cfif>
	
	
	PageTitle='#form.PageTitle#',
	MetaContent='#form.MetaContent#',
	MetaKeywords='#form.MetaKeywords#',
	
	Author='#form.author#'
	WHERE ArticleID = #form.ArticleID#
	</cfquery>


	
	<!--- UPDATE THE LINK ORDER --->
	<cfquery name="UpdateLinkOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE DocumentArticles_Link
	SET DisplayOrder = #form.displayorder#
	WHERE ArticleID = #form.ArticleID#
	AND DocumentID = #form.DocumentID#
	</cfquery>
	
	<!--- GET DOC INFO FOR LOG --->
	<cfquery name="DocStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title
	FROM Documents
	WHERE DocumentID=#form.DocumentID#
	</cfquery>

	<cfoutput>
	<cfset logdetails = 'Edit Article - (Document: #DocStuff.title# | Article: #form.ArticleTitle#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=article&DocumentID=#DocumentID#&articleID=#articleID#')"></body>
	
	
	</cfoutput>