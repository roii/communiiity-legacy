<cfquery name="EventDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM Events
WHERE EventCatID=#EventsReturn.EventCatID#
AND EndDate > #Now()#

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>
	
</cfif>

ORDER BY Startdate
</cfquery>