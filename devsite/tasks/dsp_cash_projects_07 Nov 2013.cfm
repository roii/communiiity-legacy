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


<cfoutput>

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>

<cfset documentID = 5> 
<br>

</cfif> 
</cfoutput>

<p/>

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
 
<cfif allowTasks eq 1> 
<!---Start of new code added to display jqgrid box   Added by Veena --->
<cfset sortCol = "projectID">
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
SELECT P.ProjectID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered, P.projectpic, P.details, P.addedby, P.location, P.project_order, P.displayProject, P.PercentComplete
FROM Projects P INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
WHERE P.ProjectCategoryID in (#ProjectCatIDList#)
<cfif isdefined("FORM.selStatus")>
	<cfif FORM.selStatus neq ''> 
	   <cfif FORM.selStatus neq 'showallstatus'>  
		   and P.currentstatus IN ('#Replace(trim(FORM.selStatus), ",", "','", "ALL")#')
	   </cfif>	   
	</cfif> 
</cfif>
<cfif isDefined("FORM.selCategory")>
	<cfif FORM.selCategory neq ''>
	   <cfif FORM.selCategory neq 'showallcats'> 
		  and P.ProjectCategoryID IN (#trim(FORM.selCategory)#)
	   </cfif>	  
	</cfif> 
</cfif>
<cfif isDefined("FORM.selPriority")>
	<cfif FORM.selPriority neq ''>
	   <cfif FORM.selPriority neq 'showallpriorities'>  
		  and P.Priority IN ('#Replace(trim(FORM.selPriority), ",", "','", "ALL")#')
	   </cfif>	  
	</cfif> 
</cfif>
Order by P.project_order ASC
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
		<a href="#request.webroot#/admin/dsp_cashproject_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#AddCashProject# &raquo;</strong></a>  <br /><br />
	  	
	    <form name="filterform" action="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="whitefield" style="cursor: pointer;" name="go">
			<br />
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
						<cfoutput> 
							     <cfif IsDefined("FORM.CATEGORYSELECTED") >   
									<cfset temp = ListFind(FORM.CATEGORYSELECTED, #amarCatDetails.ProjectCategoryID#)> 
									<cfif temp is 0> 
										<!---<h3>An employee with that exact last name was not found</h3> --->
										 <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 
									<cfelse> 
									     <input type="checkbox" name="categoryselected" checked="checked" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp;
									</cfif> 
								<cfelse>
								    <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 	
								</cfif>	
							 #amarCatDetails.CategoryTitle#<br />
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
					     <cfset temp = ListFind(FORM.STATUSELECTED, 'Being Planned')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_1" value="Being Planned" /> &nbsp;
						           #beingplan#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_1" checked="checked" value="Being Planned" /> &nbsp;
						           #beingplan#<br /> 
							</cfif>
							
						 <cfset temp = ListFind(FORM.STATUSELECTED, 'Available Now')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_2" value="Available Now" /> &nbsp;
						           #availnow#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_2" checked="checked" value="Available Now" /> &nbsp;
						           #availnow#<br />
							</cfif>
							
					     <cfset temp = ListFind(FORM.STATUSELECTED, 'In progress')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" checked="checked" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							</cfif>	
							
						 <cfset temp = ListFind(FORM.STATUSELECTED, 'All Done')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_4" value="All Done" /> &nbsp;
						           #alldone#
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_4" checked="checked" value="All Done" /> &nbsp;
						           #alldone#
							</cfif>				 
					<cfelse>
						<input type="checkbox" name="statuselected" id="stat_1" value="Being Planned" /> &nbsp;
						    #beingplan#<br />
						<input type="checkbox" name="statuselected" id="stat_2" value="Available Now" /> &nbsp;
						    #availnow#<br />
						<input type="checkbox" name="statuselected" id="stat_3" value="In progress" /> &nbsp;
						    #inprog#<br />
						<input type="checkbox" name="statuselected" id="stat_4" value="All Done" /> &nbsp;
						    #alldone# 
					</cfif>	 
				</div>	 
		    </cfoutput> 
			<br />
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#priority#</cfoutput>
			</span><br />
			<cfoutput> 
			    <a href="javascript: void(0);" onclick="showhideBoxesAgain('priorityBoxID', 'priorityimgID');" style="font-weight: bold; text-decoration:none; color: ##91AE4E;"> 
				      <img id="priorityimgID" src="#request.webroot#/images/toogle-panel-expand.gif" border="0" /> 
			    </a>
			    <cfif isDefined("FORM.selPriority") and #FORM.selPriority# eq 'showallpriorities'>
				       <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" checked="checked" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
				<cfelse>
			          <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
			    </cfif>		   
				<div style="margin-left: 40px;" id="priorityBoxID">
				    <cfif IsDefined("FORM.priorityselected") >
					     <cfset temp = ListFind(FORM.priorityselected, 'High')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_1" value="High" /> &nbsp;
						          #high#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_1" checked="checked" value="High" /> &nbsp;
						          #high#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, 'Normal')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_2" value="Normal" /> &nbsp;
						          #normal#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_2" checked="checked" value="Normal" /> &nbsp;
						          #normal#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, 'Low')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_3" value="Low" /> &nbsp;
						          #low#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_3" checked="checked" value="Low" /> &nbsp;
						          #low#<br />
							</cfif>		
					<cfelse>
					     <input type="checkbox" name="priorityselected" id="prior_1" value="High" /> &nbsp;
						  #high#<br />
						 <input type="checkbox" name="priorityselected" id="prior_2" value="Normal" /> &nbsp;
						  #normal#<br />
						 <input type="checkbox" name="priorityselected" id="prior_3" value="Low" /> &nbsp;
						  #low#
					</cfif> 
				</div>	  
			</cfoutput> 
			<br /><br />
			<input type="submit" value="#search# &gt;&gt;" class="whitefield" style="cursor: pointer;" name="go">
		 </form>	
        </cfoutput>
  </div>
  <div class="rightwidth">
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
									  <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#">
										 <cfif ProjectDetails.projectpic neq ''>
											<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.projectpic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
										 <cfelse>
											<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
										 </cfif>
									</a></div>
									
									<div class="project-category"> 
										   #ProjectDetails.ProjectCategory# 
									</div>
									
									<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;"> 
										<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#" class="name bold"> 
												<cfset nameNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.IntroText),"<[^>]*>","","ALL") />
												 <!---#ReReplace(TRIM(nameNOHTML),"\b(\w)","\u\1","ALL")#--->
												 #Mid(TRIM(nameNOHTML),1, 150)#
										</a>	
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
										 <p class="description">
											 <cfset descNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.details),"<[^>]*>","","ALL") />
											 <!---<cfset descData = #ReReplace(TRIM(descNOHTML),"\b(\w)","\u\1","ALL")#>--->
											 #Mid(TRIM(descNOHTML),1, 100)#... 
										 </p>  
									</div>  
									   
									     <div style="border-top: 1px solid ##808080; margin-top: 12px; height: 60px; padding-left: 10px;">
										      <cfset this_percentDone = ProjectDetails.PercentComplete>
											 <cfif this_percentDone neq '' and this_percentDone gt 0>
												 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/projects/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
												 
												 <div style="width: 206px !important; overflow: hidden;"> 
													 <cfinclude template="dsp_percent_bar.cfm"> 
												 </div>
											 </cfif> <br />
											 <a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit this Project" border="0"></a> <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete.cfm?projectID=#ProjectDetails.projectID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete this Project" border="0"></a>
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
					      <span style="color:red;">
						        <cfoutput>#msg7#.</cfoutput>
						  </span>
					 </td>
				</tr>
			</table>   		
	 </cfif>	
  </div>		
