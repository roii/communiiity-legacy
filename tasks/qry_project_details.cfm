<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">   
SELECT P.*, PC.Title as CategoryTitle,PC.displayorder
FROM Projects as P INNER JOIN taskCategoryRelation as TCR ON P.ProjectID = TCR.taskID INNER JOIN ProjectCategories as PC ON TCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.ProjectID = #projectID# 
order by displayorder
</cfquery>

<cfquery name="ProjectComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Projects.*, ProjectComments.*
FROM Projects, ProjectComments
WHERE Projects.ProjectID=#projectID#
AND Projects.ProjectID=ProjectComments.ProjectID
order by DateAdded
</cfquery>