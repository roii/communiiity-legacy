<cfinclude template="../app_globals.cfm"> 
<cfinclude template="../templates/set_language.cfm">

<cfif IsDefined("FORM.autocomplete") and FORM.autocomplete neq ''>
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
	</cfif> 
<cfelse>
    <cfset projectModerators = FORM.projectOwner> 
</cfif> 
 
<cfset MAINCATEGORY = FORM.MAINCATEGORY> 

<cfset projectCategoryIDs = ListToArray(FORM.PROJECTCATEGORYID, ",")>
 

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
	INSERT INTO campaigns(CampaignsID, MainProjectCategoryID, Title, introText, Details, CreditsOffered, FeatureCampaigns, currentstatus, percentcomplete, assignedto, paymentType, PaidIn, campaignspic, campaign_video,
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
	VALUES(#newid#, #MAINCATEGORY#, '#form.title#', '#form.introtext#', '#form.details#', '#form.CreditsOffered#', #form.FeatureCampaigns#, '#form.currentstatus#', '#form.percentcomplete#', '#form.assignedto#', '#form.PaymentType#', '#form.PaidIn#', '#localImage1#',
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
			  
			  '#projectModerators#'
			  
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
	   <cfif IsDefined("FORM.displaycampaigns") and FORM.displaycampaigns neq "">
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

	<cfif IsArray(projectCategoryIDs) and not ArrayIsEmpty(projectCategoryIDs)>
	      <cfoutput>
		        <cfset totalprojectCats = ArrayLen(projectCategoryIDs)>
						<cfquery name="selectProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
							 SELECT * FROM ProjectCategoryRelation 
							   WHERE ProjectID = #newid#
						</cfquery> 
					    <cfif selectProjCat.recordcount gt 0>
							<cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
								 DELETE FROM ProjectCategoryRelation 
								   WHERE ProjectID = #newid#
							</cfquery> 
						</cfif>	
		            <cfloop from="1" to="#totalprojectCats#" index="i">  
						   <cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
						         INSERT INTO ProjectCategoryRelation 
								 (ProjectID, ProjectCategoryID)
								 VALUES
								 (#newid#, #projectCategoryIDs[i]#)
						   </cfquery>
		            </cfloop>
		  </cfoutput>
	</cfif>
	
	 <cfif IsDefined("userEmailIDtoSend") and userEmailIDtoSend neq ''>
			 <cfquery name="selectProjContactEmailID" datasource="#dsn#" username="#request.username#" password="#request.password#">
				 SELECT EmailAddress FROM contacts 
				   WHERE ContactID = #userEmailIDtoSend#
			 </cfquery>  
			 <cfset EmailAddress = selectProjContactEmailID.EmailAddress> 
			 <cfoutput>  
				 <cfmail to="#TRIM(EmailAddress)#" from="#FORM.EmailAlertFrom#" subject="#emailtext1#" type="html">
					<!DOCType HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
					<html>
					<head>
					<title>#emailtext1#</title>
					</head> 
					<body> 
						 <h1>#emailtext1#</h1><br />
						 #emailtext2#: <br />
						 <a href="#request.webroot#/projects/#newid#">
							 #emailtext3#
						 </a>
						 <p>
							 #emailtext4#.
						 </p>
					</body>
					</html>
				 </cfmail>
			</cfoutput>
     </cfif> 

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<!---<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>--->
	<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&documentID=#documentID#" addtoken="no">
	
	<!---<cfoutput>
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=projects&documentID=#documentID#')"></body>
	
	
	</cfoutput>--->
