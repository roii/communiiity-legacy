<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, Contacts, SugVote
WHERE suggestion.ContactID=Contacts.ContactID

<cfif session.UserIsAuthenticated EQ 'Yes'>
	AND Contacts.ContactID <> #session.UserID#
</cfif>

AND suggestion.SugID=SugVote.SugID
AND suggestion.Authorise = 'yes'
AND suggestion.Archived=0
AND suggestion.categoryID=#this_categoryID#
AND (suggestion.SugStage LIKE '%Stage 1%' OR suggestion.SugStage LIKE '%Stage 2%' OR suggestion.SugStage LIKE '%Stage 3%')	
GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
ORDER BY voteReceived
</cfquery>

<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#this_categoryID#
AND Authorise LIKE '%No%'
AND Archived = 0
GROUP BY SugID
</cfquery>

<cfquery name="AllCat_WinnerIdeas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#this_categoryID#
AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%')
GROUP BY SugID
</cfquery>
		
<cfquery name="AllCat_ReturnedIdeas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#this_categoryID#
AND Archived=1
GROUP BY SugID
</cfquery>


<cfif AllCat_ActiveIdeas.RecordCount>
	<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
<cfelse>
	<cfset ThisCatideas = "0">		
</cfif>

<cfif AllCat_InActiveIdeas.RecordCount>
	<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
</cfif>

<cfif AllCat_ActiveIdeas.Recordcount>
	<cfset ActiveList = ValueList(AllCat_ActiveIdeas.SugID, ",")>
<cfelse>
	<cfset ActiveList = 0>
</cfif>


<cfset NeedMyVoteList = ValueList(AllCat_ActiveIdeas.SugID)>
<cfif session.UserIsAuthenticated EQ 'yes'>

	<!--- HOW MANY IDEAS HAS THIS USER VOTED ON --->
	<cfquery name="IdeasAlreadyVotedFor" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT SugID
	FROM SugVote
	WHERE ContactID=#session.UserID#
	AND SugID IN (#ActiveList#)
	GROUP BY SugID
	</cfquery>
	
	<cfloop query="IdeasAlreadyVotedFor">
	
		<cftry>
		<cfset NeedMyVoteList=ListDeleteAt(NeedMyVoteList, ListFind(NeedMyVoteList, "#IdeasAlreadyVotedFor.SugID#", ","), ",")>	
		<cfcatch></cfcatch>
		</cftry>
		
	</cfloop>
	
</cfif>


