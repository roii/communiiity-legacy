
	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
	<cfif len(project_pic)> 
	   <cffile action="upload" filefield="form.project_pic" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	       <cfset localImage1 =  #CFFILE.ServerFile#>   
	<cfelse>
	       	<cfset localImage1 = "">	
	</cfif> 
	
	
	<cfif len(form.gallery_pics_1)>
	        <cffile action="upload" filefield="form.gallery_pics_1" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset gallery_pics_1 =  #CFFILE.ServerFile#>   
			<cfset final_gallery_pics_1 =  "final_" & #gallery_pics_1#>
			<cfimage source="#imgDir#/#gallery_pics_1#" action="resize" width="700" height="306" destination="#imgDir#/#final_gallery_pics_1#" overwrite="yes">
	<cfelse>
	       	<cfset final_gallery_pics_1 = "">	
	</cfif>
	
	<cfif len(form.gallery_pics_2)>
	        <cffile action="upload" filefield="form.gallery_pics_2" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset gallery_pics_2 =  #CFFILE.ServerFile#>   
			<cfset final_gallery_pics_2 =  "final_" & #gallery_pics_2#>
			<cfimage source="#imgDir#/#gallery_pics_2#" action="resize" width="700" height="306" destination="#imgDir#/#final_gallery_pics_2#" overwrite="yes">
	<cfelse>
	       	<cfset final_gallery_pics_2 = "">	
	</cfif>
	
	<cfif len(form.gallery_pics_3)>
	        <cffile action="upload" filefield="form.gallery_pics_3" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset gallery_pics_3 =  #CFFILE.ServerFile#>   
			<cfset final_gallery_pics_3 =  "final_" & #gallery_pics_3#>
			<cfimage source="#imgDir#/#gallery_pics_3#" action="resize" width="700" height="306" destination="#imgDir#/#final_gallery_pics_3#" overwrite="yes">
	<cfelse>
	       	<cfset final_gallery_pics_3 = "">	
	</cfif>
	
	<cfif len(form.gallery_pics_4)>
	        <cffile action="upload" filefield="form.gallery_pics_4" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset gallery_pics_4 =  #CFFILE.ServerFile#>   
			<cfset final_gallery_pics_4 =  "final_" & #gallery_pics_4#>
			<cfimage source="#imgDir#/#gallery_pics_4#" action="resize" width="700" height="306" destination="#imgDir#/#final_gallery_pics_4#" overwrite="yes">
	<cfelse>
	       	<cfset final_gallery_pics_4 = "">	
	</cfif>
	
	<cfif len(form.gallery_pics_5)>
	        <cffile action="upload" filefield="form.gallery_pics_5" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset gallery_pics_5 =  #CFFILE.ServerFile#>   
			<cfset final_gallery_pics_5 =  "final_" & #gallery_pics_5#>
			<cfimage source="#imgDir#/#gallery_pics_5#" action="resize" width="700" height="306" destination="#imgDir#/#final_gallery_pics_5#" overwrite="yes">
	<cfelse>
	       	<cfset final_gallery_pics_5 = "">	
	</cfif>
     
