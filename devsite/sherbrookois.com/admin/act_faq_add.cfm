

<!--- GENERATE NEW FAQ ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT FaqID
	FROM FAQs
	ORDER BY FaqID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.FaqID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	
<!--- INSERT ARTICLE  --->
	
	<cfquery name="InsertFAQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO FAQs(FaqID, FaqTitle, FaqDetails, PublishedDate, DisplayOrder, fuseaction, fusesubaction, documentID, articleID, subarticleID)
	VALUES(#newID#, '#form.FaqTitle#', '#form.FaqDetails#', #localDateTime#, #form.displayOrder#, '#form.fuseaction#', '#form.fusesubaction#', #form.documentID#, #form.articleID#, #form.subarticleID#)
	</cfquery>

	
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	
	
	
	
	<cfoutput>
	
	<cfset logdetails = 'Add FAQ - (FAQ: #form.Faqtitle#)'>	
	<cfinclude template="act_adminlog.cfm">

	
	
<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
		
	<cfif IsDefined("form.SubArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(form.fuseaction)#&fusesubaction=#TRIM(form.fusesubaction)#&documentID=#form.documentID#&ArticleID=#form.ArticleID#&subArticleID=#form.subarticleID#')"></body>

	<cfelseif IsDefined("form.ArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(form.fuseaction)#&fusesubaction=#TRIM(form.fusesubaction)#&documentID=#form.documentID#&ArticleID=#form.ArticleID#')"></body>


	<cfelseif IsDefined("form.DocumentID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(form.fuseaction)#&fusesubaction=#TRIM(form.fusesubaction)#&documentID=#form.documentID#')"></body>


	<cfelseif IsDefined("form.fusesubaction")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(form.fuseaction)#&fusesubaction=#TRIM(form.fusesubaction)#')"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(form.fuseaction)#')"></body>
	
	</cfif>
	
		
		
	</cfoutput>