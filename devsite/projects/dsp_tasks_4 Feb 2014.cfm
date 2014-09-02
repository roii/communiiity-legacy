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
 
<h1>
 #relatedtasktxt#
</h1> 
<cfset totaltasks = getTasks.recordcount>
</cfoutput>

<cfif totaltasks gt 0>  
<cfset filename = langFilesStr[1]["#defaultlang#"]> 
			<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#>
			 	
			
			<iframe id="iframe1" src="<cfoutput>#request.webroot#</cfoutput>/projects/display_tasks.cfm?ProjectCatIDList=<cfoutput>#ProjectCatIDList#</cfoutput>&webroot=<cfoutput>#request.webroot#</cfoutput>&fuseaction=<cfoutput>#fuseaction#</cfoutput>&fusesubaction=<cfoutput>#fusesubaction#</cfoutput>&documentID=<cfoutput>#documentID#</cfoutput>&allowTasks=<cfoutput>#allowTasks#</cfoutput>&campaignID=<cfoutput>#campaignID#</cfoutput>&filename=<cfoutput>#filename#</cfoutput>&userisauthenti=<cfoutput>#session.UserIsAuthenticated#</cfoutput>&dsn=<cfoutput>#dsn#</cfoutput>&username=<cfoutput>#request.username#</cfoutput>&password=<cfoutput>#request.password#</cfoutput>&suserid=<cfoutput>#session.userid#</cfoutput>" width="900" height="100%" frameborder="0" scrolling="no" onload="sizeFrame('iframe1');"></iframe><!--- onload='javascript:resizeIframe(this);'--->
			
	<cfif totaltasks gt 5>
	   <cfoutput>
			<a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=index&documentID=5">
				 Read More Tasks...
			</a>
	   </cfoutput>		
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
	
<script type="text/javascript">
function sizeFrame(frameId) { 
var F = document.getElementById(frameId);
if(F.contentDocument) {
F.height = F.contentDocument.documentElement.scrollHeight+830; //FF 3.0.11, Opera 9.63, and Chrome
} else {



F.height = F.contentWindow.document.body.scrollHeight+830; //IE6, IE7 and Chrome

}
//alert('Loading all the tasks....');
}

// window.onload=sizeFrame;

//-->
 </script>