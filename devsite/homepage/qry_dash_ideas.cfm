<cfquery name="topideas" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
    SELECT top 3 suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, 
	suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, 
	suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
	FROM suggestion, Contacts, SugVote
	WHERE suggestion.ContactID=Contacts.ContactID
	AND suggestion.SugID=SugVote.SugID
	AND suggestion.Authorise LIKE '%yes%'
	AND suggestion.Archived=0
	GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, 
	suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
	ORDER BY voteReceived desc
</cfquery>