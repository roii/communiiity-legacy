<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'>
<div> 
    <cfset userID = #SESSION.userid#>
    
	    <p style="font-size: 14px; font-weight: bold;">
		      <cfoutput>#followedprojheading#</cfoutput>
		</p>
	  
				<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT P.CampaignsID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered, P.campaignspic, P.details, P.addedby, P.location, P.campaigns_order, P.displaycampaigns, P.PercentComplete
					FROM campaigns P INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID 
					INNER JOIN followed_campaigns as follc ON follc.campaignid = P.CampaignsID
					WHERE follc.userid = #userID#
					Order by P.campaigns_order ASC
				</cfquery>
				 <cfif ProjectDetails.recordcount gt 0>  
					<cfset start = 1>
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<cfoutput query="ProjectDetails">
							<cfif start eq 1>
								  <tr>
							</cfif> 
									 <td valign="top">   
										<div class="fl badge rounded shadow -ce-capture "> 
											<div class="image clearfix">
											  <cfset urlProjTitle = Replace(#TRIM(ProjectDetails.Title)#, " ", "-", "ALL")>  
											  
											  <a href="#request.webroot#/projects/#ProjectDetails.CampaignsID#">
												 <cfif ProjectDetails.campaignspic neq ''>
													<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.campaignspic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
												 <cfelse>
													<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
												 </cfif>
											</a></div>
											
											<div class="project-category"> 
												   #ProjectDetails.ProjectCategory# 
											</div>
											
											<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;"> 
												<a href="#request.webroot#/projects/#ProjectDetails.CampaignsID#" class="name bold">  
														 <cfset nameNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.Title),"<[^>]*>","","ALL") />
														 <!---#ReReplace(TRIM(nameNOHTML),"\b(\w)","\u\1","ALL")#--->
														 #Mid(TRIM(nameNOHTML),1, 60)#
												</a>	 
												 <p class="description">
													 <!---<cfset descNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.details),"<[^>]*>","","ALL") />
													 <!---<cfset descData = #ReReplace(TRIM(descNOHTML),"\b(\w)","\u\1","ALL")#>--->
													 #Mid(TRIM(descNOHTML),1, 100)#...---> 
													 <cfset nameNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.IntroText),"<[^>]*>","","ALL") />
													 <!---#ReReplace(TRIM(nameNOHTML),"\b(\w)","\u\1","ALL")#--->
													 #Mid(TRIM(nameNOHTML),1, 90)#...
												 </p> 
												 <cfif #trim(ProjectDetails.addedby)# neq ''> 
													<p class="creator">by 
														<span class="blue_link">
														  #trim(ProjectDetails.addedby)#
														</span>
													</p>
												</cfif>
												<cfif #trim(ProjectDetails.location)# neq ''> 
													<p class="blue_link location">
														<span id="project_location">
														  #trim(ProjectDetails.location)#
														</span>
													</p>	  
												</cfif> 
											</div>   
												 <div style="border-top: 1px solid ##808080; margin-top: 12px; height: 60px;">
													  <cfset this_percentDone = ProjectDetails.PercentComplete>
													 <cfif this_percentDone neq '' and this_percentDone gt 0> 
														 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
														 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>  
													 </cfif>  
												 </div>
												  
										</div>	  
									 </td>
							<cfif start MOD 3 eq 0>
								  </tr>
								  <tr>
							</cfif> 
							<cfset start = start + 1>
						</cfoutput>
					</table> 
				 <cfelse>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								 <td> 
									  <img src="/images/DataNotFound.jpg" border="0" />
								 </td>
							</tr>
						</table>   		
				 </cfif>
</div>
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>