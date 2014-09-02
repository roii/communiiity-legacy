<!--- UPDATE ARTICLE DETAILS --->
	
	<cfquery name="UpdateCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE EventCats
	SET EventCatName = '#form.EventCatName#',
	DisplayOrder = #form.DisplayOrder#,
	NonMember=<cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>,
	Member=<cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>,
	Released=#form.released#
	WHERE EventCatID = #form.EventCatID#
	</cfquery>
	
	
	

<!--- LOG THE ACTION --->
	
	<cfoutput>
	<cfset logdetails = 'Edit Event Category - (Category: #form.EventCatName#)'>
	<cfinclude template="act_adminlog.cfm">
	</cfoutput>
	
	
	
	
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