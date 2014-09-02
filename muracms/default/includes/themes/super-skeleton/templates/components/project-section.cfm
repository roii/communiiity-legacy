<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js"></script>
<script src="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/javascripts/grid.locale-en.js"></script>
<script src="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/javascripts/jquery.jqGrid.min.js"></script>
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/stylesheets/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/stylesheets/ui.jqgrid.css" type="text/css" />
<style>
   #page-header {
       display: none !important;
   }  
</style>
<cfoutput>
<br />   
#$.setDynamicContent($.component('body'))#
</cfoutput>
<cfparam name="selStatus" default="">
<cfparam name="selPriority" default="">
<cfparam name="sortBy" default="">
<cfparam name="sortDir" default="desc">
<cfset amarCounter = 1>
<cfif IsDefined("URL.documentID") and URL.documentID neq ''>
     <cfset docID = URL.documentID>
<cfelse>
     <cfset docID = 5>	 
</cfif> 
<cfquery name="GroupResults" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
      SELECT GroupID, GroupName FROM ProjectGroups WHERE DocumentID = #docID#
</cfquery>

<cfset groupID = GroupResults.GroupID>

<cfquery name="CatDetails" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
SELECT ProjectCategoryID, Title AS CategoryTitle
FROM ProjectCategories
WHERE GroupID=#GroupID# 
AND Active = 1 
ORDER BY Active DESC, displayorder
</cfquery>  
 
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
<cfset rootPath = #$.createHREF(filename='')#>
<cfset themeAssetPath = #$.siteConfig('themeAssetPath')#>
<style>
  .selectedLink {
        background-color:#333333; 
		padding-left:4px; 
		padding-right:4px; 
		color:white;
		text-decoration:none;
  } 
  .unselectedLink {
        color:Black;
		text-decoration:underline;
  }
</style>
<script language="javascript">
  function showProjectFilterData(option, anchorID, anchorToHide1, anchorToHide2, anchorToHide3, anchorToHide4)
  {
      var docID = 5;
        if(option == 'webDev')
		{
		     docID = 5; 
		}
		else if(option == 'youth')
		{
		     docID = 88;
		}
		else if(option == 'bymembers')
		{
		     docID = 89;
		}
		else if(option == 'community')
		{
		     docID = 85;
		}
		else if(option == 'competitions')
		{
		     docID = 86;
		} 
		 document.getElementById(anchorToHide1).className = 'unselectedLink';
		 document.getElementById(anchorToHide2).className = 'unselectedLink';
		 document.getElementById(anchorToHide3).className = 'unselectedLink';
		 document.getElementById(anchorToHide4).className = 'unselectedLink';
		 document.getElementById(anchorID).className = 'selectedLink';
		 window.location = '<cfoutput>#rootPath#</cfoutput>index.cfm/projets/?documentID='+docID;
  }
</script> 

<div style="margin-bottom: 20px;">
|&nbsp; 
      <cfif docID eq 5>
         <a title="web dev / dev web" rel="web dev / dev web" id="anchor1" class="selectedLink" href="javascript: void(0);" onclick="showProjectFilterData('webDev', 'anchor1', 'anchor2', 'anchor3', 'anchor4', 'anchor5');">
	  <cfelse>
	     <a title="web dev / dev web" rel="web dev / dev web" id="anchor1" class="unselectedLink" href="javascript: void(0);" onclick="showProjectFilterData('webDev', 'anchor1', 'anchor2', 'anchor3', 'anchor4', 'anchor5');">
      </cfif> 
	          web dev / dev web
	  </a> &nbsp;|&nbsp; 
	  <cfif docID eq 88>
         <a title="youth / jeunesse" rel="youth / jeunesse" id="anchor2" class="selectedLink" href="javascript: void(0);" onclick="showProjectFilterData('youth', 'anchor2', 'anchor1', 'anchor3', 'anchor4', 'anchor5');">
	  <cfelse>
	     <a title="youth / jeunesse" rel="youth / jeunesse" id="anchor2" class="unselectedLink" href="javascript: void(0);" onclick="showProjectFilterData('youth', 'anchor2', 'anchor1', 'anchor3', 'anchor4', 'anchor5');">
      </cfif> 
	          youth / jeunesse
	  </a> &nbsp;|&nbsp; 
	  <cfif docID eq 89>
         <a title="by members / par des membres" rel="by members / par des membres" id="anchor3" class="selectedLink" href="javascript: void(0);" onclick="showProjectFilterData('bymembers', 'anchor3', 'anchor1', 'anchor2', 'anchor4', 'anchor5');">
	  <cfelse>
	     <a title="by members / par des membres" rel="by members / par des membres" id="anchor3" class="unselectedLink" href="javascript: void(0);" onclick="showProjectFilterData('bymembers', 'anchor3', 'anchor1', 'anchor2', 'anchor4', 'anchor5');">
      </cfif> 
	          by members / par des membres
	  </a> &nbsp;|&nbsp; 
	  <cfif docID eq 85>
         <a title="community / communautaires" rel="community / communautaires" id="anchor4" class="selectedLink" href="javascript: void(0);" onclick="showProjectFilterData('community', 'anchor4', 'anchor1', 'anchor2', 'anchor3', 'anchor5');">
	  <cfelse>
	     <a title="community / communautaires" rel="community / communautaires" id="anchor4" class="unselectedLink" href="javascript: void(0);" onclick="showProjectFilterData('community', 'anchor4', 'anchor1', 'anchor2', 'anchor3', 'anchor5');">
      </cfif>  
	          community / communautaires
	  </a> &nbsp;|&nbsp; 
	  <cfif docID eq 86>
         <a title="competitions / concours" rel="competitions / concours" id="anchor5" class="selectedLink" href="javascript: void(0);" onclick="showProjectFilterData('competitions', 'anchor5', 'anchor1', 'anchor2', 'anchor3', 'anchor4');">
	  <cfelse>
	     <a title="competitions / concours" rel="competitions / concours" id="anchor5" class="unselectedLink" href="javascript: void(0);" onclick="showProjectFilterData('competitions', 'anchor5', 'anchor1', 'anchor2', 'anchor3', 'anchor4');">
      </cfif>  
	          competitions / concours
	  </a> &nbsp;   
