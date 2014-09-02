<cfif IsDefined("URL.campID") and URL.campID neq ''>
     <cfset campaign_name = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")> 
	    <cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns WHERE Title = '#campaign_name#' 
		</cfquery>  
	 <cfset campaignID = #getCampaigns.CampaignsID#>	 
	  <cfoutput> 
		   <div class="headingTitle">  
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
				    <tr>
					     <td valign="top" width="10%" style="padding-right: 15px;">
						         <img width="90" height="90" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/#getCampaigns.CAMPAIGNSPIC#">
						 </td> 
						 <td valign="top" width="60%" style="padding-left: 10px;">
						        <span style="font-size: 20pt;">
									#getCampaigns.TITLE#
								</span><br />
						        <span style="font-size: 12pt;">
									#getCampaigns.INTROTEXT#
								</span> 
								<div>
									<cfif #trim(getCampaigns.addedby)# neq ''> 
										<p class="creator" style="font-size: 12pt;">by 
											<span class="blue_link" style="font-size: 12pt;">
											  #trim(getCampaigns.addedby)#
											</span>
										</p>
									</cfif>
									<cfif #trim(getCampaigns.location)# neq ''> 
										<p class="blue_link location">
											<span id="project_location" style="font-size: 12pt;">
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
				       <section class="box rounded shadow">
						     <h1>
							      #campvidtitle#
							 </h1>
				       </section>
				 </div>
				 <div class="blankarea"></div>
				 <div class="campstatsarea">
				       <section class="box rounded shadow">
						     <h1>
							      #dashboard#
							 </h1>
				       </section>  
				 </div>
				 <div class="campideasumarea">
					   <section class="box rounded shadow">
						     <h1>
							      #sharingtools#
							 </h1>
				       </section> 	      
				 </div>
				 <div class="blankarea"></div>
				 <div class="campperkrewarea">
				       <section class="box rounded shadow">
						     <h1>
							      #rewards#
							 </h1>
							 <cfquery name="getRewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
								SELECT TOP 3 * FROM Prize_Pool WHERE related_campaign = #campaignID# and deleted=0 
							 </cfquery>
		                     
							 <table cellpadding="0" cellspacing="0" border="0" width="100%">
							     <tr>
								     
									 <cfloop query="getRewards">
									         <td>  
												  <div style="border: 1px solid grey; width: 100px; padding: 10px">
													 <img width="80" height="60" border="0" src="#request.webroot#/images/prize/#getRewards.image#"> 
													 <br />
													 #UCase(getRewards.name)# 
												  </div> 
											 </td>
									 </cfloop>
									 
								 </tr>
							 </table>
							 
				       </section>   
				 </div>
				 <div class="camptaskssumarea">
				       <section class="box rounded shadow">
						     <h1>
							      #description#
							 </h1>
							 <p>
							      #getCampaigns.Details#
							 </p>
				       </section>   								
				 </div>
				 <div class="blankarea"></div>
				 <div class="campteamarea">
				       <section class="box rounded shadow">
						     <h1>
							      #team#
							 </h1>
							 <br />
							 <h1>
							      #contributors#
							 </h1>
				       </section>   
				 </div>
		   </div> 
	  	   
	  </cfoutput>
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>