<!--- UPDATE --->
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE campaigns
	SET ProjectCategoryID=#form.ProjectCategoryID#,
	Title='#form.title#',
	introText='#form.introtext#',
	Details='#form.details#',  
	CreditsOffered='#form.CreditsOffered#',
	AssignedTo='#form.assignedto#',
	PercentComplete=#form.percentcomplete#,
	currentstatus='#form.currentstatus#',	
	FeatureCampaigns=#form.FeatureCampaigns#,
	PaymentType='#form.PaymentType#',
	PaidIn='#form.PaidIn#',
	campaign_video = '#FORM.campaign_video#', 
	<cfif #FORM.Moderators# neq ''> 
	   Moderators = '#FORM.Moderators#',
    <cfelse>
	   Moderators = '',
    </cfif>
	dashboard_var_1_label = '#FORM.dashboard_var_1_label#', 
	dashboard_var_1_value = '#FORM.dashboard_var_1_value#',
	  <cfif #FORM.dashboard_var_1_percentage# neq ''> 
	      dashboard_var_1_percentage = #FORM.dashboard_var_1_percentage#,
	  <cfelse>
	      dashboard_var_1_percentage = 0,
	  </cfif>	  
	dashboard_var_2_label = '#FORM.dashboard_var_2_label#', 
	dashboard_var_2_value = '#FORM.dashboard_var_2_value#', 
	  <cfif #FORM.dashboard_var_2_percentage# neq ''> 
	      dashboard_var_2_percentage = #FORM.dashboard_var_2_percentage#,
	  <cfelse>
	      dashboard_var_2_percentage = 0,
	  </cfif> 
	dashboard_var_3_label = '#FORM.dashboard_var_3_label#', 
	dashboard_var_3_value = '#FORM.dashboard_var_3_value#', 
	  <cfif #FORM.dashboard_var_3_percentage# neq ''> 
	      dashboard_var_3_percentage = #FORM.dashboard_var_3_percentage#,
	  <cfelse>
	      dashboard_var_3_percentage = 0,
	  </cfif> 
	dashboard_var_4_label = '#FORM.dashboard_var_4_label#', 
	dashboard_var_4_value = '#FORM.dashboard_var_4_value#', 
	  <cfif #FORM.dashboard_var_4_percentage# neq ''> 
	      dashboard_var_4_percentage = #FORM.dashboard_var_4_percentage#,
	  <cfelse>
	      dashboard_var_4_percentage = 0,
	  </cfif> 
	dashboard_var_5_label = '#FORM.dashboard_var_5_label#', 
	dashboard_var_5_value = '#FORM.dashboard_var_5_value#', 
	  <cfif #FORM.dashboard_var_5_percentage# neq ''> 
	      dashboard_var_5_percentage = #FORM.dashboard_var_5_percentage#,
	  <cfelse>
	      dashboard_var_5_percentage = 0,
	  </cfif> 
	dashboard_var_6_label = '#FORM.dashboard_var_6_label#', 
	dashboard_var_6_value = '#FORM.dashboard_var_6_value#', 
	  <cfif #FORM.dashboard_var_6_percentage# neq ''> 
	      dashboard_var_6_percentage = #FORM.dashboard_var_6_percentage#,
	  <cfelse>
	      dashboard_var_6_percentage = 0,
	  </cfif>  
	<cfif localImage1 neq "">
	  campaignspic = '#localImage1#',
	</cfif>
	<cfif IsDefined("FORM.location") and FORM.location neq "">
	   location = '#FORM.location#',
    <cfelse>
	   location = '',	  
    </cfif>
    <cfif IsDefined("FORM.addedBy") and FORM.addedBy neq "">
	  addedby = '#FORM.addedBy#',
    <cfelse>
	  addedby = '',
    </cfif>
	<cfif IsDefined("FORM.campaigns_order") and FORM.campaigns_order neq "">
	  campaigns_order = '#FORM.campaigns_order#', 	  
    </cfif>
	<cfif IsDefined("FORM.displaycampaigns") and FORM.displaycampaigns neq "">
	  displaycampaigns = '#FORM.displaycampaigns#', 
    </cfif>
	<cfif final_gallery_pics_1 neq ''>
	  gallery_pics_1 = '#final_gallery_pics_1#',
	</cfif> 
	<cfif final_gallery_pics_2 neq ''>
	  gallery_pics_2  = '#final_gallery_pics_2#',
	</cfif>
	<cfif final_gallery_pics_3 neq ''> 
	  gallery_pics_3  = '#final_gallery_pics_3#',
	</cfif>
	<cfif final_gallery_pics_4 neq ''> 
	  gallery_pics_4  = '#final_gallery_pics_4#',
	</cfif>
	<cfif final_gallery_pics_5 neq ''> 
	  gallery_pics_5  = '#final_gallery_pics_5#',
	</cfif> 
	<cfif IsDefined("form.ProjectPriority") and #form.ProjectPriority# neq ''>
	  Priority = '#form.ProjectPriority#'
	<cfelse>
	  Priority = ''
	</cfif> 
	WHERE CampaignsID=#form.CampaignsID#
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
	
		<body onLoad="showParentAndClose('#request.webroot#/projects/#form.CampaignsID#')"></body>
	
	
	</cfoutput>
