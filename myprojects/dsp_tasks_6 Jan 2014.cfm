<cfoutput>
<cfquery name="getTasks" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT P.ProjectID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered, P.projectpic, P.details, P.addedby, P.location, P.project_order, P.displayProject, P.PercentComplete FROM Projects as P
  INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
  WHERE related_campaign = #campaignID# and displayProject = 1
  ORDER BY ProjectID DESC
</cfquery>
 
<h1>
 Related Tasks
</h1> 
<cfset totaltasks = getTasks.recordcount>

<cfif totaltasks gt 0>
	 <cfset start = 1>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<cfloop query="getTasks">
					<cfif start eq 1>
						  <tr>
					</cfif> 
							 <td valign="top">   
								<div class="fl badge rounded shadow -ce-capture "> 
									<div class="image clearfix"> 
									  <a href="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=index&documentID=5&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(getTasks.ProjectID)#" target="_blank">
										 <cfif getTasks.projectpic neq ''>
											<img width="220" height="194" src="/images/carcasses_new/#getTasks.projectpic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
										 <cfelse>
											<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
										 </cfif>
									</a></div>
									
									<div class="project-category"> 
										   #getTasks.ProjectCategory# 
									</div>
									
									<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;"> 
										<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(getTasks.ProjectID)#" class="name bold" target="_blank"> 
												<cfset nameNOHTML = ReReplaceNoCase(TRIM(getTasks.IntroText),"<[^>]*>","","ALL") />
												 <!---#ReReplace(TRIM(nameNOHTML),"\b(\w)","\u\1","ALL")#--->
												 #Mid(TRIM(nameNOHTML),1, 150)#
										</a>	
										<cfif #trim(getTasks.addedby)# neq ''> 
											<p class="creator">by 
												<span class="blue_link">
												  #trim(getTasks.addedby)#
												</span>
											</p>
										</cfif>
										<cfif #trim(getTasks.location)# neq ''> 
											<p class="blue_link location">
												<span id="project_location">
												  #trim(getTasks.location)#
												</span>
											</p>	  
										</cfif>
										 <p class="description">
											 <cfset descNOHTML = ReReplaceNoCase(TRIM(getTasks.details),"<[^>]*>","","ALL") />
											 <!---<cfset descData = #ReReplace(TRIM(descNOHTML),"\b(\w)","\u\1","ALL")#>--->
											 #Mid(TRIM(descNOHTML),1, 100)#... 
										 </p>  
									</div>  
									   
									     <div style="border-top: 1px solid ##808080; margin-top: 12px; height: 67px;">
										      <cfset this_percentDone = getTasks.PercentComplete>
											 <cfif this_percentDone neq '' and this_percentDone gt 0>
												 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/tasks/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
												 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
												 <iframe src="#request.webroot#/tasks/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe> 
												 <!---<div style="width: 206px !important; overflow: hidden;"> 
													 <cfinclude template="dsp_percent_bar.cfm"> 
												 </div>--->
											 </cfif> <br />
											 <span style="margin-left: 10px;">
													 <a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#getTasks.projectID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete.cfm?projectID=#getTasks.projectID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a>
											 </span>		 
										 </div>
										  
								</div>	  
							 </td>
					<cfif start MOD 3 eq 0>
						  </tr>
						  <tr>
					</cfif> 
					<cfset start = start + 1>
				</cfloop>
			</table> 	
	<cfif totaltasks gt 5>
			<a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=index&documentID=5">
				 Read More Tasks...
			</a>
	</cfif>
<cfelse>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
			    <tr>
				     <td> 
						  <img src="/images/DataNotFound.jpg" border="0" />
					 </td>
				</tr>
    </table>
</cfif>
	
</cfoutput>