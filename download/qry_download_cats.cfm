<cfquery name="DownloadCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM LibraryCats

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>

WHERE Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>
	
</cfif>

ORDER BY DisplayOrder
</cfquery>