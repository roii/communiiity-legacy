

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
	
	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
	<cfif len(project_pic)>
	   
	   <cffile action="upload" filefield="form.project_pic" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	    <cfset localImage1 =  #CFFILE.ServerFile#>  
		<!---<cffile
			action="upload"
			destination = "#imgDIR#"
			nameconflict="makeunique"
			filefield="project_pic" />
			
			<cfdump var="#cffile#">
			<cfabort>
			
		    <cfset fileExt = cffile.CLIENTFILEEXT>
			<cfset localImage1 = replace(cffile.SERVERFILE," ","","all")>
			<cfset localImage1 = localImage1 & "." & fileExt>--->
	<cfelse>
	       	<cfset localImage1 = "">	
	</cfif>


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Projects(ProjectID, ProjectCategoryID, Title, related_campaign, introText, Details, AgeShort, AgeLong, ShortTime, MaxTime, CreditsOffered, FeatureProject, currentstatus, percentcomplete, assignedto, paymentType, PaidIn, projectpic, location, project_order, displayProject, addedby)
	VALUES(#newid#, #form.ProjectCategoryID#, '#form.title#', #FORM.related_campaign# , '#form.introtext#', '#form.details#', '#form.AgeShort#', '#form.AgeLong#', '#form.ShortTime#', '#form.MaxTime#', '#form.CreditsOffered#', #form.featureProject#, '#form.currentstatus#', '#form.percentcomplete#', '#form.assignedto#', '#form.PaymentType#', '#form.PaidIn#', '#localImage1#'
	   <cfif IsDefined("FORM.location") and FORM.location neq "">
	      ,'#FORM.location#',
	   <cfelse>
	      ,'',	  
	   </cfif>
	   <cfif IsDefined("FORM.project_order") and FORM.project_order neq "">
	      '#FORM.project_order#',
	   <cfelse>
	      '',	  
	   </cfif>
	   <cfif IsDefined("FORM.displayProject") and FORM.displayProject neq "">
	      '#FORM.displayProject#',
	   <cfelse>
	      0,	  
	   </cfif>
	   <cfif IsDefined("FORM.addedBy") and FORM.addedBy neq "">
	      '#FORM.addedBy#'
	   <cfelse>
	      '' 
	   </cfif>
	)
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
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#')"></body>
	
	
	</cfoutput>
