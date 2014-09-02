<cfinclude template="../app_globals.cfm"> 
<cfinclude template="../templates/set_language.cfm">

<cfif IsDefined("FORM.autocomplete") and FORM.autocomplete neq ''>

	<cfquery name="getOldEmailIDData" datasource="#dsn#" username="#request.username#" password="#request.password#">
	  SELECT * FROM campaigns WHERE CampaignsID = #FORM.CampaignsID#
	</cfquery> 
    <cfset MODERATORS = getOldEmailIDData.MODERATORS>
    <cfif find(",", MODERATORS)>
		<cfset userIDArra = ListToArray(MODERATORS, ",")>
		<cfset oldUID = userIDArra[2]>
    <cfelse>
		<cfset oldUID = MODERATORS>
    </cfif> 
    <cfquery name="getoldEmailID" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Contacts.EmailAddress FROM Contacts WHERE Contacts.ContactID = #oldUID#
	</cfquery>
    <cfset oldEmailID = #getoldEmailID.EmailAddress#> 
	
	<cfset name = FORM.autocomplete>
	<cfset nameArray = ListToArray(FORM.autocomplete, " (")> 
	<cfif IsDefined("nameArray") and IsArray(nameArray) and not ArrayIsEmpty(nameArray)>
	   <cfif Find("@", nameArray[1])>
	        <cfset emailID = nameArray[1]>
	   <cfelseif Find("@", nameArray[3])>
	        <cfset emailID = nameArray[3]>
	   </cfif>
		<cfset emailID = Replace(#emailID#, ")", "", "ALL")> 
		<cfquery name="getUserID" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Contacts.ContactID FROM Contacts WHERE Contacts.EmailAddress = '#emailID#'
		</cfquery> 
		    <cfset userID = getUserID.ContactID>
			<cfset projectModerators = FORM.projectOwner & "," & userID> 
			<cfset userEmailIDtoSend = userID> 
	<cfelse>
	        <cfset projectModerators = ''>
			<cfset userEmailIDtoSend = ''> 
			<cfset oldEmailID = ''>
			<cfset emailID = ''>
	</cfif> 
<cfelse>
    <cfset projectModerators = FORM.projectOwner> 
</cfif>  
 
<cfset MAINCATEGORY = FORM.MAINCATEGORY>
<cfset projectCategoryIDs = ListToArray(FORM.PROJECTCATEGORYID, ",")>

	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
	<cfif IsDefined("FORM.campaign_video") and FORM.campaign_video neq ''>
	    <cfset campaign_video = FORM.campaign_video>
	<cfelse>
	    <cfset campaign_video = "">	
	</cfif>
	
	<cfif len(primary_picture)> 
	        <cffile action="upload" filefield="form.primary_picture" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	        <cfset primary_picture1 =  #CFFILE.ServerFile#>   
			<cfset final_primary_picture_1 =  "final_" & #primary_picture1#>
			<cfimage source="#imgDir#/#primary_picture1#" action="resize" width="565" height="281" destination="#imgDir#/#final_primary_picture_1#" overwrite="yes">
			<cfset campaign_video = "">
	<cfelseif IsDefined('FORM.primary_picture_edit') and FORM.primary_picture_edit neq ''>
	        <cfif campaign_video neq ''> 
			      <cfset final_primary_picture_1 = "">	
			<cfelse>
			      <cfset final_primary_picture_1 =  #FORM.primary_picture_edit#>
			      <cfset campaign_video = "">
			</cfif> 
	<cfelse>
	       	<cfset final_primary_picture_1 = "">	
	</cfif>
	
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
	SET Title='#form.title#',
	MainProjectCategoryID = #MAINCATEGORY#,
	introText='#form.introtext#',
	Details='#form.details#',  
	CreditsOffered='#form.CreditsOffered#',
	AssignedTo='#form.assignedto#',
	PercentComplete=#form.percentcomplete#,
	currentstatus='#form.currentstatus#',	
	FeatureCampaigns=#form.FeatureCampaigns#,
	PaymentType='#form.PaymentType#',
	PaidIn='#form.PaidIn#',
	campaign_video = '#campaign_video#', 
	<cfif #FORM.userTypeIsAdmin# eq "yes" and #projectModerators# neq ''> 
	   Moderators = '#projectModerators#',
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
	  project_media_image  = '#final_primary_picture_1#', 
	<cfif IsDefined("form.ProjectPriority") and #form.ProjectPriority# neq ''>
	  Priority = '#form.ProjectPriority#'
	<cfelse>
	  Priority = ''
	</cfif> 
	WHERE CampaignsID=#form.CampaignsID#
	</cfquery>

	
	<cfif IsArray(projectCategoryIDs) and not ArrayIsEmpty(projectCategoryIDs)>
	      <cfoutput>
		        <cfset totalprojectCats = ArrayLen(projectCategoryIDs)> 
						<cfquery name="selectProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
							 SELECT * FROM ProjectCategoryRelation 
							   WHERE ProjectID = #form.CampaignsID#
						</cfquery> 
					    <cfif selectProjCat.recordcount gt 0>
							<cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
								 DELETE FROM ProjectCategoryRelation 
								   WHERE ProjectID =#form.CampaignsID#
							</cfquery> 
						</cfif>	
		            <cfloop from="1" to="#totalprojectCats#" index="i">  
						   <cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
						         INSERT INTO ProjectCategoryRelation 
								 (ProjectID, ProjectCategoryID)
								 VALUES
								 (#form.CampaignsID#, #projectCategoryIDs[i]#)
						   </cfquery>
		            </cfloop>
		  </cfoutput>
	</cfif>
	
	<cfif IsDefined("oldEmailID") and oldEmailID neq '' and IsDefined("emailID") and emailID neq ''> 
	       <cfif oldEmailID neq emailID>
		             <!---Sending an email to new user added--->  
					 <cfoutput>  
						 <cfmail to="#TRIM(emailID)#" from="#FORM.EmailAlertFrom#" subject="#emailtext1#" type="html">
							<!DOCType HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
							<html>
							<head>
							<title>#emailtext1#</title>
							</head> 
							<body> 
								 <h1>#emailtext1#</h1><br />
								 #emailtext2#: <br />
								 <a href="#request.webroot#/projects/#form.CampaignsID#">
									 #emailtext3#
								 </a>
								 <p>
									 #emailtext4#.
								 </p>
							</body>
							</html>
						 </cfmail> 
					</cfoutput>
					<!---Sending an email to old user regarding remove from project--->  
					 <cfoutput>  
						 <cfmail to="#TRIM(oldEmailID)#" from="#FORM.EmailAlertFrom#" subject="You have been removed from the project" type="html">
							<!DOCType HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
							<html>
							<head>
							<title>You have been removed from the project</title>
							</head> 
							<body> 
								 <h1>You have been removed from the project.</h1><br />
								 Please refer below project URL from where you have been removed: <br>
								 <a href="#request.webroot#/projects/#form.CampaignsID#">
									 #emailtext3#
								 </a> 
							</body>
							</html>
						 </cfmail> 
					</cfoutput>
		   <cfelse> 
		   </cfif>
    </cfif> 
	 

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	<cflocation url="#request.webroot#/projects/#form.CampaignsID#" addtoken="no">
	<!---<script language="JavaScript">
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
--->