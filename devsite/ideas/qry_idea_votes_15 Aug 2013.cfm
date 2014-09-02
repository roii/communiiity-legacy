<cfquery datasource="#dsn#"  name="qry_idea_votes" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM SugVote
WHERE sugID = #this_sugID#
ORDER BY whenVoteMade DESC
</cfquery>