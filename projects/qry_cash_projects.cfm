<cfquery name="CatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ProjectCategories.Title as CATEGORYTITLE,* 
FROM ProjectCategories

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
<cfelse>
	WHERE Active = 1
</cfif>

ORDER BY Active DESC,displayorder
</cfquery>