</div> 

<div style="margin-bottom: 20px;">
<SELECT NAME="selCategory" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Category...
	<cfoutput><OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&groupID=#groupID#">Show them all!</cfoutput>
	<cfloop query="CatDetails">
		<cfoutput>
		<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selCategory=#CatDetails.ProjectCategoryID#&groupID=#groupID#">#CatDetails.CategoryTitle#
		</cfoutput>
	</cfloop>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selStatus" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Status...
	<cfoutput>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&groupID=#groupID#">Show them all!
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selStatus=Being Planned&groupID=#groupID#" <cfif selStatus eq "Being Planned">Selected</cfif>>Being Planned</option>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selStatus=Available Now&groupID=#groupID#" <cfif selStatus eq "Available Now">Selected</cfif>>Available Now</option>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selStatus=In progress&groupID=#groupID#" <cfif selStatus eq "In progress">Selected</cfif>>In progress</option>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selStatus=All Done&groupID=#groupID#" <cfif selStatus eq "All Done">Selected</cfif>>All Done</option>
	</cfoutput>
</SELECT>
&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT NAME="selPriority" onchange="location = this.options[this.selectedIndex].value;">
	<OPTION VALUE="">Filter by Priority...
	<cfoutput>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&groupID=#groupID#">Show them all!
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selPriority=High&groupID=#groupID#" <cfif selPriority eq "High">Selected</cfif>>High</option>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selPriority=Normal&groupID=#groupID#" <cfif selPriority eq "Normal">Selected</cfif>>Normal</option>
	<OPTION VALUE="#rootPath#/index.cfm/projets/?documentID=#docID#&selPriority=Low&groupID=#groupID#" <cfif selPriority eq "Low">Selected</cfif>>Low</option>
	</cfoutput>
</SELECT>
</div>

<script type="text/javascript">
	$("document").ready(function() { 
		jQuery("#list2").jqGrid({
			url: '<cfoutput>#rootPath#</cfoutput>projectsList.cfc?method=getProjectsList&ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&selStatus=<cfoutput>#selStatus#</cfoutput>&selCategory=<cfoutput>#selCategory#</cfoutput>&selPriority=<cfoutput>#selPriority#</cfoutput>&webroot=<cfoutput>#rootPath#</cfoutput>&documentID=<cfoutput>#docID#</cfoutput>&datasource=<cfoutput>#application.configBean.getDatasource()#</cfoutput>',
			width:"auto",
			height:"auto",
			datatype: "json",
			colNames:['pID','Current Projects', 'Category','Priority','Status','Value','Paid In'],
			colModel:[
				{name:'pID',index:'ProjectID', width:55},
				{name:'Current Projects',index:'INTROTEXT', width:422},
				{name:'Category',index:'ProjectCategories.Title', width:300},
				{name:'Priority',index:'Priority', width:70},
				{name:'Status',index:'CurrentStatus', width:90, align:"right"},
				{name:'Value',index:'CreditsOffered', width:80,align:"center"},
				{name:'Paid In',index:'PaidIn', width:70, sortable:true}
			],
			rowNum:10,
			rowList:[10,20,30],
			pager: '#pager2',
			sortname: 'ProjectID',
			viewrecords: true,
			sortorder: "asc",
			caption:"Projects List"
			}); 
		});
</script>

<table id="list2"></table>
<div id="pager2"></div>
<br /><br />