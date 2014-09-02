

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
	
	<cfif len(primary_picture)> 
	        <cffile action="upload" filefield="form.primary_picture" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset primary_picture1 =  #CFFILE.ServerFile#>   
			<cfset final_primary_picture_1 =  "final_" & #primary_picture1#>
			<cfimage source="#imgDir#/#primary_picture1#" action="resize" width="565" height="281" destination="#imgDir#/#final_primary_picture_1#" overwrite="yes">
	<cfelse>
	       	<cfset final_primary_picture_1 = "">	
	</cfif>
	
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

<!--- INSERT ARTICLE INFO --->
 
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO campaigns(CampaignsID, ProjectCategoryID, Title, introText, Details, CreditsOffered, FeatureCampaigns, currentstatus, percentcomplete, assignedto, paymentType, PaidIn, campaignspic, campaign_video,
	     dashboard_var_1_label, dashboard_var_1_value, dashboard_var_1_percentage,
		 dashboard_var_2_label, dashboard_var_2_value, dashboard_var_2_percentage,
		 dashboard_var_3_label, dashboard_var_3_value, dashboard_var_3_percentage,
		 dashboard_var_4_label, dashboard_var_4_value, dashboard_var_4_percentage,
		 dashboard_var_5_label, dashboard_var_5_value, dashboard_var_5_percentage,
		 dashboard_var_6_label, dashboard_var_6_value, dashboard_var_6_percentage,
		 Moderators,
	 location, campaigns_order, displaycampaigns, addedby,
	 gallery_pics_1,
	 gallery_pics_2,
	 gallery_pics_3,
	 gallery_pics_4,
	 gallery_pics_5,
	 project_media_image)
	VALUES(#newid#, #form.ProjectCategoryID#, '#form.title#', '#form.introtext#', '#form.details#', '#form.CreditsOffered#', #form.FeatureCampaigns#, '#form.currentstatus#', '#form.percentcomplete#', '#form.assignedto#', '#form.PaymentType#', '#form.PaidIn#', '#localImage1#',
	          <cfif IsDefined("FORM.campaign_video") and #FORM.campaign_video# neq ''> 
				  '#FORM.campaign_video#',
			  <cfelse>
				  '',
			  </cfif> 
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
				  #FORM.dashboard_var_6_percentage#,
			  <cfelse>
				  0,
			  </cfif>
			  
			  <cfif #FORM.Moderators# neq ''> 
				  '#FORM.Moderators#'
			  <cfelse>
				  ''
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
	      '#FORM.addedBy#',
	   <cfelse>
	      '',
	   </cfif> 
	   '#final_gallery_pics_1#', 
	   '#final_gallery_pics_2#',
	   '#final_gallery_pics_3#',
	   '#final_gallery_pics_4#',
	   '#final_gallery_pics_5#',
	   '#final_primary_picture_1#'
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
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=projects&documentID=#documentID#')"></body>
	
	
	</cfoutput>
