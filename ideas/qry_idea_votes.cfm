<cfquery datasource="#dsn#"  name="qry_idea_votes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #this_sugID#
ORDER BY whenVoteMade DESC
</cfquery>