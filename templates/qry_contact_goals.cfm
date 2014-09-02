<cfquery name="ContactGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalID
FROM ContactGoals
WHERE ContactGoals.ContactID=#session.UserID#
</cfquery>

<cfset ContactGoalList = #valuelist(ContactGoals.GoalID,  ",")#>