<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Display Task</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js"></script>
<script src="<cfoutput>#webroot#</cfoutput>/includes/js/grid.locale-en.js"></script>
<script src="<cfoutput>#webroot#</cfoutput>/includes/js/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" href="<cfoutput>#webroot#</cfoutput>/includes/css/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="<cfoutput>#webroot#</cfoutput>/includes/css/ui.jqgrid.css" type="text/css" />
<link rel="stylesheet" href="<cfoutput>#webroot#</cfoutput>/css/myCS.css" type="text/css" />

<style>
.buttonControl {
    background-color: #07A64C;
    border: 1px solid #B4B4B4;
    color: #FCFBFA;
    font-family: Arial,Trebuchet MS,Verdana;
    font-size: 11px;
    font-weight: normal;
}
</style>

<cfif IsDefined("URL.selStatus") and URL.selStatus neq ''>
     <cfset selStatus = #URL.selStatus#>
<cfelse>
     <cfset selStatus = ''>	 
</cfif>

<cfif IsDefined("URL.selCategory") and URL.selCategory neq ''>
     <cfset selCategory = #URL.selCategory#>
<cfelse>
     <cfset selCategory = ''>	 
</cfif>

<cfif IsDefined("URL.selPriority") and URL.selPriority neq ''>
     <cfset selPriority = #URL.selPriority#>
<cfelse>
     <cfset selPriority = ''>	 
</cfif>  

<cfif IsDefined("FORM.search_keyword") and FORM.search_keyword neq ''>
	 <cfset search_keyword = #FORM.search_keyword#>
<cfelse>
	 <cfset search_keyword = ''>	 
</cfif> 

<cfoutput>
	<script language="javascript">
	   var selStatusJS   = '#selStatus#';
	   var selCategoryJS = '#selCategory#';
	   var selPriorityJS = '#selPriority#';
	  
	   function showhide()
	   {   
			 document.getElementById('statuallselected').checked = true;	 
			  arrChecks = document.filterform.statuselected;
				
			  if(selStatusJS == '')
			  {
					 for (i=0; i<arrChecks.length; i++)
					 {
						  arrChecks[i].checked = true;
					 } 
					 document.getElementById('statuallselected').checked = true;
					 document.getElementById('statusBoxID').style.display = "none";
					 document.getElementById('statimgID').src = "#webroot#/images/toogle-panel-expand.gif";
			  }
			 else if(selStatusJS == 'showallstatus')
			  {
					 for (i=0; i<arrChecks.length; i++)
					 { 
						 arrChecks[i].checked = true; 
					 } 
					 document.getElementById('statuallselected').checked = true;
					 document.getElementById('statusBoxID').style.display = "";
					 document.getElementById('statimgID').src = "#webroot#/images/toogle-panel-collapse.gif";
			  }
			 else
			  {
					 var res = selStatusJS.split(",");
					 var totalStatusLenSelected = res.length;
					 var totalstatuschkboxes = arrChecks.length;
					 
						for (i=0; i<arrChecks.length; i++)
						 {
							  var chekboxVal = arrChecks[i].value;
							  var pos = selStatusJS.indexOf(chekboxVal); 
							   if(pos >= 0)
							   {
								   arrChecks[i].checked = true;
							   } 
							   else
							   {
								   arrChecks[i].checked = false;
							   }
						 } 
					  
						if(totalStatusLenSelected == totalstatuschkboxes)
						{
							 document.getElementById('statuallselected').checked = true;
						}
						else
						{
							 document.getElementById('statuallselected').checked = false;
						} 	 
							 
					  document.getElementById('statusBoxID').style.display = "";
					  document.getElementById('statimgID').src = "#webroot#/images/toogle-panel-collapse.gif";
				}	 
				 
				
				
				 
				 
			 document.getElementById('priorityallselected').checked = true;
			  arrChecks = document.filterform.priorityselected;
			  
			   if(selPriorityJS == '')
			  {
					 for (i=0; i<arrChecks.length; i++)
					 {
						  arrChecks[i].checked = true;
					 } 
					 document.getElementById('priorityallselected').checked = true;
					 document.getElementById('priorityBoxID').style.display = "none";
					 document.getElementById('priorityimgID').src = "#webroot#/images/toogle-panel-expand.gif";
			  }
			 else if(selPriorityJS == 'showallpriorities')
			  {
					 for (i=0; i<arrChecks.length; i++)
					 { 
						 arrChecks[i].checked = true; 
					 } 
					 document.getElementById('priorityallselected').checked = true;
					 document.getElementById('priorityBoxID').style.display = "";
					 document.getElementById('priorityimgID').src = "#webroot#/images/toogle-panel-collapse.gif";
			  }
			 else
			  {
					 var res = selPriorityJS.split(",");
					 var totalPriorityLenSelected = res.length;
					 var totalPrioritychkboxes = arrChecks.length;
					 
						for (i=0; i<arrChecks.length; i++)
						 {
							  var chekboxVal = arrChecks[i].value;
							  var pos = selPriorityJS.indexOf(chekboxVal); 
							   if(pos >= 0)
							   {
								   arrChecks[i].checked = true;
							   } 
							   else
							   {
								   arrChecks[i].checked = false;
							   }
						 } 
					
					  if(totalPriorityLenSelected == totalPrioritychkboxes)
						{
							 document.getElementById('priorityallselected').checked = true;
						}
						else
						{
							 document.getElementById('priorityallselected').checked = false;
						}	 
						 
					  document.getElementById('priorityBoxID').style.display = "";
					  document.getElementById('priorityimgID').src = "#webroot#/images/toogle-panel-collapse.gif";
				} 	 
	   }
	   
	   function showhideBoxesAgain(boxID, imgID)
	   {
			 var boxIDcheck = document.getElementById(boxID).style.display;
			   if(boxIDcheck == "none")
			   {
					 document.getElementById(boxID).style.display = "";
					 document.getElementById(imgID).src = "#webroot#/images/toogle-panel-collapse.gif";
			   }
			   else
			   {
					 document.getElementById(boxID).style.display = "none";
					 document.getElementById(imgID).src = "#webroot#/images/toogle-panel-expand.gif"; 
			   }
	   }
	</script>
