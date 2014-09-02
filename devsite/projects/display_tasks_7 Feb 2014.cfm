<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js"></script>
<script src="<cfoutput>#webroot#</cfoutput>/includes/js/grid.locale-en.js"></script>
<script src="<cfoutput>#webroot#</cfoutput>/includes/js/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" href="<cfoutput>#webroot#</cfoutput>/includes/css/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="<cfoutput>#webroot#</cfoutput>/includes/css/ui.jqgrid.css" type="text/css" />


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
     var linked = "<cfoutput>#webroot#</cfoutput>/index.cfm?fuseaction=tasks&fusesubaction=index&documentID=5&projectmode=template&ProjectCategoryID="+ProjectCategoryID+"&ProjectID="+ProjectID;
     parent.document.location.href = linked;
 }
 
 function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Task?')) {
	      parent.document.location.href = aURL;
	    }
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

<cfif allowTasks eq 1>
<!---Start of new code added to display jqgrid box   Added by Veena --->
	<script type="text/javascript">
		jQuery("document").ready(function() { 
			jQuery("#list2").jqGrid({
				url:'<cfoutput>#webroot#</cfoutput>/projects/projectsListData.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&<cfoutput>#lastparams#</cfoutput>',
				width:"auto",
				height:"auto",
				datatype: "json",
				colNames:['<cfoutput>#pID#</cfoutput>','<cfoutput>#tasks#</cfoutput>', '<cfoutput>#category#</cfoutput>','<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#status#</cfoutput>','<cfoutput>#value#</cfoutput>', '<cfoutput>#actions#</cfoutput>'],
				colModel:[
					{name:'pID',index:'ProjectID', width:55},
					{name:'Projects',index:'INTROTEXT', width:360},
					{name:'Category',index:'ProjectCategories.Title', width:110},
					{name:'P',index:'Priority', width:55, align:"left"},
					{name:'Status',index:'CurrentStatus', width:90, align:"right"},
					{name:'Value',index:'CreditsOffered', width:50,align:"center"}, 
					{name:'Actions',index:'Actions', width:95, sortable:false}
				],
				rowNum:<cfoutput>#pageoption#</cfoutput>,
				rowList:[10,30,90,150,230],
				pager: '#pager2',
				sortname: 'ProjectID',
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
				url:'<cfoutput>#webroot#</cfoutput>/projects/projectsListData.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&<cfoutput>#lastparams#</cfoutput>',
				width:"auto",
				height:"auto",
				datatype: "json",
				colNames:['<cfoutput>#pID#</cfoutput>', '<cfoutput>#tasks#</cfoutput>', '<cfoutput>#category#</cfoutput>','<cfoutput>#ptextContent#</cfoutput>','<cfoutput>#status#</cfoutput>','<cfoutput>#value#</cfoutput>'],
				colModel:[
					{name:'pID',index:'ProjectID', width:55},
					{name:'Projects',index:'INTROTEXT', width:360},
					{name:'Category',index:'ProjectCategories.Title', width:110},
					{name:'P',index:'Priority', width:55, align:"left"},
					{name:'Status',index:'CurrentStatus', width:90, align:"right"},
					{name:'Value',index:'CreditsOffered', width:50,align:"center"}
				],
				rowNum:<cfoutput>#pageoption#</cfoutput>,
				rowList:[10,30,90,150,230],
				pager: '#pager2',
				sortname: 'ProjectID',
				viewrecords: true,
				sortorder: "asc",
				caption:""
				}); 
			});
	</script> 	  
</cfif>	
	
	<table id="list2" style="font-size: 12px;"></table>
	<div id="pager2"></div> 