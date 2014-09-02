<cfquery name="ProjectDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT Projects.*, ProjectCategories.Title as CategoryTitle,ProjectCategories.displayorder
FROM Projects, ProjectCategories
WHERE Projects.ProjectID=#projectID#
AND Projects.ProjectCategoryID=ProjectCategories.ProjectCategoryID
order by displayorder
</cfquery>