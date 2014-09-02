<!--- UPDATE ARTICLE DETAILS --->
	
	<cfquery name="UpdateArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE News
	SET ReleasedDate = #CreateODBCDate(form.ReleaseDate)#,
	<cfif IsDate("form.ExpireDate")>
		NewsExpireDate = #CreateODBCDate(form.ExpireDate)#,
	</cfif>
	Title = '#form.title#',
	introduction = '#form.introduction#',	
	Details = '#form.details#',
	NewsCatID = #form.NewsCatID#,
	NonMember=<cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>,
	Member=<cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>,
	Released=#form.released#
	WHERE RecordID = #form.newsID#
	</cfquery>


	

<!--- LOG THE ACTION --->
	
	<cfoutput>
	<cfset logdetails = 'Edit News Article - (Article: #form.title#)'>
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
		<cfif IsDefined("ArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#')"></body>


<cfelseif IsDefined("DocumentID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#')"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#')"></body>
	
	</cfif>
	</cfoutput>