</cfoutput>

</head>

<body onLoad="showhide();">

<cfhttp method="get" url="#webroot#/langCSVs/#URL.filename#" name="csvData"> 
<cfset langArray = ArrayNew(1)>
<cfset ctr = 1>

<cfset totalRows = csvdata.recordcount> 
<cfoutput>  
	<cfloop query="csvdata">
	   <cfset structData = StructNew()>
	   <cfset structData.VARIABLE = #csvdata.VARIABLE#>
	   <cfset structData.VALUE = #csvdata.VALUE#>
	   <cfsavecontent variable="#csvdata.VARIABLE#">#csvdata.VALUE#</cfsavecontent>
	   <cfset langArray[ctr] = structData>
	   <cfset ctr = ctr + 1>
	</cfloop> 
</cfoutput> 

<script language="javascript">
 function openTask(ProjectCategoryID, ProjectID) {
     var linked = "<cfoutput>#webroot#</cfoutput>/index.cfm?fuseaction=tasks&fusesubaction=index&documentID=5&projectmode=template&ProjectCategoryID="+ProjectCategoryID+"&ProjectID="+ProjectID+"&campaignID=<cfoutput>#campaignID#</cfoutput>&maintask=0";
     parent.document.location.href = linked;
 }
 
 function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Task?')) {
	      parent.document.location.href = aURL;
	    }
  }
  
  function resetS()
  { 
       var linked = "<cfoutput>#webroot#/projects/display_tasks.cfm?ProjectCatIDList=#ProjectCatIDList#&webroot=#webroot#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&allowTasks=#allowTasks#&campaignID=#campaignID#&filename=#filename#&userisauthenti=#userisauthenti#&dsn=#dsn#&username=#username#&password=#URL.password#&suserid=#suserid#&UserType=#UserType#</cfoutput>"; 
       document.location.href = linked;
  }
</script>

<cfset userip = CGI.REMOTE_ADDR>  

<cfif #URL.userisauthenti# EQ 'Yes'>
		<cfquery name="getRowValue" datasource="#URL.dsn#" username="#URL.username#" password="#URL.password#">
			  SELECT pageoption FROM tasks_page_options
			   WHERE userid = #URL.suserid#
		</cfquery>
<cfelse> 
		<cfquery name="getRowValue" datasource="#URL.dsn#" username="#URL.username#" password="#URL.password#">
			  SELECT pageoption FROM tasks_page_options
			   WHERE userip = '#userip#' 
		</cfquery>
