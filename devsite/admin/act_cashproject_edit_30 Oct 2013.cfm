
	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
	<cfif len(project_pic)> 
	   <cffile action="upload" filefield="form.project_pic" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	       <cfset localImage1 =  #CFFILE.ServerFile#>   
	<cfelse>
	       	<cfset localImage1 = "">	
	</cfif> 
    

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
	projectpic = '#localImage1#',
	<cfif IsDefined("form.ProjectPriority") and #form.ProjectPriority# neq ''>
	Priority = '#form.ProjectPriority#'
	<cfelse>
	Priority = ''
	</cfif>
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
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#')"></body>
	
	
	</cfoutput>
