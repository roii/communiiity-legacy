<cfif IsDefined("URL.campID") and URL.campID neq ''> 
<script language="JavaScript">
	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Campaign?')) {
	      location.href = aURL;
	    }
	  }
	//--> 
</script> 

     <cfset campaign_id = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")>  
	    <cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns WHERE CampaignsID = '#campaign_id#' 
		</cfquery>   
		<cfset check4DashBoards = 0> 
		<cfif #getCampaigns.dashboard_var_1_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_1_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_1_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>  
	 <cfset campaignID = #getCampaigns.CampaignsID#>	 
	 <cfset categoryID = #getCampaigns.PROJECTCATEGORYID#> 
	    <cfquery name="getCategoryName" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title FROM ProjectCategories WHERE ProjectCategoryID = '#categoryID#' 
		</cfquery> 
		
      <cfquery name="getcontributorIdeasData" datasource="#dsn#" username="#request.username#" password="#request.password#">
		 SELECT DISTINCT sugg.contactID as contactID, scat.Name as ideaTopic FROM SugCategory as scat INNER JOIN Suggestion as sugg ON scat.CategoryID = sugg.CategoryID INNER JOIN Contacts as ct ON ct.ContactID = sugg.contactID
		 WHERE scat.related_campaign = #campaignID#
	  </cfquery> 
	  
	  <cfquery name="getcontributorProjectsData" datasource="#dsn#" username="#request.username#" password="#request.password#">
		 SELECT DISTINCT projcom.contactID as contactID, proj.Title as Project FROM Projects as proj INNER JOIN ProjectComments as projcom ON proj.ProjectID = projcom.ProjectID INNER JOIN Contacts as ct ON ct.ContactID = projcom.contactid
		 WHERE proj.related_campaign = #campaignID#
	  </cfquery> 
		 
	  <cfoutput> 
		   <div class="headingTitle">  
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
				    <tr>
					     <td valign="top" width="10%" style="padding-right: 15px;">
						 
						         <cfif getCampaigns.CAMPAIGNSPIC neq ''>
									<img width="90" height="90" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/#getCampaigns.CAMPAIGNSPIC#">
								 <cfelse> 
									<img width="90" height="90" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/no_image.png">
								 </cfif>  
						 </td> 
						 <td valign="top" width="60%" style="padding-left: 10px;">
						         <cfif session.UserType EQ 'Administrator'>
									<cfset allowTasks = 1>
								 <cfelse>
									<cfset allowTasks = 0> 
								 </cfif> 
								 <cfif allowTasks eq 1>  
									  <a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#campaignID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')">
										  <img src="#request.webroot#/icons/Edit-icon.png" height="20" width="20" alt="Edit this Project" border="0">
									  </a> 
									  <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#campaignID#&documentID=#documentID#')">
										  <img src="#request.webroot#/icons/delete.png" height="20" width="20" alt="Delete this Project" border="0">
									  </a>
									  <br />
								 </cfif>
						        <span style="font-size: 20pt;">
									#getCampaigns.TITLE#
								</span><br />
						        <span style="font-size: 12pt;">
									#getCampaigns.INTROTEXT#
								</span> 
								<div> 
									<cfif #trim(getCampaigns.location)# neq ''> 
										<p class="blue_link location">
											<span id="project_location" style="font-size: 12pt;">
											   #getCategoryName.Title# - #trim(getCampaigns.location)#
											</span>
										</p>	  
									</cfif>  
								</div> 
						 </td>
					</tr>
				</table> 
		   </div>	 
		   <div class="mainbox">
		         
				 <div class="fl campaigns-content">
				      <div class="campvidarea">   
					      <cfset videoPlayerCheck = Find('vimeo.com', #getCampaigns.campaign_video#)>	 
						  <cfif #videoPlayerCheck# gt 0>
						        <cfset videoArr = ListToArray(#getCampaigns.campaign_video#, "/")>
								<cfset videoID  = videoArr[3]>
								             <object width="450" height="281">
											       <param name="allowfullscreen" value="true" />
												   <param name="allowscriptaccess" value="always" />
												   <param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=#videoID#&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=00adef&fullscreen=1" />
												   <embed src="http://vimeo.com/moogaloop.swf?clip_id=#videoID#&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=00adef&fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="450" height="281"></embed>
											 </object>
						 <cfelse>
						          <cfset videoPlayerCheck2 = Find('youtube.com', #getCampaigns.campaign_video#)>
								   <cfif #videoPlayerCheck2# gt 0>
								         <cfset videoArrF = ListToArray(#getCampaigns.campaign_video#, "/")>
										 <cfset videoArr = ListToArray(#videoArrF[3]#, "watch?")>
										 <cfset videoID  = Right(videoArr[1], Len(videoArr[1])-2)>
										   <br />
											<object width="450" height="281">
											   <param name="movie" value="http://www.youtube.com/v/#videoID#" />
											   <embed src="http://www.youtube.com/v/#videoID#" type="application/x-shockwave-flash" width="450" height="281" />
											</object>
								   <cfelse>
								         <p>
										     You have entered the wrong URL for video. It should only be Youtube or Vimeo.
										 </p>
								   </cfif>
						 </cfif> 
				      </div>
					  <div class="campideasumarea">
					      <section class="fl sharing box rounded shadow" id="share" style="height: 120px; width: 379px;">  
					    <cfscript>
							// define the user variables
							strUser 	= 'gr8developervm';
							strKey		= 'R_cedc7b73201d55f62225e132a8be11c2'; 
							// instantiate the object
							objBitly = createObject('component', 
								'com.coldfumonkeh.bitly.bitly')
								.init(
									username	=	strUser,
									apikey		=	strKey,
									parse		=	true
								); 
							// let's shorten a URL
							shorten = objBitly.shorten(longURL='#request.webroot#/campaigns/#campaignID#',format='json',domain='j.mp');
						</cfscript> 
					    <h2 style="margin-right:10px;" class="fl label bold">Share This Campaign:</h2>
								<div class="share-link clearfix">
								     <div class="fl input-item-text clearfix">
									     <div style="position:absolute;padding-top:5px;padding-left:2px;" id="d_clip_container">
									            <img width="32px" height="18px" src="#request.webroot#/images/icon_share_link-a6089e92716208c9626b3616059fbcf1.PNG" id="d_clip_button" alt="Icon_share_link" class=""> 
										  </div>
									      <input type="text" readonly="" style="padding-left:30px; width:309px;" value="#shorten.data.url#" onclick="true;javascript:this.select();" name="sharing_url" class="rounded inner-shadow" id="clip_text"> 
								      </div> 
									<script type="text/javascript" src="/assets/igg/projects/follow_link-d4ce5aef9fbe6a77b4cdfe5f13449a06.js"></script>
										<span class="fr add-to-favorites">
											  <a class="follow" href="##">
											  Follow
											  </a> 
									    </span>
							    </div> 
								<div class="fl social-networks"> </div> 
								<div class="fr tools">
									  <a class="fl embed white-button rounded" href="##" oldtitle="Click to share on your website or blog">
										Embed</a> 
									  <a onclick="return true;" class="fl email white-button rounded" href="##">Email</a> 
								</div>
				       </section> 	      
				      </div>
					  <div class="camptaskssumarea">
						  <section class="box2 rounded shadow" style="height: 300px; width: 460px;">
								 <h1>
									  #description#
								 </h1>
								 <p> 
									 <cfif TRIM(getCampaigns.details) neq ''>
										  <!--- <cfset descNOHTML = ReReplaceNoCase(TRIM(getCampaigns.details),"<[^>]*>","","ALL") />
										 <cfset descData = #ReReplace(TRIM(descNOHTML),"\b(\w)","\u\1","ALL")#>
											  #Mid(TRIM(descNOHTML),1, 1200)# --->
											  #TRIM(getCampaigns.details)#
									 <cfelse>
										  Will be Shortly... 
									 </cfif> 		  
								 </p>
						   </section>   								
				      </div>
				 </div>
				 
				 <aside class="fr">
				      <div class="campstatsarea">
				          <section class="box rounded shadow" style="height: 240px;">
						     <h1>
							      #dashboard#
							 </h1>
							 <cfif check4DashBoards eq 0>
							        <p>
									     Will be Shortly...
									</p>
							 <cfelse>
							          <table cellpadding="0" cellspacing="0" border="0" width="100%">
									      <cfif #getCampaigns.dashboard_var_1_label# neq "" and #getCampaigns.dashboard_var_1_value# neq "" and #getCampaigns.dashboard_var_1_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_1_label#(#getCampaigns.dashboard_var_1_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_1_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>	
										  
										  <cfif #getCampaigns.dashboard_var_2_label# neq "" and #getCampaigns.dashboard_var_2_value# neq "" and #getCampaigns.dashboard_var_2_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_2_label#(#getCampaigns.dashboard_var_2_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_2_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>
										  
										  <cfif #getCampaigns.dashboard_var_3_label# neq "" and #getCampaigns.dashboard_var_3_value# neq "" and #getCampaigns.dashboard_var_3_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_3_label#(#getCampaigns.dashboard_var_3_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_3_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>
										  
										  <cfif #getCampaigns.dashboard_var_4_label# neq "" and #getCampaigns.dashboard_var_4_value# neq "" and #getCampaigns.dashboard_var_4_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_4_label#(#getCampaigns.dashboard_var_4_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_4_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>
										  
										  <cfif #getCampaigns.dashboard_var_5_label# neq "" and #getCampaigns.dashboard_var_5_value# neq "" and #getCampaigns.dashboard_var_5_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_5_label#(#getCampaigns.dashboard_var_5_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_5_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>
										  
										  <cfif #getCampaigns.dashboard_var_6_label# neq "" and #getCampaigns.dashboard_var_6_value# neq "" and #getCampaigns.dashboard_var_6_percentage# neq "">
												  <tr>
														<td valign="top">
														        #getCampaigns.dashboard_var_6_label#(#getCampaigns.dashboard_var_6_value#)
														</td> 
														<td valign="top"> 
																<cfset this_percentDone = getCampaigns.dashboard_var_6_percentage>
																 <cfif this_percentDone neq '' and this_percentDone gt 0>  
																	 <div style="width: 206px !important; overflow: hidden;"> 
																		 <cfinclude template="dsp_percent_bar.cfm"> 
																	 </div>
																 </cfif>
														</td>
												  </tr>
										  </cfif>	  
									  </table> 
							 </cfif>
				       </section>  
				      </div>
					  <div class="campperkrewarea">
				          <section class="box rounded shadow" style="height: 180px;">
						     <h1>
							      #rewards#
							 </h1>
							 <cfquery name="getRewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
								SELECT TOP 3 * FROM Prize_Pool WHERE related_campaign = #campaignID# and deleted=0 
							 </cfquery>
		                     
							 <table cellpadding="0" cellspacing="0" border="0" width="100%">
							     <tr>
								   <cfif getRewards.recordcount gt 0>  
									 <cfloop query="getRewards">
									         <td>  
												  <div style="width: 100px; padding: 10px">
													 <img width="80" height="60" border="0" src="#request.webroot#/images/prize/#getRewards.image#"> 
													 <br />
													 #UCase(getRewards.name)# 
												  </div> 
											 </td>
									 </cfloop>
								   <cfelse>
								     Will be Shortly... 
								   </cfif>	 
								 </tr>
							 </table>
							 
				       </section>   
				      </div>
					  <div class="campteamarea">
				          <section class="box rounded shadow" style="height: 300px;">
						     <h1>
							      #team#
							 </h1>
							      <cfset contactIDArr = ListToArray(#getCampaigns.Moderators#, ",")> 
								  <cfset totalteams   = ArrayLen(contactIDArr)>
							 <span>
							      <cfif totalteams gt 0>
									  <cfloop from="1" to="#totalteams#" index="i">
											  <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
												  SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts WHERE contactid = #contactIDArr[i]#
											  </cfquery>
											  <cfif #getProfilePic.profilepic# neq ''>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
													   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											  <cfelse>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
														<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											  </cfif>	  
									  </cfloop> 
								   <cfelse>
								       	 Will be Shortly...   
								   </cfif>	  
							 </span>
							 <br />
							 <h1>
							      #contributors#
							 </h1>
							 <span> 
							       <cfif getcontributorIdeasData.recordcount gt 0>
									   <cfloop query="getcontributorIdeasData">
											   <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#">
													 SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts
													  WHERE contactid = #getcontributorIdeasData.CONTACTID#
											   </cfquery>
											   <cfif #getProfilePic.profilepic# neq ''>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
													   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											   <cfelse>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
														<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											   </cfif>
									   </cfloop>
								   <cfelse>
								       	 Will be Shortly...	    
								   </cfif> 	   
							 </span>
							 <span> 
							       <cfif getcontributorProjectsData.recordcount gt 0>
									   <cfloop query="getcontributorProjectsData">
											   <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#">
													 SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts
													  WHERE contactid = #getcontributorProjectsData.CONTACTID#
											   </cfquery>
											   <cfif #getProfilePic.profilepic# neq ''>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
													   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											   <cfelse>
												  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
														<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
												  </a>
											   </cfif>
									   </cfloop> 
								   </cfif>	   
							 </span>
				       </section>   
				      </div>
				 </aside> 
				 
		   </div> 
	  	   
	  </cfoutput>
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>