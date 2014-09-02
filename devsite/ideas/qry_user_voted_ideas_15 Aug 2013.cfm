<!--- SET ALL IDEAS THIS USER HAS VOTED ON --->
<cfquery datasource="#dsn#"  name="qry_user_voted_ideas" username="mykidsbiznew" password="u+67eNfJ">
SELECT sugID
FROM SugVote
WHERE ContactID=#session.UserID#
</cfquery>

<cfset votedList = valueList(qry_user_voted_ideas.SugID)>