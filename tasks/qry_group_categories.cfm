<cfquery name="CatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ProjectCategoryID, Title AS CategoryTitle, Active, Image
FROM ProjectCategories
WHERE GroupID=#GroupID#
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