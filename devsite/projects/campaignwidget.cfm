<cfif IsDefined("URL.campID") and URL.campID neq ''>
 
    <cfset campaign_id = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")>  
	    <cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">  
			SELECT 
			     P.CampaignsID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory,
				 P.CreditsOffered, P.campaignspic, P.details, P.addedby, P.location, P.campaigns_order, P.displaycampaigns, P.PercentComplete
		    FROM campaigns P 
			         INNER JOIN 
				 ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
			WHERE CampaignsID = '#campaign_id#'	 
            Order by P.campaigns_order ASC 
		</cfquery> 
		
		<cfif getCampaigns.recordcount gt 0> 
				<cfset start = 1>
						<table cellpadding="0" cellspacing="0" border="0" width="18%">
						<cfoutput query="getCampaigns">
							<cfif start eq 1>
								  <tr>
							</cfif> 
									 <td valign="top">   
										<div class="fl badge rounded shadow -ce-capture "> 
											<div class="image clearfix">
											  <cfset urlProjTitle = Replace(#TRIM(getCampaigns.Title)#, " ", "-", "ALL")>
											  <a href="#request.webroot#/projects/#getCampaigns.CampaignsID#" target="_parent">
												 <cfif getCampaigns.campaignspic neq ''>
													<img width="220" height="194" src="/images/carcasses_new/#getCampaigns.campaignspic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
												 <cfelse>
													<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
												 </cfif>
											</a></div> 
											<div class="project-category"> 
												   #getCampaigns.ProjectCategory# 
											</div> 
											<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;"> 
												<a href="#request.webroot#/projects/#getCampaigns.CampaignsID#" class="name bold" target="_parent">  
														 <cfset nameNOHTML = ReReplaceNoCase(TRIM(getCampaigns.Title),"<[^>]*>","","ALL") /> 
														 #Mid(TRIM(nameNOHTML),1, 60)#
												</a>	 
												 <p class="description">  
													 <cfset nameNOHTML = ReReplaceNoCase(TRIM(getCampaigns.IntroText),"<[^>]*>","","ALL") /> 
													 #Mid(TRIM(nameNOHTML),1, 110)#...
												 </p> 
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
														  #trim(getCampaigns.location)#
														</span>
													</p>	  
												</cfif>   
											</div>   
												 <div style="border-top: 1px solid ##808080; margin-top: 12px; height: 54px;">
													  <cfset this_percentDone = getCampaigns.PercentComplete>
													 <cfif this_percentDone neq '' and this_percentDone gt 0> 
													 
													     <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
														 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe> 
														 <!---<div style="width: 206px !important; overflow: hidden;"> 
															 <cfinclude template="dsp_percent_bar.cfm"> 
														 </div>--->
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
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>