<cfquery name="AllSuggestions" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, Contacts, SugVote
WHERE suggestion.ContactID=Contacts.ContactID
AND suggestion.SugID=SugVote.SugID
AND suggestion.Authorise = 'yes'
AND suggestion.Archived=0
AND suggestion.categoryID=#currentcategory#	

<cfif session.srch_stage NEQ 'ALL'>

	AND suggestion.SugStage LIKE '%#session.srch_stage#%'				
	
<cfelse>
	AND (suggestion.SugStage LIKE '%Stage 1%' OR suggestion.SugStage LIKE '%Stage 2%' OR suggestion.SugStage LIKE '%Stage 3%')	
</cfif>

<cfif session.srch_keywords NEQ ''>
	AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
	OR suggestion.Details LIKE '%#session.srch_keywords#%' 
	OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
	OR contacts.lastName LIKE '%#session.srch_keywords#%')	
</cfif>

GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
ORDER BY voteReceived DESC
</cfquery>