</cfif>
 
<cfif getRowValue.recordcount gt 0>
	  <cfset pageoption = getRowValue.pageoption>
<cfelse>
	  <cfset pageoption = 10>
</cfif>

<cfif #URL.userisauthenti# EQ 'Yes'>
	  <cfset lastparams = "userid=#URL.suserid#&userip=0">
<cfelse>
	  <cfset lastparams = "userid=0&userip=#userip#">	  
</cfif> 


<div class="fullwidth">
   <div class="leftwidth" style="width: 20%;">
        <script language="javascript">
	       function checkform()
		   {  
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
				
				selStatusVal = temp;
				
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
				
				selPriorityVal = temp;
				
				var action = document.filterform.action;
				document.filterform.action = action + "&selStatus="+selStatusVal+"&selPriority="+selPriorityVal+""; 
			  return true;
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
	  	 
	     <form name="filterform" action="#webroot#/projects/display_tasks.cfm?ProjectCatIDList=#ProjectCatIDList#&webroot=#webroot#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&allowTasks=#allowTasks#&campaignID=#campaignID#&filename=#filename#&userisauthenti=#userisauthenti#&dsn=#dsn#&username=#username#&password=#URL.password#&suserid=#suserid#&UserType=#UserType#" method="post" onsubmit="return checkform();">
		    <input type="hidden" name="selCategory" id="selCategory" value="" />	 
			<input type="hidden" name="selStatus" id="selStatus" value="" />
			<input type="hidden" name="selPriority" id="selPriority" value="" />
			
			<input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer; color: white; text-decoration:none; text-transform:uppercase; font-size: 10pt; font-weight: bold;" name="go"> 
			<br />
			<br />
			<div> 
			      <span><cfoutput>#searchkeyword#</cfoutput>:</span>
				  <span> 
				        <input type="text" maxlength="50" size="24" name="search_keyword" id="search_keyword" value="<cfif IsDefined("FORM.search_keyword") and FORM.search_keyword neq ''><cfoutput>#FORM.search_keyword#</cfoutput></cfif>">
				  </span>
			</div>
			<br />
			  
			  
			<br />
			<span style="font-size: 17px; font-weight: bold;">
			    <cfoutput>#status#</cfoutput>
			</span><br />
			<cfoutput> 
			   <a href="javascript: void(0);" onclick="showhideBoxesAgain('statusBoxID', 'statimgID');" style="font-weight: bold; text-decoration:none; color: ##91AE4E;"> 
				      <img id="statimgID" src="#webroot#/images/toogle-panel-expand.gif" border="0" /> 
			   </a>
			   <cfif isDefined("URL.selStatus") and #URL.selStatus# eq 'showallstatus'>
			        <input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" checked="checked" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
			   <cfelse>
			        <input type="checkbox" name="statuallselected" id="statuallselected" value="showallstatus" onclick="setstatvalues(this);" /> &nbsp;#showall# <br />
			   </cfif>	
				<div style="margin-left: 40px;" id="statusBoxID">
				    <cfif IsDefined("URL.STATUSELECTED") >
					     <cfset temp = ListFind(URL.STATUSELECTED, 'Being Planned')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_1" value="Being Planned" /> &nbsp;
						           #beingplan#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_1" checked="checked" value="Being Planned" /> &nbsp;
						           #beingplan#<br /> 
							</cfif>
							
						 <cfset temp = ListFind(URL.STATUSELECTED, 'Available Now')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_2" value="Available Now" /> &nbsp;
						           #availnow#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" id="stat_2" checked="checked" value="Available Now" /> &nbsp;
						           #availnow#<br />
							</cfif>
							
					     <cfset temp = ListFind(URL.STATUSELECTED, 'In progress')> 
							<cfif temp is 0>  
								<input type="checkbox" name="statuselected" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							<cfelse> 
								<input type="checkbox" name="statuselected" checked="checked" id="stat_3" value="In progress" /> &nbsp;
						           #inprog#<br />
							</cfif>	
							
						 <cfset temp = ListFind(URL.STATUSELECTED, 'All Done')> 
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
				      <img id="priorityimgID" src="#webroot#/images/toogle-panel-expand.gif" border="0" /> 
			    </a>
			    <cfif isDefined("URL.selPriority") and #URL.selPriority# eq 'showallpriorities'>
				       <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" checked="checked" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
				<cfelse>
			          <input type="checkbox" name="priorityallselected" id="priorityallselected" value="showallpriorities" onclick="setpriorityvalues(this);" /> &nbsp;#showall#<br />
			    </cfif>		   
				<div style="margin-left: 40px;" id="priorityBoxID">
				    <cfif IsDefined("URL.priorityselected") >
					     <cfset temp = ListFind(URL.priorityselected, '1')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_1" value="1" /> &nbsp;
						          #high#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_1" checked="checked" value="1" /> &nbsp;
						          #high#<br />
							</cfif>
							
						 <cfset temp = ListFind(URL.priorityselected, '2')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_2" value="2" /> &nbsp;
						          #normal#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_2" checked="checked" value="2" /> &nbsp;
						          #normal#<br />
							</cfif>
							
						 <cfset temp = ListFind(URL.priorityselected, '3')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_3" value="3" /> &nbsp;
						          #low#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_3" checked="checked" value="3" /> &nbsp;
						          #low#<br />
							</cfif>	
						
						 <!---<cfset temp = ListFind(URL.priorityselected, 'Medium')> 
							<cfif temp is 0>  
								<input type="checkbox" name="priorityselected" id="prior_4" value="Medium" /> &nbsp;
						          #Medium#<br />
							<cfelse> 
								<input type="checkbox" name="priorityselected" id="prior_4" checked="checked" value="Medium" /> &nbsp;
						          #Medium#<br />
							</cfif>	--->	
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
			<input type="button" value="#resetS# &gt;&gt;" class="buttonControl" style="cursor: pointer; color: white; text-decoration:none; text-transform:uppercase; font-size: 10pt; font-weight: bold;" onclick="resetS();" name="go">
		 </form>
        </cfoutput>
   </div>
   <div class="rightwidth" style="width: 80%;">
		<cfif allowTasks eq 1>
		<!---Start of new code added to display jqgrid box   Added by Veena --->
			<script type="text/javascript">
				jQuery("document").ready(function() { 
					jQuery("#list2").jqGrid({
						url:'<cfoutput>#webroot#</cfoutput>/projects/projectsListData.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&<cfoutput>#lastparams#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&search_keyword=<cfoutput>#search_keyword#</cfoutput>',
						width:"auto",
						height:"auto",
						datatype: "json",
						colNames:['<cfoutput>#tID#</cfoutput>','<cfoutput>#tasks#</cfoutput>', '<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#points#</cfoutput>','<cfoutput>#assignedto#</cfoutput>','<cfoutput>#percentdone#</cfoutput>'],
						colModel:[
							{name:'tID',index:'ProjectID', width:55},
							{name:'Tasks',index:'INTROTEXT', width:360},
							{name:'P',index:'Priority', width:40, sortable:true},
							{name:'Points',index:'CreditsOffered', width:85, align:"left"},
							{name:'Assigned to',index:'AssignedTo', width:115, align:"right"},
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
		<cfelse>
			<!---Start of new code added to display jqgrid box   Added by Veena --->
			<script type="text/javascript">
				jQuery("document").ready(function() { 
					jQuery("#list2").jqGrid({
						url:'<cfoutput>#webroot#</cfoutput>/projects/projectsListData.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&<cfoutput>#lastparams#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&search_keyword=<cfoutput>#search_keyword#</cfoutput>',
						width:"auto",
						height:"auto",
						datatype: "json",
						colNames:['<cfoutput>#tID#</cfoutput>', '<cfoutput>#tasks#</cfoutput>', '<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#points#</cfoutput>','<cfoutput>#assignedto#</cfoutput>','<cfoutput>#percentdone#</cfoutput>'],
						colModel:[
							{name:'tID',index:'ProjectID', width:55},
							{name:'Tasks',index:'INTROTEXT', width:360},
							{name:'P',index:'Priority', width:55, sortable:false},
							{name:'Points',index:'CreditsOffered', width:110, align:"left"},
							{name:'Assigned to',index:'AssignedTo', width:90, align:"right"},
							{name:'% done',index:'PercentComplete', width:70,align:"center"}
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
		</cfif>	 
			<table id="list2" style="font-size: 12px;"></table>
			<div id="pager2"></div> 
	</div>		
</div>			
</body>
</html>