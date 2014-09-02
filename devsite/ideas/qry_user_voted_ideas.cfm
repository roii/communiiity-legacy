<!--- SET ALL IDEAS THIS USER HAS VOTED ON --->
<cfquery datasource="#dsn#"  name="qry_user_voted_ideas" username="#request.username#" password="#request.password#">
SELECT sugID
FROM SugVote
WHERE ContactID=#session.UserID#
</cfquery>

<cfset votedList = valueList(qry_user_voted_ideas.SugID)>