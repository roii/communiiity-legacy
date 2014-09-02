<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Projects.*, ProjectCategories.Title as CategoryTitle,ProjectCategories.displayorder
FROM Projects, ProjectCategories
WHERE Projects.ProjectID=#projectID#
AND Projects.ProjectCategoryID=ProjectCategories.ProjectCategoryID
order by displayorder
</cfquery>

<cfquery name="ProjectComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Projects.*, ProjectComments.*
FROM Projects, ProjectComments
WHERE Projects.ProjectID=#projectID#
AND Projects.ProjectID=ProjectComments.ProjectID
order by DateAdded
</cfquery>