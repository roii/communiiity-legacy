<cfquery name="qry_ideas_pond" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, Contacts, SugVote
WHERE suggestion.ContactID=Contacts.ContactID
AND suggestion.SugID=SugVote.SugID
AND suggestion.categoryID=#qry_current_topic.categoryID#

<cfif IsDefined("returnIdeas") AND returnIdeas NEQ ''>
	AND suggestion.SugID IN (#returnideas#)
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.IdeaFunL_hideIdeas EQ 'Yes' AND votedList NEQ ''>
		AND suggestion.SugID NOT IN (#votedList#)
	</cfif>	
<cfelse>
	AND suggestion.Authorise = 'yes'
	AND suggestion.Archived=0
	<cfif session.srch_stage NEQ 'ALL'>
		AND suggestion.SugStage LIKE '%#session.srch_stage#%'	
	<cfelse>
		AND (suggestion.SugStage LIKE '%Stage 1%' OR suggestion.SugStage LIKE '%Stage 2%' OR suggestion.SugStage LIKE '%Stage 3%')	
	</cfif>	
	<cfif session.srch_keywords NEQ ''>
		AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
		OR suggestion.Details LIKE '%#session.srch_keywords#%' 
		OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
		OR contacts.lastName LIKE '%#session.srch_keywords#%' 
		OR contacts.ScreenName LIKE '%#session.srch_keywords#%')	
	</cfif>	
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.IdeaFunL_hideIdeas EQ 'Yes' AND votedList NEQ ''>
		AND suggestion.SugID NOT IN (#votedList#)
	</cfif>	
</cfif>

GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
ORDER BY voteReceived DESC
</cfquery>


<cfif cgi.remote_host EQ '203.173.160.158'>

<cfoutput><cfdump var="#qry_ideas_pond#"></cfoutput>

</cfif>