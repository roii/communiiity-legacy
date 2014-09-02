<cfoutput>

<cfset total_win_idea = 0>
<cfset total_lose_idea = 0>

<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<!--- <cfquery name="WinningSuggestions" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT sugID, suggestion, WhenSugMade, WhenSugEnded, SugStage, ContactID
FROM suggestion
WHERE WhenSugMade BETWEEN ('05/13/2006 00:00:00') AND ('06/13/2006 23:59:59')
AND (SugStage LIKE '%Stage 3%' OR SugStage LIKE '%Stage 4%')
ORDER BY WhenSugMade
</cfquery> --->



<cfloop list="#IdeaList#" delimiters="," index="Listitem">

<cfset this_SugID = Listitem>


<cfquery name="WinningSuggestions" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT sugID, suggestion, WhenSugMade, WhenSugEnded, SugStage, ContactID
FROM suggestion
WHERE SugID=#this_SugID#
</cfquery>


<cfset this_suggestion = WinningSuggestions.suggestion>
<cfset this_WhenSugMade = WinningSuggestions.WhenSugMade>
<cfset this_WhenSugEnded = WinningSuggestions.WhenSugEnded>
<cfset this_SugStage = WinningSuggestions.SugStage>
<cfset this_Author = WinningSuggestions.ContactID>


<cfquery name="AllVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM SugVote
WHERE SugID=#this_SugID#
ORDER BY WhenVoteMade
</cfquery>


<cfset yesvote = 0>
<cfset novote = 0>
<cfset vote_number=0>

<cfset okYesVotes = "">
<cfset okNoVotes = "">
<cfset Winner = "">

	
<cfloop query="AllVotes">

<cfset this_vote = AllVotes.Vote>
<cfset vote_number = vote_number + 1>
<cfset this_contact = AllVotes.ContactID>

<cfif this_vote GT 1>
	<cfset yesvote = yesvote + 1>
	<cfset okYesVotes = ListAppend(okYesVotes, this_contact, ",")>
<cfelse>						
	<cfset novote = novote + 1>
	<cfset okNoVotes = ListAppend(okNoVotes, this_contact, ",")>
</cfif>
	

<!--- If it has received the required number of YES VOTES then it a winner --->
<cfif YesVote GTE 33>
	<cfset winner = "Yes">
	<cfset total_win_idea = total_win_idea + 1>
	<cfbreak>
	
<!--- If it has received the required number of NO VOTES then it a returned --->
<cfelseif NoVote GTE 7>
	<cfset winner = "No">
	<cfset total_lose_idea = total_lose_idea + 1>
	<cfbreak>
	
<cfelseif vote_number EQ AllVotes.RecordCount>
	<cfset winner = "moved">
	<cfbreak>
	
</cfif>

</cfloop>


<!--- DELETE NON-APPLICABLE VOTES --->
<cfquery name="DeleteBadVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
DELETE
FROM SugVote
WHERE SugID=#this_SugID#
<cfif okYesVotes NEQ ''>AND ContactID NOT IN (#okYesVotes#)</cfif>
<cfif okNoVotes NEQ ''>AND ContactID NOT IN (#okNoVotes#)</cfif>
</cfquery>

<!--- DELETE NON-APPLICABLE VOTE TRANSACTIONS --->
<cfquery name="DeleteBadTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
DELETE
FROM contact_transactions
WHERE (Related_Description LIKE '%Vote%' OR Related_Description LIKE '%VoteComments%')
AND Related_Identifier=#this_SugID#
<cfif okYesVotes NEQ ''>AND ContactID NOT IN (#okYesVotes#)</cfif>
<cfif okNoVotes NEQ ''>AND ContactID NOT IN (#okNoVotes#)</cfif>
</cfquery>

<cfif winner CONTAINS 'No'>

	<!--- IF VOTED NO REMOVE FROM WINNERS. CHANGE TO Stage 3 AND MARK AS RETURNED --->
	<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	UPDATE Suggestion
	SET archived=1,
	SugStage='Stage 3'
	WHERE sugID=#this_SugID#
	</cfquery>
	

</cfif>
	

</cfloop>


</cfoutput>

<cflocation url="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=78">