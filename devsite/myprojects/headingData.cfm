<cfoutput>
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
				 <cfelse>  
				      <cfif IsDefined("session.userid") and session.UserIsAuthenticated EQ 'Yes'>
							<cfset MODERATORS = getCampaigns.MODERATORS><!---#session.userid#--->
							<cfset moderaArr  = ArrayNew(1)>
							<cfif find(",", MODERATORS) gt 0>
								   <cfset moderaArr = ListToArray(MODERATORS,",")>
							<cfelse>
								   <cfset moderaArr[1] = MODERATORS>
							</cfif> 
							<cfif ArrayFind(moderaArr, #session.userid#) gt 0> 
								  <a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#campaignID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')">
							  <img src="#request.webroot#/icons/Edit-icon.png" height="20" width="20" alt="Edit this Project" border="0">
								  </a> 
								  <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#campaignID#&documentID=#documentID#')">
									  <img src="#request.webroot#/icons/delete.png" height="20" width="20" alt="Delete this Project" border="0">
								  </a>
								  <br /> 
							</cfif>
					  </cfif>		
				 </cfif>
				<span style="font-size: 20pt;">
					#getCampaigns.TITLE#
				</span><br />
				<span style="font-size: 12pt;">
					<!---#getCampaigns.INTROTEXT#--->
					<cfset INTROTEXTNOHTML = ReReplaceNoCase(TRIM(getCampaigns.INTROTEXT),"<[^>]*>","","ALL") />
					 <cfset INTROTEXTData = #ReReplace(TRIM(INTROTEXTNOHTML),"\b(\w)","\u\1","ALL")#>
						  #Mid(TRIM(INTROTEXTData),1, 400)#  
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
</cfoutput>