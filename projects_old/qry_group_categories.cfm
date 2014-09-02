<cfquery name="CatDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ProjectCategoryID, Title AS CategoryTitle, Active, Image
FROM ProjectCategories
WHERE GroupID=#GroupID#

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
<cfelse>
	AND Active = 1
</cfif>

ORDER BY Active DESC, displayorder
</cfquery>