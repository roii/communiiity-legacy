<cfquery name="headlines" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM News
WHERE NewsCatID=#NewsCategories.NewsCatID#
AND ReleasedDate > #DateAdd('d', -30, now())#
AND Feature=1


<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>

</cfif>



ORDER BY ReleasedDate DESC
</cfquery>