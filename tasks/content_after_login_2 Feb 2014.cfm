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
		<a href="#request.webroot#/admin/dsp_cashproject_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#AddNewTask# &raquo;</strong></a>  <br /><br />
	  	
	    <form name="filterform" action="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;" name="go"> &nbsp;
	        <input type="button" value="Reset Search &gt;&gt;" class="buttonControl" style="cursor: pointer;" onclick="javascript: window.location = '#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#&groupID=#groupID#';" name="go">
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
			<input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;" name="go">
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
			<!---Start of new code added to display jqgrid box   Added by Veena --->
				<script type="text/javascript">
					jQuery("document").ready(function() { 
						jQuery("#list2").jqGrid({
							url:'<cfoutput>#request.webroot#</cfoutput>/tasks/projectsList.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&search_keyword=<cfoutput>#search_keyword#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&groupID=<cfoutput>#groupID#</cfoutput>',
							width:"auto",
							height:"auto",
							datatype: "json",
							colNames:['<cfoutput>#pID#</cfoutput>','<cfoutput>#tasks#</cfoutput>', '<cfoutput>#category#</cfoutput>','<cfoutput>#status#</cfoutput>','<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#value#</cfoutput>', '<cfoutput>#actions#</cfoutput>'],
							colModel:[
								{name:'pID',index:'ProjectID', width:55},
								{name:'Projects',index:'INTROTEXT', width:390},
								{name:'Category',index:'ProjectCategories.Title', width:110}, 
								{name:'Status',index:'CurrentStatus', width:90, align:"right"},
								{name:'P',index:'Priority', width:55, align:"left"},
								{name:'Value',index:'CreditsOffered', width:50,align:"center"}, 
								{name:'Actions',index:'Actions', width:65, sortable:false}
							],
							rowNum:20,
							rowList:[10,20,30],
							pager: '#pager2',
							sortname: 'ProjectID',
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