
	


<!--- UPDATE --->
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Projects
	SET ProjectCategoryID=#form.ProjectCategoryID#,
	Title='#form.title#',
	introText='#form.introtext#',
	Details='#form.details#',
	AgeShort='#form.AgeShort#', 
	AgeLong='#form.AgeLong#', 
	ShortTime='#form.ShortTime#', 
	MaxTime='#form.MaxTime#', 
	CreditsOffered='#form.CreditsOffered#',
	AssignedTo='#form.assignedto#',
	PercentComplete=#form.percentcomplete#,
	currentstatus='#form.currentstatus#',	
	FeatureProject=#form.featureProject#,
	PaymentType='#form.PaymentType#',
	PaidIn='#form.PaidIn#',
	Priority = '#form.ProjectPriority#'
	WHERE ProjectID=#form.ProjectID#
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
