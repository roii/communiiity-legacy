<cfquery name="EventsReturn" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM EventCats
WHERE Fuseaction='#fuseaction#'

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>

AND Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>
	
</cfif>

ORDER BY DisplayOrder
</cfquery>
