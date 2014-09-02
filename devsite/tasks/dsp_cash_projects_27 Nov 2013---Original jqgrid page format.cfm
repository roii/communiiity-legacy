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
	    if(confirm('Are you sure you want to delete this Task?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	</script>

</cfif>


<cfoutput>

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>


<a href="#request.webroot#/admin/dsp_cashproject_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#AddNewTask# &raquo;</strong></a> <!---&nbsp;&nbsp;&nbsp; 
<a href="#request.webroot#/admin/dsp_cashprojectcat_add.cfm?documentID=#documentID#" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=550,height=300,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A CATEGORY &raquo;</strong></a>---><br>
<br>

</cfif>

</cfoutput>
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

<SELECT NAME="selCategory" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE=""><cfoutput>#category#</cfoutput>
	<cfoutput><OPTION VALUE="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">#showall#</cfoutput>
	<cfloop query="amarCatDetails">
		<cfoutput>
		<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selCategory=#amarCatDetails.ProjectCategoryID#&groupID=#groupID#">#amarCatDetails.CategoryTitle#
		</cfoutput>
	</cfloop>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selStatus" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE=""><cfoutput>#status#</cfoutput>
	<cfoutput>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">#showall#
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=Being Planned&groupID=#groupID#" <cfif selStatus eq "Being Planned">Selected</cfif>>#beingplan#</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=Available Now&groupID=#groupID#" <cfif selStatus eq "Available Now">Selected</cfif>>#availnow#</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=In progress&groupID=#groupID#" <cfif selStatus eq "In progress">Selected</cfif>>#inprog#</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selStatus=All Done&groupID=#groupID#" <cfif selStatus eq "All Done">Selected</cfif>>#alldone#</option>
	</cfoutput>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selPriority" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE=""><cfoutput>#priority#</cfoutput>
	<cfoutput>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#url.documentID#&groupID=#groupID#">#showall#
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=High&groupID=#groupID#" <cfif selPriority eq "High">Selected</cfif>>#high#</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=Normal&groupID=#groupID#" <cfif selPriority eq "Normal">Selected</cfif>>#normal#</option>
	<OPTION VALUE="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#url.documentID#&selPriority=Low&groupID=#groupID#" <cfif selPriority eq "Low">Selected</cfif>>#low#</option>
	</cfoutput>
</SELECT>
<p/>

<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#>

<cfif IsDefined("url.selStatus") and url.selStatus neq ''>
     <cfset selStatus = #url.selStatus#>
<cfelse>
     <cfset selStatus = ''>	 
</cfif>

<cfif IsDefined("url.selCategory") and url.selCategory neq ''>
     <cfset selCategory = #url.selCategory#>
<cfelse>
     <cfset selCategory = ''>	 
</cfif>

<cfif IsDefined("url.selPriority") and url.selPriority neq ''>
     <cfset selPriority = #url.selPriority#>
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
<script type="text/javascript">
	jQuery("document").ready(function() { 
		jQuery("#list2").jqGrid({
			url:'<cfoutput>#request.webroot#</cfoutput>/tasks/projectsList.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&groupID=<cfoutput>#groupID#</cfoutput>',
			width:"auto",
			height:"auto",
			datatype: "json",
			colNames:['pID','Projects', 'Category','P','Status','Value', 'Actions'],
			colModel:[
				{name:'pID',index:'ProjectID', width:55},
				{name:'Projects',index:'INTROTEXT', width:500},
				{name:'Category',index:'ProjectCategories.Title', width:200},
				{name:'P',index:'Priority', width:70},
				{name:'Status',index:'CurrentStatus', width:90, align:"right"},
				{name:'Value',index:'CreditsOffered', width:80,align:"center"}, 
				{name:'Actions',index:'Actions', width:70, sortable:false}
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
<cfelse>
       <!---Start of new code added to display jqgrid box   Added by Veena --->
<script type="text/javascript">
	jQuery("document").ready(function() { 
		jQuery("#list2").jqGrid({
			url:'<cfoutput>#request.webroot#</cfoutput>/tasks/projectsList.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&groupID=<cfoutput>#groupID#</cfoutput>',
			width:"auto",
			height:"auto",
			datatype: "json",
			colNames:['pID','Projects', 'Category','P','Status','Value'],
			colModel:[
				{name:'pID',index:'ProjectID', width:55},
				{name:'Projects',index:'INTROTEXT', width:500},
				{name:'Category',index:'ProjectCategories.Title', width:200},
				{name:'P',index:'Priority', width:70},
				{name:'Status',index:'CurrentStatus', width:90, align:"right"},
				{name:'Value',index:'CreditsOffered', width:80,align:"center"}
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
</cfif>


<table id="list2"></table>
<div id="pager2"></div> 
<!---End of new code added to display jqgrid box   Added by Veena --->
 
<br><br>
