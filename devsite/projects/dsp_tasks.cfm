<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
    <cfset allowTasks = 1>
<cfelse>
    <cfset allowTasks = 0> 
</cfif> 

<cfquery name="CatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ProjectCategoryID, Title AS CategoryTitle, Active, Image
FROM ProjectCategories
WHERE GroupID=1
<cfif isdefined("url.selCategory")>
	<cfif url.selCategory neq ''>
		and ProjectCategoryID=#trim(url.selCategory)#
	</cfif> 
</cfif>

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
<cfelse>
	AND Active = 1
</cfif>

ORDER BY Active DESC, displayorder
</cfquery>

<cfoutput>
<cfquery name="getTasks" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT P.ProjectID, P.INTROTEXT, P.ProjectCategoryID,P.Title,P.CurrentStatus,P.PaymentType,P.PaidIn,p.Priority,PC.Title ProjectCategory, P.CreditsOffered, P.projectpic, P.details, P.addedby, P.location, P.project_order, P.displayProject, P.PercentComplete FROM Projects as P
  INNER JOIN ProjectCategories PC on P.ProjectCategoryID = PC.ProjectCategoryID
  WHERE related_campaign = #campaignID# and displayProject = 1
  ORDER BY ProjectID DESC
</cfquery>

<cfset totaltasks = getTasks.recordcount>
</cfoutput>

<cfif session.UserIsAuthenticated EQ 'Yes'>
		 <cfoutput> 
		    <div style="width: 100%; float:left;">
			    <div style="width: 84%; float:left;">
					<h1>
						#relatedtasktxt#
					</h1> 
				</div>
				<div style="width: 16%; float:right;">
				       <input type="submit" value="#AddNewTask#" class="buttonControl" style="cursor: pointer; color: white; text-decoration:none; text-transform:uppercase; font-size: 12pt; font-weight: bold;" name="go" onclick="javascript: window.location = '#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=addTask&pid=#campaign_id#&documentID=#documentID#';">
				</div>	   
			</div>
			<br /><br />
		 </cfoutput>  	
</cfif>
   
<cfset filename = langFilesStr[1]["#defaultlang#"]> 
			<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#> 
  
  <cfif IsDefined("session.userid") and session.userid neq ''>
        <cfset suserid = #session.userid#>
  <cfelse>
        <cfset suserid = 0>
  </cfif>		
			
			<iframe id="iframe1" width="100%" height="100%" frameborder="0" scrolling="auto" onload="sizeFrame('iframe1');" src="<cfoutput>#request.webroot#</cfoutput>/projects/display_tasks.cfm?ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&filename=<cfoutput>#filename#</cfoutput>&userisauthenti=<cfoutput>#session.UserIsAuthenticated#</cfoutput>&dsn=<cfoutput>#dsn#</cfoutput>&username=<cfoutput>#request.username#</cfoutput>&password=<cfoutput>#request.password#</cfoutput>&suserid=<cfoutput>#suserid#</cfoutput>&UserType=<cfoutput>#session.UserType#</cfoutput>"></iframe> 
			
	  
	
<script type="text/javascript">
function sizeFrame(frameId) { 
var F = document.getElementById(frameId);
if(F.contentDocument) {
F.height = F.contentDocument.documentElement.scrollHeight+830; //FF 3.0.11, Opera 9.63, and Chrome
} else {



F.height = F.contentWindow.document.body.scrollHeight+700; //IE6, IE7 and Chrome

}
//alert('Loading all the tasks....');
}

// window.onload=sizeFrame;

//-->
 </script>