</div>
   
<cfelse> 

<cfset sortCol = "projectID">
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
SELECT P.ProjectID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered, P.projectpic, P.details, P.addedby, P.location, P.project_order, P.displayProject, P.PercentComplete
FROM Projects P INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
WHERE P.ProjectCategoryID in (#ProjectCatIDList#)
<cfif isdefined("FORM.selStatus")>
	<cfif FORM.selStatus neq ''> 
	   <cfif FORM.selStatus neq 'showallstatus'>  
		   and P.currentstatus IN ('#Replace(trim(FORM.selStatus), ",", "','", "ALL")#')
	   </cfif>	   
	</cfif> 
</cfif>
<cfif isDefined("FORM.selCategory")>
	<cfif FORM.selCategory neq ''>
	   <cfif FORM.selCategory neq 'showallcats'> 
		  and P.ProjectCategoryID IN (#trim(FORM.selCategory)#)
	   </cfif>	  
	</cfif> 
</cfif>
<cfif isDefined("FORM.selPriority")>
	<cfif FORM.selPriority neq ''>
	   <cfif FORM.selPriority neq 'showallpriorities'>  
		  and P.Priority IN ('#Replace(trim(FORM.selPriority), ",", "','", "ALL")#')
	   </cfif>	  
	</cfif> 
</cfif>
Order by P.project_order ASC
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
				
			
			     var res1 = document.getElementById('selCategory').value.split(",");
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
				 }
				
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
	    <form name="filterform" action="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="whitefield" style="cursor: pointer;" name="go">
			<br />
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
			       <cfif isDefined("FORM.selCategory") and #FORM.selCategory# eq 'showallcats'>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="showallcats" checked="checked" onclick="setvalues(this);" /> &nbsp;#showall#
				   <cfelse>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="showallcats" onclick="setvalues(this);" /> &nbsp;#showall#
				   </cfif> 
			   </cfoutput><br />
			    <div style="margin-left: 40px;" id="categoryBoxID">
					<cfloop query="amarCatDetails">
						<cfoutput> 
							     <cfif IsDefined("FORM.CATEGORYSELECTED") >   
									<cfset temp = ListFind(FORM.CATEGORYSELECTED, #amarCatDetails.ProjectCategoryID#)> 
									<cfif temp is 0> 
										<!---<h3>An employee with that exact last name was not found</h3> --->
										 <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 
									<cfelse> 
									     <input type="checkbox" name="categoryselected" checked="checked" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp;
									</cfif> 
								<cfelse>
								    <input type="checkbox" name="categoryselected" id="cat_#amarCatDetails.ProjectCategoryID#" value="#amarCatDetails.ProjectCategoryID#" /> &nbsp; 	
								</cfif>	
							 #amarCatDetails.CategoryTitle#<br />
						</cfoutput>
					</cfloop> 
				</div>	
			</span> 
			<br />
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#status#</cfoutput>
			</span><br />
			<cfoutput> 
			   <cfif isDefined("FORM.selStatus") and #FORM.selStatus# eq 'showallstatus'>
			        <input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" checked="checked" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
			   <cfelse>
			        <input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
			   </cfif>	
				<div style="margin-left: 40px;" id="statusBoxID">
				    <cfif IsDefined("FORM.STATUSELECTED") >
					     <cfset temp = ListFind(FORM.STATUSELECTED, 'Being Planned')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_1" value="Being Planned" /> &nbsp;
						           #beingplan#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_1" checked="checked" value="Being Planned" /> &nbsp;
						           #beingplan#<br /> 
							</cfif>
							
						 <cfset temp = ListFind(FORM.STATUSELECTED, 'Available Now')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_2" value="Available Now" /> &nbsp;
						           #availnow#<br />

							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_2" checked="checked" value="Available Now" /> &nbsp;
						           #availnow#<br />
							</cfif>
							
					     <cfset temp = ListFind(FORM.STATUSELECTED, 'In progress')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" checked="checked" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							</cfif>	
							
						 <cfset temp = ListFind(FORM.STATUSELECTED, 'All Done')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_4" value="All Done" /> &nbsp;
						           #alldone#
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_4" checked="checked" value="All Done" /> &nbsp;
						           #alldone#
							</cfif>				 
					<cfelse>
						<input type="checkbox" name="statuselected" id="stat_1" value="Being Planned" /> &nbsp;
						    #beingplan#<br />
						<input type="checkbox" name="statuselected" id="stat_2" value="Available Now" /> &nbsp;
						    #availnow#<br />
						<input type="checkbox" name="statuselected" id="stat_3" value="In progress" /> &nbsp;
						    #inprog#<br />
						<input type="checkbox" name="statuselected" id="stat_4" value="All Done" /> &nbsp;
						    #alldone# 
					</cfif>	 
				</div>	 
		    </cfoutput> 
			<br />
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#priority#</cfoutput>
			</span><br />
			<cfoutput> 
			    <cfif isDefined("FORM.selPriority") and #FORM.selPriority# eq 'showallpriorities'>
				       <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" checked="checked" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
				<cfelse>
			          <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
			    </cfif>		   
				<div style="margin-left: 40px;" id="priorityBoxID">
				    <cfif IsDefined("FORM.priorityselected") >
					     <cfset temp = ListFind(FORM.priorityselected, 'High')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_1" value="High" /> &nbsp;
						          #high#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_1" checked="checked" value="High" /> &nbsp;
						          #high#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, 'Normal')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_2" value="Normal" /> &nbsp;
						          #normal#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_2" checked="checked" value="Normal" /> &nbsp;
						          #normal#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, 'Low')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_3" value="Low" /> &nbsp;
						          #low#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_3" checked="checked" value="Low" /> &nbsp;
						          #low#<br />
							</cfif>		
					<cfelse>
					     <input type="checkbox" name="priorityselected" id="prior_1" value="High" /> &nbsp;
						  #high#<br />
						 <input type="checkbox" name="priorityselected" id="prior_2" value="Normal" /> &nbsp;
						  #normal#<br />
						 <input type="checkbox" name="priorityselected" id="prior_3" value="Low" /> &nbsp;
						  #low#
					</cfif> 
				</div>	  
			</cfoutput> 
			<br /><br />
			<input type="submit" value="#search# &gt;&gt;" class="whitefield" style="cursor: pointer;" name="go">
		 </form>	
        </cfoutput>
  </div>
  <div class="rightwidth">  
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
										  <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#">
											 <cfif ProjectDetails.projectpic neq ''>
												<img width="220" height="194" src="/images/carcasses_new/#ProjectDetails.projectpic#" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
											 <cfelse>
												<img width="220" height="194" src="/images/carcasses_new/no_image.png" class="fl rounded rounded-no-bottom" alt="20131006051930-ss_indiegogo_title_220x196_-_06.10">
											 </cfif>
										</a></div>
										
										<div class="project-category"> 
											   #ProjectDetails.ProjectCategory# 
										</div>
										
										<div class="project-details" style="word-wrap: break-word; color: black; height: 143px;"> 
											<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&projectmode=template&ProjectCategoryID=#TRIM(ProjectCategoryID)#&ProjectID=#TRIM(ProjectDetails.ProjectID)#" class="name bold"> 
													<cfset nameNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.IntroText),"<[^>]*>","","ALL") />
													 <!---#ReReplace(TRIM(nameNOHTML),"\b(\w)","\u\1","ALL")#--->
													 #Mid(TRIM(nameNOHTML),1, 150)#
											</a>	
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
											 <p class="description">
												 <cfset descNOHTML = ReReplaceNoCase(TRIM(ProjectDetails.details),"<[^>]*>","","ALL") />
												 <!---<cfset descData = #ReReplace(TRIM(descNOHTML),"\b(\w)","\u\1","ALL")#>--->
												 #Mid(TRIM(descNOHTML),1, 100)#... 
											 </p>  
										</div>  
											 <div style="border-top: 1px solid ##808080; margin-top: 12px; height: 60px; padding-left: 10px;">
										         <cfset this_percentDone = ProjectDetails.PercentComplete>
												 <cfif this_percentDone neq '' and this_percentDone gt 0>
													 <!---<a href="javascript: void(0);" onclick="javascript: window.open('/projects/dsp_percent_bar.cfm?this_percentDone=#this_percentDone#','name','height=2,width=350');" class="name bold">Check Progress</a>--->
													 
													 <div style="width: 206px !important; overflow: hidden;"> 
														 <cfinclude template="dsp_percent_bar.cfm"> 
													 </div>
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
							  <span style="color:red;">
									<cfoutput>#msg7#.</cfoutput>
							  </span>
						 </td>
					</tr>
				</table>   		
		 </cfif>	
  </div>		
</div>

</cfif>
 
 
<br><br>
