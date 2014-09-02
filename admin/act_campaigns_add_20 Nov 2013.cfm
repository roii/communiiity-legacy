

<!--- GENERATE NEW PROJECT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT CampaignsID
	FROM campaigns
	ORDER BY CampaignsID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.CampaignsID# + 1)>
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
	INSERT INTO campaigns(CampaignsID, ProjectCategoryID, Title, introText, Details, CreditsOffered, FeatureCampaigns, currentstatus, percentcomplete, assignedto, paymentType, PaidIn, campaignspic, campaign_video,
	     dashboard_var_1_label, dashboard_var_1_value, dashboard_var_1_percentage,
		 dashboard_var_2_label, dashboard_var_2_value, dashboard_var_2_percentage,
		 dashboard_var_3_label, dashboard_var_3_value, dashboard_var_3_percentage,
		 dashboard_var_4_label, dashboard_var_4_value, dashboard_var_4_percentage,
		 dashboard_var_5_label, dashboard_var_5_value, dashboard_var_5_percentage,
		 dashboard_var_6_label, dashboard_var_6_value, dashboard_var_6_percentage,
	 location, campaigns_order, displaycampaigns, addedby)
	VALUES(#newid#, #form.ProjectCategoryID#, '#form.title#', '#form.introtext#', '#form.details#', '#form.CreditsOffered#', #form.FeatureCampaigns#, '#form.currentstatus#', '#form.percentcomplete#', '#form.assignedto#', '#form.PaymentType#', '#form.PaidIn#', '#localImage1#', '#FORM.campaign_video#',
	
	         <cfif #FORM.dashboard_var_1_label# neq ''> 
				  '#FORM.dashboard_var_1_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_1_value# neq ''> 
				  '#FORM.dashboard_var_1_value#',
			  <cfelse>
				  '',
			  </cfif> 
		      <cfif #FORM.dashboard_var_1_percentage# neq ''> 
				  #FORM.dashboard_var_1_percentage#,
			  <cfelse>
				  0,
			  </cfif> 
			  
			  <cfif #FORM.dashboard_var_2_label# neq ''> 
				  '#FORM.dashboard_var_2_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_2_value# neq ''> 
				  '#FORM.dashboard_var_2_value#',
			  <cfelse>
				  '',
			  </cfif>
			   
		      <cfif #FORM.dashboard_var_2_percentage# neq ''> 
				  #FORM.dashboard_var_2_percentage#,
			  <cfelse>
				  0,
			  </cfif> 
			  
			  <cfif #FORM.dashboard_var_3_label# neq ''> 
				  '#FORM.dashboard_var_3_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_3_value# neq ''> 
				  '#FORM.dashboard_var_3_value#',
			  <cfelse>
				  '',
			  </cfif>
			     
			  <cfif #FORM.dashboard_var_3_percentage# neq ''> 
				  #FORM.dashboard_var_3_percentage#,
			  <cfelse>
				  0,
			  </cfif>
			  
			  <cfif #FORM.dashboard_var_4_label# neq ''> 
				  '#FORM.dashboard_var_4_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_4_value# neq ''> 
				  '#FORM.dashboard_var_4_value#',
			  <cfelse>
				  '',
			  </cfif>
			   
			  <cfif #FORM.dashboard_var_4_percentage# neq ''> 
				  #FORM.dashboard_var_4_percentage#,
			  <cfelse>
				  0,
			  </cfif>
			  
			  <cfif #FORM.dashboard_var_5_label# neq ''> 
				  '#FORM.dashboard_var_5_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_5_value# neq ''> 
				  '#FORM.dashboard_var_5_value#',
			  <cfelse>
				  '',
			  </cfif>
			    
			  <cfif #FORM.dashboard_var_5_percentage# neq ''> 
				  #FORM.dashboard_var_5_percentage#,
			  <cfelse>
				  0,
			  </cfif>
			  
			  <cfif #FORM.dashboard_var_6_label# neq ''> 
				  '#FORM.dashboard_var_6_label#',
			  <cfelse>
				  '',
			  </cfif>   
			  <cfif #FORM.dashboard_var_6_value# neq ''> 
				  '#FORM.dashboard_var_6_value#',
			  <cfelse>
				  '',
			  </cfif>
			     
			  <cfif #FORM.dashboard_var_6_percentage# neq ''> 
				  #FORM.dashboard_var_6_percentage#
			  <cfelse>
				  0
			  </cfif>
	   <cfif IsDefined("FORM.location") and FORM.location neq "">
	      ,'#FORM.location#',
	   <cfelse>
	      ,'',	  
	   </cfif>
	   <cfif IsDefined("FORM.project_order") and FORM.project_order neq "">
	      '#FORM.campaigns_order#',
	   <cfelse>
	      '',	  
	   </cfif>
	   <cfif IsDefined("FORM.displayProject") and FORM.displayProject neq "">
	      '#FORM.displaycampaigns#',
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
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=campaigns&documentID=#documentID#')"></body>
	
	
	</cfoutput>
