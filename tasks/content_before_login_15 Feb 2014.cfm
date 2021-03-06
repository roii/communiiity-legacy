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
<cfif isdefined("FORM.search_keyword")>
	<cfif FORM.search_keyword neq ''>  
		   and (P.Title LIKE '%#trim(FORM.search_keyword)#%' or P.INTROTEXT LIKE '%#trim(FORM.search_keyword)#%' or P.details LIKE '%#trim(FORM.search_keyword)#%') 
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
	  	
	    <form name="filterform" action="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer; color: white; text-decoration:none; text-transform:uppercase; font-size: 10pt; font-weight: bold;" name="go"> 
	        
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
                                SELECT count(*) as total FROM Projects WHERE ProjectCategoryID = #amarCatDetails.ProjectCategoryID#
                          </cfquery>
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
					     <cfset temp = ListFind(FORM.priorityselected, '1')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_1" value="1" /> &nbsp;
						          #high#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_1" checked="checked" value="1" /> &nbsp;
						          #high#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, '2')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_2" value="2" /> &nbsp;
						          #normal#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_2" checked="checked" value="2" /> &nbsp;
						          #normal#<br />
							</cfif>
							
						 <cfset temp = ListFind(FORM.priorityselected, '3')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_3" value="3" /> &nbsp;
						          #low#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_3" checked="checked" value="3" /> &nbsp;
						          #low#<br />
							</cfif>	
							
						  <!---<cfset temp = ListFind(FORM.priorityselected, 'Medium')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_4" value="Medium" /> &nbsp;
						          #Medium#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_4" checked="checked" value="Medium" /> &nbsp;
						          #Medium#<br />
							</cfif>--->		
					<cfelse>
					     <input type="checkbox" name="priorityselected" id="prior_1" value="1" /> &nbsp;
						  #high#<br />
						 <input type="checkbox" name="priorityselected" id="prior_2" value="2" /> &nbsp;
						  #normal#<br />
						 <input type="checkbox" name="priorityselected" id="prior_3" value="3" /> &nbsp;
						  #low#<br />
						  <!---<input type="checkbox" name="priorityselected" id="prior_4" value="Medium" /> &nbsp;
						  #Medium#--->
					</cfif> 
				</div>	  
			</cfoutput> 
			<br /><br />
			<input type="button" value="#resetS# &gt;&gt;" class="buttonControl" style="cursor: pointer; color: white; text-decoration:none; text-transform:uppercase; font-size: 10pt; font-weight: bold;" onclick="javascript: window.location = '#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#';" name="go">
		 </form>	
        </cfoutput>
  </div>
  <div class="rightwidth">  
         <cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#> 
			<cfif IsDefined("FORM.selStatus") and FORM.selStatus neq ''>
				 <cfset selStatus = #FORM.selStatus#>
			<cfelse>
				 <cfset selStatus = ''>	 
			</cfif>
			
			<cfif IsDefined("FORM.selCategory") and FORM.selCategory neq ''>
				 <cfset selCategory = #FORM.selCategory#>
			<cfelse>
				 <cfset selCategory = ''>	 
			</cfif>
			
			<cfif IsDefined("FORM.selPriority") and FORM.selPriority neq ''>
				 <cfset selPriority = #FORM.selPriority#>
			<cfelse>
				 <cfset selPriority = ''>	 
			</cfif>
			
			<cfif IsDefined("FORM.search_keyword") and FORM.search_keyword neq ''>
				 <cfset search_keyword = #FORM.search_keyword#>
			<cfelse>
				 <cfset search_keyword = ''>	 
			</cfif>  
			
			 <cfset userip = CGI.REMOTE_ADDR> 
			 
			<cfif session.UserIsAuthenticated EQ 'Yes'>
			        <cfquery name="getRowValue" datasource="#dsn#" username="#request.username#" password="#request.password#">
						  SELECT pageoption FROM tasks_page_options
						   WHERE userid = #session.userid#
					</cfquery>
			<cfelse> 
					<cfquery name="getRowValue" datasource="#dsn#" username="#request.username#" password="#request.password#">
						  SELECT pageoption FROM tasks_page_options
						   WHERE userip = '#userip#' 
					</cfquery>
			</cfif>
			 
			<cfif getRowValue.recordcount gt 0>
			      <cfset pageoption = getRowValue.pageoption>
			<cfelse>
			      <cfset pageoption = 10>
			</cfif>
			
			<cfif session.UserIsAuthenticated EQ 'Yes'>
			      <cfset lastparams = "userid=#session.userid#&userip=0">
			<cfelse>
			      <cfset lastparams = "userid=0&userip=#userip#">	  
			</cfif>
			 
				<!---Start of new code added to display jqgrid box   Added by Veena --->
				<script type="text/javascript">
					jQuery("document").ready(function() { 
						jQuery("#list2").jqGrid({
							url:'<cfoutput>#request.webroot#</cfoutput>/tasks/projectsList.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&search_keyword=<cfoutput>#search_keyword#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&groupID=<cfoutput>#groupID#</cfoutput>&<cfoutput>#lastparams#</cfoutput>',
							width:"auto",
							height:"auto",
							datatype: "json",
							colNames:['<cfoutput>#pID#</cfoutput>', '<cfoutput>#tasks#</cfoutput>', '<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#points#</cfoutput>','<cfoutput>#assignedto#</cfoutput>','<cfoutput>#percentdone#</cfoutput>'],
							colModel:[
								{name:'pID',index:'ProjectID', width:55},
								{name:'Tasks',index:'INTROTEXT', width:360},
								{name:'P',index:'Priority', width:40, sortable:false},
								{name:'Points',index:'CreditsOffered', width:85, align:"right"},
								{name:'Assigned to',index:'AssignedTo', width:115, align:"left"}, 
								{name:'% done',index:'PercentComplete', width:80,align:"center"}
							],
							rowNum:<cfoutput>#pageoption#</cfoutput>,
							rowList:[10,30,90,150,230],
							pager: '#pager2',
							sortname: 'Priority',
							viewrecords: true,
							sortorder: "asc",
							caption:""
							}); 
						});
				</script>
				<table id="list2"></table>
				<div id="pager2"></div>    
  </div>		
</div>