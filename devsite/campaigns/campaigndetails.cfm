<cfif IsDefined("URL.campID") and URL.campID neq ''>  
			
<cfset campaign_id = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")>  
 
<cfoutput>
<script src="#request.webroot#/js/campaignJS.js" type="text/javascript"></script> 
<script src="#request.webroot#/js/jquery.hashchange.min.js" type="text/javascript"></script>
<script src="#request.webroot#/lib/jquery.easytabs.min.js" type="text/javascript"></script> 
</cfoutput>
 
<cfinclude template="/campaigns/includeData.cfm"> 
	  
<cfoutput> 
		<div class="headingTitle">  
			 <cfinclude template="/campaigns/headingData.cfm"> 	 		 
	    </div> 
</cfoutput>	  
		 
<div id="tab-container" class='tab-container'>
	 <ul class='etabs'>
	   <li class='tab'><a href="#tabs1-stat"><cfoutput>#hometab#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-updates"><cfoutput>#updatestab#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-ideas"><cfoutput>#ideastab#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-projects"><cfoutput>#project#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-supporters"><cfoutput>#contributors#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-gallery"><cfoutput>#gallerytab#</cfoutput></a></li>
	 </ul>
	 <div class='panel-container'>
		<div id="tabs1-stat"> 
		         <cfoutput>  
					 <div class="fl campaigns-content">
						  <section class="box" style="width: 565px; background: none repeat scroll 0 0 ##FBF9FC; padding: 0px;">
							    <cfinclude template="/campaigns/campaign_video.cfm">
						  </section> 
						  <section id="share" class="fl sharing box rounded shadow" style="width: 450px;">  
								<cfinclude template="/campaigns/sharing_campaign_tool.cfm">   
					      </section>  
						  <section class="box2 rounded shadow" style="width: 531px; padding-top: 0px; padding-left: 20px; padding-right: 20px; padding-bottom: 5px;">
								 <h1 style=" margin: 6px;">
									  #description#
								 </h1> 
								 <p> 
									 <cfif TRIM(getCampaigns.details) neq ''> 
										  #TRIM(getCampaigns.details)#
									 <cfelse>
										  Will be Shortly... 
									 </cfif> 		  
								 </p>
						   </section> 
					 </div> 
					 <aside class="fr sidebar"> 
						   <section class="box rounded shadow">
								 <cfinclude template="/campaigns/dashboard_section.cfm">   
						   </section>   
						   <section class="box rounded shadow">
							     <cfinclude template="/campaigns/rewards_section.cfm">
						   </section>   
						  <section class="box rounded shadow">
							     <cfinclude template="/campaigns/team_section.cfm">
					      </section>  
					 </aside>  
	             </cfoutput>
		</div>
		<div id="tabs1-updates" style="padding: 15px;"> 
		        Updates Coming Soon.......  
		</div>
		<div id="tabs1-ideas" style="padding: 15px;"> 
		     <!---Ideas Coming Soon....... --->
			     <cfinclude template="dsp_ideas.cfm">
		</div>
		<div id="tabs1-projects" style="padding: 15px;">
		      <!---Project Coming Soon....... ---> 
                 <cfinclude template="dsp_tasks.cfm">
		</div>
		<div id="tabs1-supporters" style="padding: 15px;">
			<!---Supporters Coming Soon....... --->
                 <cfinclude template="dsp_contributors.cfm">
		</div>
		<div id="tabs1-gallery" style="padding: 15px;">
			 Gallery Coming Soon.......  
		</div>
	 </div>
</div> 
	  
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>