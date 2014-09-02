<!--- UPDATE ARTICLE DETAILS --->
	
	<cfquery name="UpdateLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Links
	SET LinkCatID=#form.linkcatID#,
	Title = '#form.title#',
	LinkURL='#form.linkURL#',
	Details = '#form.details#',
	NonMember=<cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>,
	Member=<cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>,
	Released=#form.released#
	WHERE LinkID = #form.LinkID#
	</cfquery>


	

<!--- LOG THE ACTION --->
	
	<cfoutput>
	<cfset logdetails = 'Edit Link - (#form.title#)'>
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


<cfelseif IsDefined("CheckLinks")>	

		
		<body onload="self.close();"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#')"></body>
	
	</cfif>
	</cfoutput>
