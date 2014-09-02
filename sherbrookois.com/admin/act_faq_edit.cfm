<!--- UPDATE ARTICLE DETAILS --->
	
	<cfquery name="UpdateFAQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE FAQs
	SET FaqTitle='#form.FAQtitle#',
	FaqDetails = '#form.FaqDetails#',	
	PublishedDate = #localDateTime#,
	DisplayOrder=#form.displayOrder#
	WHERE FaqID = #form.FaqID#
	</cfquery>


	

<!--- LOG THE ACTION --->
	
	<cfoutput>
	<cfset logdetails = 'Edit FAQ - (FAQ: #form.FAQtitle#)'>
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
