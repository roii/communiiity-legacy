<cfoutput>
<!---<cfquery name="getIdeaTopics" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT CategoryID, Name, Description, WhenCategoryCreated, WhenCategoryEnded FROM SugCategory WHERE related_campaign = #campaignID# and Active = 1
  ORDER BY CategoryID DESC
</cfquery>---> 
<cfquery name="qry_all_maincats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MainCatID, MainCatTitle, DisplayOrder, Active
FROM SugMainCategory
WHERE Active=1
ORDER BY DisplayOrder
</cfquery>

<h1>
 #relatedIdeas#
</h1> 

<cfset totalideas = qry_all_maincats.recordcount>

<cfif qry_all_maincats.recordcount gt 0> 
	<cfset start = 1> 
			<cfset ctr   = 0> 
						   <table cellpadding="0" cellspacing="0" border="0" width="100%"> 
								<cfloop query="qry_all_maincats"> 
									   <cfset this_MainCatID = qry_all_maincats.MainCatID>  
											<cfquery name="qry_all_categories" datasource="#dsn#" username="#request.username#" password="#request.password#">
												SELECT *
												FROM SugCategory
												WHERE Active = 1 and related_campaign = #campaignID# 
												AND MainCatID=#this_MainCatID#
												<cfif isdefined("FORM.search_keyword")>
													<cfif FORM.search_keyword neq ''>  
														   and (name LIKE '%#trim(FORM.search_keyword)#%' or description LIKE '%#trim(FORM.search_keyword)#%') 
													</cfif> 
												</cfif>
												ORDER BY CategoryID DESC
											</cfquery> 
											<cfif IsDefined("DocumentID")>
											<cfelse>
												<cfset documentID=75>
											</cfif> 
											<cfif qry_all_categories.recordcount gt 0> 	 
												 <cfset ctr = ctr + 1>									
													<cfloop query="qry_all_categories">
													
													<cfset this_categoryID = qry_all_categories.categoryID>
													<cfset this_SponsorID = qry_all_categories.SponsorID>
													<cfset this_PointsAllocated = qry_all_categories.PointsAllocated>
													<cfset this_WhenCategoryEnded = qry_all_categories.WhenCategoryEnded>
													<cfset this_PointsCutOff = qry_all_categories.PointsCutOff>
													
													<cfinclude template="act_topic_stages.cfm">
													
													<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT suggestion.sugID
													FROM suggestion, Contacts
													WHERE suggestion.ContactID=Contacts.ContactID
													AND suggestion.Authorise = 'yes'
													AND suggestion.Archived=0
													AND suggestion.categoryID=#this_categoryID#
													AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
													</cfquery>
													
													<cfquery name="AllCat_ToVoteIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT suggestion.sugID
													FROM suggestion, Contacts
													WHERE suggestion.ContactID=Contacts.ContactID
													<cfif IsDefined("session.UserID")>
													AND Contacts.ContactID <> #session.UserID#
													</cfif>
													AND suggestion.Authorise = 'yes'
													AND suggestion.Archived=0
													AND suggestion.categoryID=#this_categoryID#
													AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
													</cfquery>
													
													<cfif thisTopic_Use_Pending EQ 1>
														<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM Suggestion
														WHERE CategoryID=#this_categoryID#
														AND Authorise LIKE '%No%'
														AND Archived = 0
														AND SugStage LIKE '%Pending%'
														GROUP BY SugID
														</cfquery>
													</cfif>
													
													<cfif thisTopic_Use_Stage4 EQ 1>
														<cfquery name="AllCat_WinnerIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM Suggestion
														WHERE CategoryID=#this_categoryID#
														AND suggestion.DisplayAsWinner=1
														AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%' OR suggestion.SugStage LIKE '%Stage 6%' OR suggestion.SugStage LIKE '%Stage 7%' OR suggestion.SugStage LIKE '%Stage 8%' OR suggestion.SugStage LIKE '%Stage 9%')
														GROUP BY SugID
														</cfquery>
													</cfif>
															
													<cfquery name="AllCat_ReturnedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT SugID
													FROM Suggestion
													WHERE CategoryID=#this_categoryID#
													AND Archived=1
													GROUP BY SugID
													</cfquery>		
													
													<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT Organisation_Name, LogoFile
													FROM Organisations
													WHERE OrganisationID=#this_SponsorID#
													</cfquery>
														
													<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.RecordCount>
														<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
													<cfelse>
														<cfset ThisCatideas = "0">		
													</cfif>
													
													<cfif IsDefined("AllCat_InActiveIdeas") AND AllCat_InActiveIdeas.RecordCount>
														<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
													</cfif>
													
													<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.Recordcount>
														<cfset ActiveList = ValueList(AllCat_ActiveIdeas.SugID, ",")>
													<cfelse>
														<cfset ActiveList = 0>
													</cfif>		
													
													<cfif session.UserIsAuthenticated EQ 'yes'>
													
														<!--- HOW MANY IDEAS HAS THIS USER VOTED ON --->
														<cfquery name="IdeasAlreadyVotedFor" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM SugVote
														WHERE ContactID=#session.UserID#
														AND SugID IN (#ActiveList#)
														GROUP BY SugID
														</cfquery>
													
													</cfif>
													
													<cfif #TRIM(qry_all_categories.Name)# neq ''> 
													
														 <cfif start eq 1>
															  <tr>
														 </cfif> 
																 <td valign="top">   
																	<div class="fl badge rounded shadow -ce-capture "> 
																		<div class="image clearfix" style="height: 184px; text-align: center; width: 184px;">
																			 <cfif FileExists("#request.fileroot#\images\carcasses_new\#TRIM(qry_all_categories.ideaspic)#")>
																				 <a href="#request.webroot#/index.cfm?fuseaction=ideas&amp;fusesubaction=docs&amp;documentID=75&amp;currentcategory=#qry_all_categories.CategoryID#&amp;IdeaFunL_StartRow=1&amp;srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;">		
																					<img src="#request.imageroot#/carcasses_new/#TRIM(qry_all_categories.ideaspic)#" border="0" title="#TRIM(SponsorStuff.Organisation_Name)#" width="220" height="180">
																				  </a>	
																			 <cfelse>
																					 <a href="#request.webroot#/index.cfm?fuseaction=ideas&amp;fusesubaction=docs&amp;documentID=75&amp;currentcategory=#qry_all_categories.CategoryID#&amp;IdeaFunL_StartRow=1&amp;srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;">
																						<img width="220" height="180" src="#request.imageroot#/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-_06.10">		 
																					 </a> 		
																			 </cfif>
																		 </div>
																		
																		<div class="project-category"> 
																			  #TRIM(qry_all_maincats.MainCatTitle)#
																		</div>
																		
																		<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;">    
																			 <a href="#request.webroot#/index.cfm?fuseaction=ideas&amp;fusesubaction=docs&amp;documentID=75&amp;currentcategory=#qry_all_categories.CategoryID#&amp;IdeaFunL_StartRow=1&amp;srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_all_categories.Name)#</strong></a><br /><br />
																			 <p class="description">
																				 <cfset DescriptionD = ReReplaceNoCase(TRIM(qry_all_categories.Description),"<[^>]*>","","ALL") /> 
																				 #Mid(TRIM(DescriptionD),1, 100)#... 
																			 </p>
																			 <div style=" margin-left: 20px; margin-top: 6px;">
																			  <img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0">
																			  <br> 					  
																			  <cfif thisTopic_Use_Pending EQ 1>
																				  <cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")>
																				  <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_InActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowPending=1" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><strong>#AllCat_InActiveIdeas.RecordCount#</strong> #pendingideastext#<cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")></a></cfif><br></cfif>
																				  <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#AllCat_ActiveIdeas.RecordCount#</strong> #activeideastext#</a><br>
																				  <cfif session.UserIsAuthenticated EQ 'Yes'>
																					  <span style="color:###TRIM(AllSettings.BoxColour)#;">
																					   <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=Yes"><strong>#INT(AllCat_ToVoteIdeas.RecordCount - IdeasAlreadyVotedFor.RecordCount)#</strong> #needmyvotetext#</a><br></span></cfif>				
																																				<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ReturnedIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowReturned=1"><strong>#AllCat_ReturnedIdeas.RecordCount#</strong> #retideastext#</a><br>
																				  <cfif thisTopic_Use_Stage4 EQ 1><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=78&srch_category=#this_categoryID#&WinIdeas_StartRow=1&returnIdeas=#ValueList(AllCat_WinnerIdeas.SugID)#"><strong>#AllCat_WinnerIdeas.RecordCount#</strong> #winnerideatext#</a><br></cfif>        
																					<cfset thisTotalIdeas = AllCat_ActiveIdeas.RecordCount>        
																					   <cfif thisTopic_Use_Pending EQ 1>
																							 <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_InActiveIdeas.RecordCount)>
																					   </cfif>
																					   <cfif thisTopic_Use_Stage4 EQ 1>
																							 <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_WinnerIdeas.RecordCount)>
																					   </cfif>        
																					   <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_ReturnedIdeas.RecordCount)>
																							 <strong>
																							  <span style="color:##444444;">#totaltxt#: #INT(thisTotalIdeas)# #ideastab#</span>
																							 </strong><br>
																			  </div>																	   
																		</div>  
																		<div style="border-top: 1px solid ##808080; margin-top: 85px; height: 67px; padding: 10px;">
																			  <cfset PointsAllocated = qry_all_categories.PointsAllocated> 
																			  <cfset PointsUsed      = qry_all_categories.PointsUsed> 
																			  <cfif PointsUsed eq 0>
																					<cfset this_percentDone = 0>
																			  <cfelse>
																					<cfset finalVal = ((PointsUsed * 100) / PointsAllocated)> 
																					<cfset this_percentDone = DecimalFormat(finalVal)>
																			  </cfif> 
																			  <cfif this_percentDone neq '' and this_percentDone gt 0>
																				  <span style="margin-left: 10px;">Points Used Progress:</span> <br />  
																				  <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
																					 <iframe src="#request.webroot#/ideas/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
																			  <cfelse>
																				  <span style="color: blue; margin-left: 10px; margin-right: 10px;">
																				  <br /><br />
																					  #ideascheck1#
																				  </span> 		  
																			  </cfif>		 
																		</div> 
																	</div>	  
																 </td>
														 <cfif start MOD 3 eq 0>
															  </tr>
															  <tr>
														 </cfif> 
														 <cfset start = start + 1> 
													</cfif>
													
													</cfloop>		
											<cfelse>
												 <cfset ctr = ctr + 1>
												 <cfquery name="qry_all_categories" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT * FROM SugCategory as sugc
														INNER JOIN Suggestion as sugg
														ON sugc.CategoryID = sugg.CategoryID
													WHERE sugc.Active = 1 and sugc.related_campaign = #campaignID#
													AND sugc.MainCatID=#this_MainCatID#
													<cfif isdefined("FORM.search_keyword")>
														<cfif FORM.search_keyword neq ''>  
															   and (sugg.suggestion LIKE '%#trim(FORM.search_keyword)#%' or 
																	sugg.details LIKE '%#trim(FORM.search_keyword)#%') 
														</cfif> 
													</cfif>
													ORDER BY sugc.CategoryID DESC
												</cfquery>  		
													  <cfloop query="qry_all_categories">
													
													<cfset this_categoryID = qry_all_categories.categoryID>
													<cfset this_SponsorID = qry_all_categories.SponsorID>
													<cfset this_PointsAllocated = qry_all_categories.PointsAllocated>
													<cfset this_WhenCategoryEnded = qry_all_categories.WhenCategoryEnded>
													<cfset this_PointsCutOff = qry_all_categories.PointsCutOff>
													
													<cfinclude template="act_topic_stages.cfm">
													
													<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT suggestion.sugID
													FROM suggestion, Contacts
													WHERE suggestion.ContactID=Contacts.ContactID
													AND suggestion.Authorise = 'yes'
													AND suggestion.Archived=0
													AND suggestion.categoryID=#this_categoryID#
													AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
													</cfquery>
													
													<cfquery name="AllCat_ToVoteIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT suggestion.sugID
													FROM suggestion, Contacts
													WHERE suggestion.ContactID=Contacts.ContactID
													<cfif IsDefined("session.UserID")>
													AND Contacts.ContactID <> #session.UserID#
													</cfif>
													AND suggestion.Authorise = 'yes'
													AND suggestion.Archived=0
													AND suggestion.categoryID=#this_categoryID#
													AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
													</cfquery>
													
													<cfif thisTopic_Use_Pending EQ 1>
														<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM Suggestion
														WHERE CategoryID=#this_categoryID#
														AND Authorise LIKE '%No%'
														AND Archived = 0
														AND SugStage LIKE '%Pending%'
														GROUP BY SugID
														</cfquery>
													</cfif>
													
													<cfif thisTopic_Use_Stage4 EQ 1>
														<cfquery name="AllCat_WinnerIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM Suggestion
														WHERE CategoryID=#this_categoryID#
														AND suggestion.DisplayAsWinner=1
														AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%' OR suggestion.SugStage LIKE '%Stage 6%' OR suggestion.SugStage LIKE '%Stage 7%' OR suggestion.SugStage LIKE '%Stage 8%' OR suggestion.SugStage LIKE '%Stage 9%')
														GROUP BY SugID
														</cfquery>
													</cfif>
															
													<cfquery name="AllCat_ReturnedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT SugID
													FROM Suggestion
													WHERE CategoryID=#this_categoryID#
													AND Archived=1
													GROUP BY SugID
													</cfquery>		
													
													<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
													SELECT Organisation_Name, LogoFile
													FROM Organisations
													WHERE OrganisationID=#this_SponsorID#
													</cfquery>
														
													<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.RecordCount>
														<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
													<cfelse>
														<cfset ThisCatideas = "0">		
													</cfif>
													
													<cfif IsDefined("AllCat_InActiveIdeas") AND AllCat_InActiveIdeas.RecordCount>
														<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
													</cfif>
													
													<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.Recordcount>
														<cfset ActiveList = ValueList(AllCat_ActiveIdeas.SugID, ",")>
													<cfelse>
														<cfset ActiveList = 0>
													</cfif>		
													
													<cfif session.UserIsAuthenticated EQ 'yes'>
													
														<!--- HOW MANY IDEAS HAS THIS USER VOTED ON --->
														<cfquery name="IdeasAlreadyVotedFor" datasource="#dsn#" username="#request.username#" password="#request.password#">
														SELECT SugID
														FROM SugVote
														WHERE ContactID=#session.UserID#
														AND SugID IN (#ActiveList#)
														GROUP BY SugID
														</cfquery>
													
													</cfif>
													
													<cfif #TRIM(qry_all_categories.Name)# neq ''> 
													
														 <cfif start eq 1>
															  <tr>
														 </cfif> 
																 <td valign="top">   
																	<div class="fl badge rounded shadow -ce-capture "> 
																		<div class="image clearfix" style="height: 184px; text-align: center; width: 184px;">
																			 <cfif FileExists("#request.fileroot#\images\carcasses_new\#TRIM(qry_all_categories.ideaspic)#")>
																				 <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&currentcategory=#qry_all_categories.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;">		
																					<img src="#request.imageroot#/carcasses_new/#TRIM(qry_all_categories.ideaspic)#" border="0" title="#TRIM(SponsorStuff.Organisation_Name)#" width="220" height="180">
																				  </a>	
																			 <cfelse>
																					 <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&currentcategory=#qry_all_categories.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;">
																						<img width="220" height="180" src="#request.imageroot#/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-_06.10">		 
																					 </a> 		
																			 </cfif>
																		 </div>
																		
																		<div class="project-category"> 
																			  #TRIM(qry_all_maincats.MainCatTitle)#
																		</div>
																		
																		<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;">   
																			 <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&currentcategory=#qry_all_categories.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_all_categories.Name)#</strong></a><br /><br />
																			 <p class="description">
																				 <cfset DescriptionD = ReReplaceNoCase(TRIM(qry_all_categories.Description),"<[^>]*>","","ALL") /> 
																				 #Mid(TRIM(DescriptionD),1, 100)#... 
																			 </p>
																			 <div style=" margin-left: 20px; margin-top: 6px;">
																			  <img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0">
																			  <br> 					  
																			  <cfif thisTopic_Use_Pending EQ 1>
																				  <cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")>
																				  <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_InActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowPending=1" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><strong>#AllCat_InActiveIdeas.RecordCount#</strong> pending ideas<cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")></a></cfif><br></cfif>
																				  <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#AllCat_ActiveIdeas.RecordCount#</strong> active ideas</a><br>
																				  <cfif session.UserIsAuthenticated EQ 'Yes'>
																					  <span style="color:###TRIM(AllSettings.BoxColour)#;">
																					   <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=Yes"><strong>#INT(AllCat_ToVoteIdeas.RecordCount - IdeasAlreadyVotedFor.RecordCount)#</strong> need my vote</a><br></span></cfif>				
																																				<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ReturnedIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowReturned=1"><strong>#AllCat_ReturnedIdeas.RecordCount#</strong> returned ideas</a><br>
																				  <cfif thisTopic_Use_Stage4 EQ 1><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=78&srch_category=#this_categoryID#&WinIdeas_StartRow=1&returnIdeas=#ValueList(AllCat_WinnerIdeas.SugID)#"><strong>#AllCat_WinnerIdeas.RecordCount#</strong> winner ideas</a><br></cfif>        
																					<cfset thisTotalIdeas = AllCat_ActiveIdeas.RecordCount>        
																					   <cfif thisTopic_Use_Pending EQ 1>
																							 <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_InActiveIdeas.RecordCount)>
																					   </cfif>
																					   <cfif thisTopic_Use_Stage4 EQ 1>
																							 <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_WinnerIdeas.RecordCount)>
																					   </cfif>        
																					   <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_ReturnedIdeas.RecordCount)>
																							 <strong>
																							  <span style="color:##444444;">Total: #INT(thisTotalIdeas)# ideas</span>
																							 </strong><br>
																			  </div>																	   
																		</div>  
																		<div style="border-top: 1px solid ##808080; margin-top: 85px; height: 67px; padding: 10px;">
																			  <cfset PointsAllocated = qry_all_categories.PointsAllocated> 
																			  <cfset PointsUsed      = qry_all_categories.PointsUsed> 
																			  <cfif PointsUsed eq 0>
																					<cfset this_percentDone = 0>
																			  <cfelse>
																					<cfset finalVal = ((PointsUsed * 100) / PointsAllocated)> 
																					<cfset this_percentDone = DecimalFormat(finalVal)>
																			  </cfif> 
																			  <cfif this_percentDone neq '' and this_percentDone gt 0>
																				  <span style="margin-left: 10px;">Points Used Progress:</span> <br />  
																				  <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
																					 <iframe src="#request.webroot#/ideas/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
																			  <cfelse>
																				  <span style="color: blue; margin-left: 10px; margin-right: 10px;">
																				  <br /><br />
																					 #ideascheck1#
																				  </span> 		  
																			  </cfif>		 
																		</div> 
																	</div>	  
																 </td>
														 <cfif start MOD 3 eq 0>
															  </tr>
															  <tr>
														 </cfif> 
														 <cfset start = start + 1> 
													</cfif>
													
													</cfloop>	 
											</cfif>  
								</cfloop>
						   </table>	 
						  <cfif ctr lte 0> 
								<table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr>
										 <td>  
											  <img src="/images/DataNotFound.jpg" border="0" />
										 </td>
									</tr>
								</table>
						  </cfif> 	
	<cfif totalideas gt 5>
			<a href="#request.webroot#/index.cfm?fuseaction=ideas">
				 Read More ideas...
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