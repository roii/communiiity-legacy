<cfquery name="basenav" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SectionID, Fuseaction, MenuTitle
FROM Sections
WHERE TopMenu=1

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (ContactTypeView LIKE '#session.User_ContactTypeID#' OR ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#')
	</cfif>

<cfelse>
	AND PublicView = 1
</cfif>

ORDER BY MainMenuOrder
</cfquery>