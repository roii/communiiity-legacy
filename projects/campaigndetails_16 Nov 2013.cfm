<cfif IsDefined("URL.campID") and URL.campID neq ''>
     <cfset campaign_name = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")> 
	    <cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns WHERE Title = '#campaign_name#' 
		</cfquery> 
		
	 <cfset campaignID = #getCampaigns.CampaignsID#>	
	 <!---<cfdump var="#getCampaigns#">  --->
	  <cfoutput> 
		   <div class="headingTitle">
		        <h1>
				    #getCampaigns.TITLE#
				</h1>  
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
				    <tr>
					     <td valign="top" width="20%">
						        <img width="220" height="194" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/#getCampaigns.CAMPAIGNSPIC#">
						 </td>
						 <td valign="top" style="padding-left: 10px;" width="80%">
						        <h2>
									#getCampaigns.INTROTEXT#
								</h2>
								<p style="padding-left: 10px;">
									#getCampaigns.DETAILS#
								</p>
								<div>
									<cfif #trim(getCampaigns.addedby)# neq ''> 
										<p class="creator">by 
											<span class="blue_link">
											  #trim(getCampaigns.addedby)#
											</span>
										</p>
									</cfif>
									<cfif #trim(getCampaigns.location)# neq ''> 
										<p class="blue_link location">
											<span id="project_location">
											  <img src="/images/location_icon-535e43d935ed8bda257a124245e7c6ff.png" border="0" />
											  #trim(getCampaigns.location)#
											</span>
										</p>	  
									</cfif>
								</div>
						 </td>
					</tr>
				</table> 
		   </div>	 
		   <div class="mainbox">
		         <div class="campvidarea">
				     <h1>
					    Campaign Video
					 </h1> 
				 </div>
				 <div class="blankarea"></div>
				 <div class="campstatsarea">
				     <h1>
					    Campaign Stats
					 </h1> 
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <cfif #getCampaigns.CREDITSOFFERED# neq ''>
							<tr>
								 <td width="50%"> 
						              <span class="headingstatsBox">Credit Offered:</span> 
								 </td>
								 <td width="50%">
								      <span class="headingstatsBoxValue">#getCampaigns.CREDITSOFFERED#</span>
								 </td>
							</tr>
						</cfif>
						
						<cfif #getCampaigns.CURRENTSTATUS# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Campaign Status:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.CURRENTSTATUS#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.FINALSTEP# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Final Step:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.FINALSTEP#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.MAXCREDITS# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Maximum Credits:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.MAXCREDITS#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.OTHERIOUS# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">OTHERIOUS:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.OTHERIOUS#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PAIDIN# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Paid In:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.PAIDIN#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PAYMENTTYPE# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Payment Type:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.PAYMENTTYPE#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PERCENTCOMPLETE# neq ''>
							<tr>
								 <td valign="top" colspan="2"> 
						              <span class="headingstatsBox">%age Complete:</span><br />
									    <div style="margin-left: 115px;"> 
								           <cfset this_percentDone = #getCampaigns.PERCENTCOMPLETE#>
											 <cfif this_percentDone neq '' and this_percentDone gt 0> 
												 <div style="width: 301px !important;"> 
													 <cfinclude template="dsp_percent_bar.cfm"> 
												 </div>
											 </cfif>
										</div>	  
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PRIORITY# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Priority:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.PRIORITY#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PROJECTCATEGORYID# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Category:</span> 
								 </td>
								 <td>
								      <cfquery name="getProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
									      SELECT Title FROM ProjectCategories WHERE ProjectCategoryID = #getCampaigns.PROJECTCATEGORYID#
									  </cfquery>
								      <span class="headingstatsBoxValue">#getProjCat.Title#</span>
								 </td>
							</tr>
						</cfif>
						<cfif #getCampaigns.PROJECTIDENTIFIER# neq ''>
							<tr>
								 <td> 
						              <span class="headingstatsBox">Project Identifier:</span> 
								 </td>
								 <td>
								      <span class="headingstatsBoxValue">#getCampaigns.PROJECTIDENTIFIER#</span>
								 </td>
							</tr>
						</cfif>
					</table> 
				 </div>
				 <div class="campideasumarea">
						  <cfquery name="getIdeaTopics" datasource="#dsn#" username="#request.username#" password="#request.password#">
							  SELECT CategoryID, Name, Description, WhenCategoryCreated, WhenCategoryEnded FROM SugCategory WHERE related_campaign = #campaignID# and Active = 1
							  ORDER BY CategoryID DESC
						  </cfquery>
						  <h1>
							 Related Ideas
						  </h1> 
						  <ul>
							  <cfloop query="getIdeaTopics">
							        <li>
									    <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#getIdeaTopics.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" target="_blank">
									        <strong>#getIdeaTopics.Name#</strong> <br />
										</a> 
										 <span style="padding-left: 20px;">#getIdeaTopics.Description#</span> <br /><br />
										 <strong>Started on: </strong>#DateFormat(getIdeaTopics.WhenCategoryCreated, "dd mmmm yyyy")# <br />
										 <strong>Finished on: </strong>#DateFormat(getIdeaTopics.WhenCategoryEnded, "dd mmmm yyyy")#
										    <h1>
											   Ideas/Summaries
										    </h1>
										  <cfquery name="getIdeaSumaries" datasource="#dsn#" username="#request.username#" password="#request.password#">
											  SELECT suggestion, details, WhenSugMade, WhenSugEnded FROM Suggestion WHERE CategoryID = #getIdeaTopics.CategoryID# ORDER BY sugID DESC
										  </cfquery>  
										       <ol>
											         <cfloop query="getIdeaSumaries">
													     <li>
													       <strong>#getIdeaSumaries.suggestion#</strong> <br />
										                   <span style="padding-left: 20px;">#getIdeaSumaries.details#</span> <br /><br />
														   <cfif getIdeaSumaries.WhenSugMade neq ''>
														      <strong>Started on: </strong>#DateFormat(getIdeaSumaries.WhenSugMade, "dd mmmm yyyy")# <br />
										                   </cfif>
														   <cfif getIdeaSumaries.WhenSugEnded neq ''>
														      <strong>Finished on: </strong>#DateFormat(getIdeaSumaries.WhenSugEnded, "dd mmmm yyyy")#
														   </cfif> <br />
														 </li>  
													 </cfloop>
											   </ol>
									</li>
							  </cfloop>
						  </ul>	  
				 </div>
				 <div class="blankarea"></div>
				 <div class="campperkrewarea">
				        <h1>
					        Perk Rewards
					    </h1>  
				 </div>
				 <div class="camptaskssumarea">
				        <h1>
					        Tasks Summary
					    </h1>
						  <cfquery name="getTasksData" datasource="#dsn#" username="#request.username#" password="#request.password#">
							  SELECT Title, IntroText, Details, projectpic, ProjectCategoryID, ProjectID FROM Projects WHERE related_campaign = #campaignID# and displayProject = 1
							  ORDER BY project_order ASC
						  </cfquery>
						  <table cellpadding="0" cellspacing="0" border="0" width="100%"> 
							  <cfloop query="getTasksData">  
								   <tr>
									   <td valign="top" width="20%">
									      <a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=5&projectmode=template&ProjectCategoryID=#trim(getTasksData.ProjectCategoryID)#&ProjectID=#trim(getTasksData.ProjectID)#" target="_blank">
											<img width="220" height="194" alt="Task Pic" title="Task Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/#getTasksData.projectpic#">
										  </a>	
									   </td>
									   <td valign="top" width="80%" style="padding-left: 10px;">
										  <a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=5&projectmode=template&ProjectCategoryID=#trim(getTasksData.ProjectCategoryID)#&ProjectID=#trim(getTasksData.ProjectID)#" target="_blank">	 
											 #getTasksData.Title# <br />
					                      </a>
											 #getTasksData.IntroText# <br /> 
									   </td>
								   </tr>
								   <tr>
								       <td colspan="2">&nbsp;</td>
								   </tr>  
							  </cfloop>
						  </table> 									
				 </div>
				 <div class="blankarea"></div>
				 <div class="campteamarea">
				        <h1>
					        Campaign Teams List
					    </h1> 
				 </div>
		   </div>	   
	  </cfoutput>
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>