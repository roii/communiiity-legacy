<cfinclude template="../app_globals.cfm">

<cfquery name="RemoveComment" datasource="#dsn#" username="#request.username#" password="#request.password#">

DELETE FROM ProjectComments WHERE commentID = #URL.commentID#

</cfquery> 


 <cflocation url="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=index&documentID=5&projectmode=template&ProjectCategoryID=#URL.ProjectCategoryID#&ProjectID=#URL.ProjectID#&campaignID=#URL.campaignID#&maintask=0" addtoken="no">