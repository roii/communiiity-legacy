

<!--- GENERATE NEW PROJECT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ProjectID
	FROM Projects
	ORDER BY ProjectID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.ProjectID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Projects(ProjectID, ProjectCategoryID, Title, introText, Details, AgeShort, AgeLong, ShortTime, MaxTime, CreditsOffered, FeatureProject, currentstatus, percentcomplete, assignedto, paymentType, PaidIn)
	VALUES(#newid#, #form.ProjectCategoryID#, '#form.title#', '#form.introtext#', '#form.details#', '#form.AgeShort#', '#form.AgeLong#', '#form.ShortTime#', '#form.MaxTime#', '#form.CreditsOffered#', #form.featureProject#, '#form.currentstatus#', '#form.percentcomplete#', '#form.assignedto#', '#form.PaymentType#', '#form.PaidIn#')
	</cfquery>

	
	

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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#')"></body>
	
	
	</cfoutput>
