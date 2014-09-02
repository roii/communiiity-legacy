<cfparam name="selStatus" default="">
<cfparam name="selPriority" default="">
<cfparam name="sortBy" default="">
<cfparam name="sortDir" default="desc">
<cfset amarCounter = 1>
<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

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
	    if(confirm('Are you sure you want to delete this Project?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	</script>

</cfif>
 

 

<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#>

<cfif IsDefined("FORM.selStatus") and FORM.selStatus neq ''>
     <cfset selStatus   = #FORM.selStatus#>
	 <cfset selStatusAr = ListToArray(selStatus,",")> 
<cfelse>
     <cfset selStatus = ''>	 
</cfif> 

<cfif IsDefined("FORM.selCategory") and FORM.selCategory neq ''>
     <cfset selCategory = #FORM.selCategory#>
<cfelse>
     <cfset selCategory = ''>	 
</cfif>

<cfif IsDefined("FORM.selPriority") and FORM.selPriority neq ''>
     <cfset selPriority   = #FORM.selPriority#> 
	 <cfset selPriorityAr = ListToArray(selPriority,",")> 
<cfelse>
     <cfset selPriority = ''>	 
</cfif>

<cfif session.UserType EQ 'Administrator'>
    <cfset allowTasks = 1>
<cfelse>
    <cfset allowTasks = 0> 
</cfif> 
 
<!---Start of new code added to display jqgrid box   Added by Veena --->
<cfset sortCol = "CampaignsID">
<cfif sortBy eq "category">
	<cfset sortCol = "ProjectCategory">
<cfelseif sortBy eq "Priority">
	<cfset sortCol = "Priority">
<cfelseif sortBy eq "Status">
	<cfset sortCol = "CurrentStatus">
<cfelseif sortBy eq "Paid In">
	<cfset sortCol = "PaidIn">
</cfif>    

 <cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
<!---PC.Title ProjectCategory,--->
SELECT P.CampaignsID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority, P.CreditsOffered, P.campaignspic, P.details, P.addedby, P.location, P.campaigns_order, P.displaycampaigns, P.PercentComplete, P.MainProjectCategoryID, P.Moderators
FROM campaigns P <!---INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID--->
<!---P.ProjectCategoryID in (#ProjectCatIDList#)--->
<cfif isdefined("FORM.selStatus")>
<cfif FORM.selStatus neq ''> 
<cfif FORM.selStatus neq 'showallstatus'>  
  WHERE P.currentstatus IN ('#Replace(trim(FORM.selStatus), ",", "','", "ALL")#')
</cfif>	   
</cfif> 
</cfif>
<!---<cfif isDefined("FORM.selCategory")>
<cfif FORM.selCategory neq ''>
<cfif FORM.selCategory neq 'showallcats'> 
  and P.ProjectCategoryID IN (#trim(FORM.selCategory)#)
</cfif>	  
</cfif> 
</cfif>--->
<cfif isDefined("FORM.selPriority")>
<cfif FORM.selPriority neq ''>
<cfif FORM.selPriority neq 'showallpriorities'>  
  WHERE P.Priority IN ('#Replace(trim(FORM.selPriority), ",", "','", "ALL")#')
</cfif>	  
</cfif> 
</cfif>
<cfif isdefined("FORM.search_keyword")>
<cfif FORM.search_keyword neq ''>  
  WHERE (P.Title LIKE '%#trim(FORM.search_keyword)#%' or P.INTROTEXT LIKE '%#trim(FORM.search_keyword)#%' or P.details LIKE '%#trim(FORM.search_keyword)#%') 
</cfif> 
</cfif>
Order by P.campaigns_order ASC
</cfquery>
  

<div class="fullwidth">
  <div class="leftwidth">
       <script language="javascript">
	       function checkform()
		   {
		        var categoryallselectedVal = document.getElementById('categoryallselected').checked;
				if(categoryallselectedVal == true)
				{
				    document.getElementById('selCategory').value = "";
					var temp = "";
					var test = 0;
					arrChecks = document.filterform.categoryselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
						  else
						  {
						       test = test + 1;
						  }
					 } 
					  if(test > 0)
					  {
					      document.getElementById('selCategory').value = temp;
					  }
					  else
					  {
					      document.getElementById('selCategory').value = document.getElementById('categoryallselected').value
					  } 
				}
				else
				{ 
				    document.getElementById('selCategory').value = "";
					var temp = "";
					arrChecks = document.filterform.categoryselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
					 }
					document.getElementById('selCategory').value = temp; 
			    } 
				//alert(document.getElementById('selCategory').value);
				
				
				var categoryallselectedVal = document.getElementById('statuallselected').checked;
				if(categoryallselectedVal == true)
				{
				    document.getElementById('selStatus').value = "";
					var temp = "";
					var test = 0;
					arrChecks = document.filterform.statuselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
						  else
						  {
						       test = test + 1;
						  }
					 } 
					  if(test > 0)
					  {
					      document.getElementById('selStatus').value = temp;
					  }
					  else
					  {
					      document.getElementById('selStatus').value = document.getElementById('statuallselected').value
					  } 
				}
				else
				{ 
				    document.getElementById('selStatus').value = "";
					var temp = "";
					arrChecks = document.filterform.statuselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
					 }
					document.getElementById('selStatus').value = temp; 
			    } 
				
				
				
				var priorityallselectedVal = document.getElementById('priorityallselected').checked;
				if(priorityallselectedVal == true)
				{
				    document.getElementById('selPriority').value = "";
					var temp = "";
					var test = 0;
					arrChecks = document.filterform.priorityselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
						  else
						  {
						       test = test + 1;
						  }
					 } 
					  if(test > 0)
					  {
					      document.getElementById('selPriority').value = temp;
					  }
					  else
					  {
					      document.getElementById('selPriority').value = document.getElementById('priorityallselected').value
					  } 
				}
				else
				{ 
				    document.getElementById('selPriority').value = "";
					var temp = "";
					arrChecks = document.filterform.priorityselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
					 }
					document.getElementById('selPriority').value = temp; 
			    } 
				
				
				/* var res1 = document.getElementById('selCategory').value.split(",");
				 var totalCatLenSelected1 = res1.length;
				 arrChecks = document.filterform.categoryselected;
				 var totalcategorieschkboxes1 = arrChecks.length;	
				 if(totalCatLenSelected1 == totalcategorieschkboxes1)
				 {
					 document.getElementById('categoryallselected').checked = true;
				 }
				 else
				 {
					 document.getElementById('categoryallselected').checked = false;
				 }
				 
				 
				 var res2 = document.getElementById('selStatus').value.split(",");
				 var totalCatLenSelected2 = res2.length;
				 arrChecks = document.filterform.statuselected;
				 var totalcategorieschkboxes2 = arrChecks.length;	
				 if(totalCatLenSelected2 == totalcategorieschkboxes2)
				 {
					 document.getElementById('statuallselected').checked = true;
				 }
				 else
				 {
					 document.getElementById('statuallselected').checked = false;
				 }
				 
				 
				 var res3 = document.getElementById('selPriority').value.split(",");
				 var totalCatLenSelected3 = res3.length;
				 arrChecks = document.filterform.priorityselected;
				 var totalcategorieschkboxes3 = arrChecks.length;	
				 if(totalCatLenSelected3 == totalcategorieschkboxes3)
				 {
					 document.getElementById('priorityallselected').checked = true;
				 }
				 else
				 {
					 document.getElementById('priorityallselected').checked = false;
				 }*/
				
			  return true;
		   }
		   
		   function setvalues(cateallObj)
		   {
		         if(cateallObj.checked == true)
				 {
				        arrChecks = document.filterform.categoryselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = true;
						 } 
				 }
				 else
				 {
				        arrChecks = document.filterform.categoryselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = false;
						 }
				 }
		   }
		   
		   function setstatvalues(statSelObj)
		   {
		         if(statSelObj.checked == true)
				 {
				        arrChecks = document.filterform.statuselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = true;
						 } 
				 }
				 else
				 {
				        arrChecks = document.filterform.statuselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = false;
						 }
				 }
		   }
		   
		   function setpriorityvalues(statPriorityObj)
		   {
		         if(statPriorityObj.checked == true)
				 {
				        arrChecks = document.filterform.priorityselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = true;
						 } 
				 }
				 else
				 {
				        arrChecks = document.filterform.priorityselected;
						for (i=0; i<arrChecks.length; i++)
						 {
							  arrChecks[i].checked = false;
						 }
				 }
		   }
		   
	   </script>
        <cfoutput>
		<!--- AND session.UserType EQ 'Administrator'
		 ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"--->
		<cfif session.UserIsAuthenticated EQ 'Yes'>
		     <a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=addProject&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#AddCampaigns# &raquo;</strong></a>  <br /><br />
	  	</cfif> 
		
	    <form name="filterform" action="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;" name="go"> &nbsp;
	        <input type="button" value="Reset Search &gt;&gt;" class="buttonControl" style="cursor: pointer;" onclick="javascript: window.location = '#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#';" name="go">
			<br />
			<br />
			<div>
			      <span><cfoutput>#searchkeyword#</cfoutput>:</span>
				  <span> 
				        <input type="text" maxlength="50" size="30" name="search_keyword" id="search_keyword" value="<cfif IsDefined("FORM.search_keyword") and FORM.search_keyword neq ''><cfoutput>#FORM.search_keyword#</cfoutput></cfif>">
				  </span>
			</div>
			<br />
			<cfquery name="amarCatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT ProjectCategoryID, Title AS CategoryTitle
			FROM ProjectCategories
			<!---WHERE GroupID=#GroupID#--->
			<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
			<cfelse>
				WHERE Active = 1
			</cfif>
			ORDER BY Active DESC, displayorder
			</cfquery> 
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#category#</cfoutput>
			</span><br />
			<span> 
			    <cfoutput>
			       <a href="javascript: void(0);" onclick="showhideBoxesAgain('categoryBoxID', 'catimgID');" style="font-weight: bold; text-decoration:none; color: ##91AE4E;"> 
				      <img id="catimgID" src="#request.webroot#/images/toogle-panel-expand.gif" border="0" /> 
				   </a>
			       <cfif isDefined("FORM.selCategory") and #FORM.selCategory# eq 'showallcats'>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="showallcats" checked="checked" onclick="setvalues(this);" /> &nbsp;#showall#
				   <cfelse>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="showallcats" onclick="setvalues(this);" /> &nbsp;#showall#
				   </cfif> 
			   </cfoutput><br />
			    <div style="margin-left: 40px;" id="categoryBoxID">
					<cfloop query="amarCatDetails">
					      <cfquery name="getProjectCatData" datasource="#dsn#" username="#request.username#" password="#request.password#">
                                <!---SELECT count(*) as total FROM campaigns WHERE ProjectCategoryID = #amarCatDetails.ProjectCategoryID#---> 
								SELECT count(*) as total FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID 
								WHERE PCR.ProjectCategoryID = #amarCatDetails.ProjectCategoryID#
                          </cfquery>
						<cfoutput> 
							     <cfif IsDefined("FORM.CATEGORYSELECTED") >   
									   <cfset CatArray = ListToArray(FORM.CATEGORYSELECTED, ",")> 
									          <!---<cfset temp = ListFind(FORM.CATEGORYSELECTED, #amarCatDetails.ProjectCategoryID#)>  --->
										<cfif #ArrayContains(CatArray, TRIM(amarCatDetails.ProjectCategoryID))# eq "Yes">  
											 <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" checked="checked" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 
										<cfelse> 
											 <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp;
										</cfif> 
								<cfelse>
								    <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 	
								</cfif>	
							 #amarCatDetails.CategoryTitle#&nbsp;(#getProjectCatData.total#)<br />
						</cfoutput>
					</cfloop> 
				</div>	
			</span> 
			<br />
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#status#</cfoutput>
			</span><br />
				<cfoutput> 
				   <a href="javascript: void(0);" onclick="showhideBoxesAgain('statusBoxID', 'statimgID');" style="font-weight: bold; text-decoration:none; color: ##91AE4E;"> 
						  <img id="statimgID" src="#request.webroot#/images/toogle-panel-expand.gif" border="0" /> 
				   </a>
				   <cfif isDefined("FORM.selStatus") and #FORM.selStatus# eq 'showallstatus'>
						<input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" checked="checked" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
				   <cfelse>
						<input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
				   </cfif>	
					<div style="margin-left: 40px;" id="statusBoxID">
						<cfif IsDefined("FORM.STATUSELECTED") >
							 <cfset temp = ListFind(FORM.STATUSELECTED, 'Draft')> 
								<cfif temp is 0>  
									<input type="checkbox" name="statuselected" id="stat_1" value="Draft" /> &nbsp;
									   #Draft#<br />
								<cfelse> 
									<input type="checkbox" name="statuselected" id="stat_1" checked="checked" value="Draft" /> &nbsp;
									   #Draft#<br /> 
								</cfif>
								
							 <cfset temp = ListFind(FORM.STATUSELECTED, 'Active')> 
								<cfif temp is 0>  
									<input type="checkbox" name="statuselected" id="stat_2" value="Active" /> &nbsp;
									   #active#<br />
								<cfelse> 
									<input type="checkbox" name="statuselected" id="stat_2" checked="checked" value="Active" /> &nbsp;
									   #active#<br />
								</cfif>
								
							 <cfset temp = ListFind(FORM.STATUSELECTED, 'Complete')> 
								<cfif temp is 0>  
									<input type="checkbox" name="statuselected" id="stat_3" value="Complete" /> &nbsp;
									   #complete#<br />
								<cfelse> 
									<input type="checkbox" name="statuselected" checked="checked" id="stat_3" value="Complete" /> &nbsp;
									   #complete#<br />
								</cfif>	 			 
						<cfelse>
							<input type="checkbox" name="statuselected" id="stat_1" value="Draft" /> &nbsp;
								#Draft#<br />
							<input type="checkbox" name="statuselected" id="stat_2" value="Active" /> &nbsp;
								#active#<br />
							<input type="checkbox" name="statuselected" id="stat_3" value="Complete" /> &nbsp;
								#complete# 
						</cfif>	 
					</div>	 
				</cfoutput> 
			    <br /><br />
			    <input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;" name="go">
		 </form>	
        </cfoutput>
  </div>
  <div class="rightwidth">
     <cfif ProjectDetails.recordcount gt 0>  
			<cfset start = 1> 
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<cfoutput query="ProjectDetails">    
				     <cfset Moderators = ProjectDetails.Moderators>
					 <cfset ModArray   = ListToArray(Moderators, ",")>
					 <cfset displaycampaigns = ProjectDetails.displaycampaigns>
				     <cfif (IsDefined("SESSION.usertype") and SESSION.usertype eq "Administrator")>
								 <cfquery name="getSearchProjectCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
									 SELECT PC.TITLE as ProjectCategory, PC.GroupID, PC.displayOrder, PC.active FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID INNER JOIN ProjectCategories as PC ON PCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.CampaignsID = #ProjectDetails.CampaignsID#
										<cfif isDefined("FORM.selCategory")>
											<cfif FORM.selCategory neq ''>
											   <cfif FORM.selCategory neq 'showallcats'> 
												  and PCR.ProjectCategoryID IN (#trim(FORM.selCategory)#)
											   </cfif>	  
											</cfif> 
										</cfif>
							  </cfquery> 
							     <cfif getSearchProjectCats.recordcount gt 0>  
									<cfset projectCat = ""> 
									
									<cfif getSearchProjectCats.recordcount lte 1>
										  <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
									<cfelse>
										  <cfset ictr = 1> 
										  <cfloop query="getSearchProjectCats">
											  <cfif ictr lte 1>
												 <cfif projectCat eq "">
													   <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
												 <cfelse>
													   <cfset projectCat &= ", " & #getSearchProjectCats.ProjectCategory#>
												 </cfif> 
											  </cfif>
											  <cfset ictr = ictr + 1>	 
										  </cfloop>
										  <cfset projectCat &= "<u><strong> and many more</strong></u>"> 
									</cfif> 
									 
									<cfif start eq 1>
										  <tr>
									</cfif> 
											 <td valign="top">   
												<div class="fl badge rounded shadow -ce-capture "> 
													<div class="image clearfix">
													  <cfset urlProjTitle = Replace(#TRIM(ProjectDetails.Title)#, " ", "-", "ALL")> 
													  <!---<cfset urlProjTitle = ToBase64( #TRIM(ProjectDetails.Title)# ) />--->
													  
													  <a href="#request.webroot#/projects/#ProjectDetails.CampaignsID#">
														 <cfif ProjectDetails.campaignspic neq ''>
															<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.campaignspic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
														 <cfelse>
															<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
														 </cfif>
													</a></div>
													
													<div class="project-category"> 
														<cfquery name="getSearchProjectCatsName" datasource="#dsn#" username="#request.username#" password="#request.password#">
															  SELECT Title FROM ProjectCategories
															   WHERE ProjectCategoryID = #ProjectDetails.MainProjectCategoryID#
														</cfquery>
														   #getSearchProjectCatsName.Title# 
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
																 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/campaigns/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
																 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
																 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe> 
																 <!---<div style="width: 206px !important; overflow: hidden;"> 
																	 <cfinclude template="dsp_percent_bar.cfm"> 
																 </div>--->
															 </cfif> <br />
															 <!---<a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a>--->
														 </div>
														  
												</div>	  
											 </td>
									<cfif start MOD 3 eq 0>
										  </tr>
										  <tr>
									</cfif> 
									<cfset start = start + 1>
							</cfif>  
					 <cfelseif (IsDefined("SESSION.usertype") and SESSION.usertype neq "Administrator")>
					             <cfif IsDefined("SESSION.userid") and #ArrayContains(ModArray, "#SESSION.userid#")#> 
										   <cfquery name="getSearchProjectCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
										 SELECT PC.TITLE as ProjectCategory, PC.GroupID, PC.displayOrder, PC.active FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID INNER JOIN ProjectCategories as PC ON PCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.CampaignsID = #ProjectDetails.CampaignsID#
											<cfif isDefined("FORM.selCategory")>
												<cfif FORM.selCategory neq ''>
												   <cfif FORM.selCategory neq 'showallcats'> 
													  and PCR.ProjectCategoryID IN (#trim(FORM.selCategory)#)
												   </cfif>	  
												</cfif> 
											</cfif>
								  </cfquery> 
										   <cfif getSearchProjectCats.recordcount gt 0>  
											<cfset projectCat = ""> 
											
											<cfif getSearchProjectCats.recordcount lte 1>
												  <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
											<cfelse>
												  <cfset ictr = 1> 
												  <cfloop query="getSearchProjectCats">
													  <cfif ictr lte 1>
														 <cfif projectCat eq "">
															   <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
														 <cfelse>
															   <cfset projectCat &= ", " & #getSearchProjectCats.ProjectCategory#>
														 </cfif> 
													  </cfif>
													  <cfset ictr = ictr + 1>	 
												  </cfloop>
												  <cfset projectCat &= "<u><strong> and many more</strong></u>"> 
											</cfif> 
											 
											<cfif start eq 1>
												  <tr>
											</cfif> 
													 <td valign="top">   
														<div class="fl badge rounded shadow -ce-capture "> 
															<div class="image clearfix">
															  <cfset urlProjTitle = Replace(#TRIM(ProjectDetails.Title)#, " ", "-", "ALL")> 
															  <!---<cfset urlProjTitle = ToBase64( #TRIM(ProjectDetails.Title)# ) />--->
															  
															  <a href="#request.webroot#/projects/#ProjectDetails.CampaignsID#">
																 <cfif ProjectDetails.campaignspic neq ''>
																	<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.campaignspic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
																 <cfelse>
																	<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
																 </cfif>
															</a></div>
															
															<div class="project-category"> 
																<cfquery name="getSearchProjectCatsName" datasource="#dsn#" username="#request.username#" password="#request.password#">
																	  SELECT Title FROM ProjectCategories
																	   WHERE ProjectCategoryID = #ProjectDetails.MainProjectCategoryID#
																</cfquery>
																   #getSearchProjectCatsName.Title# 
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
																		 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/campaigns/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
																		 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
																		 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe> 
																		 <!---<div style="width: 206px !important; overflow: hidden;"> 
																			 <cfinclude template="dsp_percent_bar.cfm"> 
																		 </div>--->
																	 </cfif> <br />
																	 <!---<a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a>--->
																 </div>
																  
														</div>	  
													 </td>
											<cfif start MOD 3 eq 0>
												  </tr>
												  <tr>
											</cfif> 
											<cfset start = start + 1>
									</cfif>  
								 <cfelse>
								          <cfif displaycampaigns eq 1>
										         <cfquery name="getSearchProjectCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
										 SELECT PC.TITLE as ProjectCategory, PC.GroupID, PC.displayOrder, PC.active FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID INNER JOIN ProjectCategories as PC ON PCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.CampaignsID = #ProjectDetails.CampaignsID#
											<cfif isDefined("FORM.selCategory")>
												<cfif FORM.selCategory neq ''>
												   <cfif FORM.selCategory neq 'showallcats'> 
													  and PCR.ProjectCategoryID IN (#trim(FORM.selCategory)#)
												   </cfif>	  
												</cfif> 
											</cfif>
								  </cfquery> 
										  		 <cfif getSearchProjectCats.recordcount gt 0>  
											<cfset projectCat = ""> 
											
											<cfif getSearchProjectCats.recordcount lte 1>
												  <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
											<cfelse>
												  <cfset ictr = 1> 
												  <cfloop query="getSearchProjectCats">
													  <cfif ictr lte 1>
														 <cfif projectCat eq "">
															   <cfset projectCat &= #getSearchProjectCats.ProjectCategory#>
														 <cfelse>
															   <cfset projectCat &= ", " & #getSearchProjectCats.ProjectCategory#>
														 </cfif> 
													  </cfif>
													  <cfset ictr = ictr + 1>	 
												  </cfloop>
												  <cfset projectCat &= "<u><strong> and many more</strong></u>"> 
											</cfif> 
											 
											<cfif start eq 1>
												  <tr>
											</cfif> 
													 <td valign="top">   
														<div class="fl badge rounded shadow -ce-capture "> 
															<div class="image clearfix">
															  <cfset urlProjTitle = Replace(#TRIM(ProjectDetails.Title)#, " ", "-", "ALL")> 
															  <!---<cfset urlProjTitle = ToBase64( #TRIM(ProjectDetails.Title)# ) />--->
															  
															  <a href="#request.webroot#/projects/#ProjectDetails.CampaignsID#">
																 <cfif ProjectDetails.campaignspic neq ''>
																	<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.campaignspic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
																 <cfelse>
																	<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
																 </cfif>
															</a></div>
															
															<div class="project-category"> 
																<cfquery name="getSearchProjectCatsName" datasource="#dsn#" username="#request.username#" password="#request.password#">
																	  SELECT Title FROM ProjectCategories
																	   WHERE ProjectCategoryID = #ProjectDetails.MainProjectCategoryID#
																</cfquery>
																   #getSearchProjectCatsName.Title# 
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
																		 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/campaigns/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
																		 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
																		 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe> 
																		 <!---<div style="width: 206px !important; overflow: hidden;"> 
																			 <cfinclude template="dsp_percent_bar.cfm"> 
																		 </div>--->
																	 </cfif> <br />
																	 <!---<a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#ProjectDetails.CampaignsID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a>--->
																 </div>
																  
														</div>	  
													 </td>
											<cfif start MOD 3 eq 0>
												  </tr>
												  <tr>
											</cfif> 
											<cfset start = start + 1>
									</cfif>
										  </cfif> 	
								 </cfif>
					 </cfif>  
				</cfoutput>
			</table> 
	 <cfelse>
	        <table cellpadding="0" cellspacing="0" border="0" width="100%">
			    <tr>
				     <td>
					     <!--- <span style="color:red;">
						        <cfoutput>#msg7#.</cfoutput>
						  </span>--->
						  <img src="/images/DataNotFound.jpg" border="0" />
					 </td>
				</tr>
			</table>   		
	 </cfif>	
  </div>		
</div> 
 
 
<br><br>
