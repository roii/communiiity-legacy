<cfoutput>

<cfset total_win_idea = 0>
<cfset total_lose_idea = 0>

<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfquery name="WinningSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT sugID, suggestion, WhenSugMade, WhenSugEnded, SugStage, ContactID
FROM suggestion
WHERE WhenSugMade BETWEEN ('05/11/2006 00:00:00') AND ('06/11/2006 23:59:59')
AND (SugStage LIKE '%Stage 4%' OR SugStage LIKE '%Stage 5%')
ORDER BY WhenSugMade
</cfquery>


<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>ID</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Idea</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Submitted</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Finished</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Stage</strong></td>
</tr>

<tr>
<td colspan="5"><hr size="1" color="e2e2e2"></td>
</tr>

<cfloop query="WinningSuggestions">

<cfset this_SugID = WinningSuggestions.SugID>
<cfset this_suggestion = WinningSuggestions.suggestion>
<cfset this_WhenSugMade = WinningSuggestions.WhenSugMade>
<cfset this_WhenSugEnded = WinningSuggestions.WhenSugEnded>
<cfset this_SugStage = WinningSuggestions.SugStage>
<cfset this_Author = WinningSuggestions.ContactID>


<cfquery name="AllVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE SugID=#this_SugID#
ORDER BY WhenVoteMade
</cfquery>

<tr>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>#this_SugID#</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>#this_suggestion#</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>#DateFormat(this_WhenSugMade)# #TimeFormat(this_WhenSugMade, "h:mm tt")#</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>#DateFormat(this_WhenSugEnded)# #TimeFormat(this_WhenSugEnded, "h:mm tt")#</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>#this_SugStage#</strong></td>
</tr>

<tr>
<td colspan="5">

<cfset yesvote = 0>
<cfset novote = 0>
<cfset vote_number=0>

<cfset okYesVotes = "">
<cfset okNoVotes = "">
<cfset Winner = "">

	<table cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="4"><hr size="1" color="e2e2e2"></td>
	</tr>
	
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
		
	<tr>
	<td style="padding-right:15px;font-size:11px;font-family:Arial;">[#vote_number#]</td>
	<td style="padding-right:15px;font-size:11px;font-family:Arial;">This Vote: #this_vote#</td>
	<td style="padding-right:15px;font-size:11px;font-family:Arial;">Total Yes:#yesvote#</td>
	<td style="padding-right:15px;font-size:11px;font-family:Arial;">Total No: #novote#</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr size="1" color="e2e2e2"></td>
	</tr>
	
	<!--- If it has received the required number of YES VOTES then it a winner --->
	<cfif YesVote GTE 33>
		<cfset winner = "Yes">
		<cfset total_win_idea = total_win_idea + 1>
		<cfbreak>
	<!--- If it has received the required number of YES VOTES then it a winner --->
	<cfelseif NoVote GTE 6>
		<cfset winner = "No">
		<cfset total_lose_idea=total_lose_idea+1>
		<cfbreak>
	<cfelseif vote_number EQ AllVotes.RecordCount>
		<cfset winner = "moved">
		<cfbreak>
	</cfif>
	
	</cfloop>
	
	
	
	<!--- DELETE NON-APPLICABLE VOTES --->
	<cfquery name="DeleteBadVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SugVote
	WHERE SugID=#this_SugID#
	<cfif okYesVotes NEQ ''>AND ContactID NOT IN (#okYesVotes#)</cfif>
	<cfif okNoVotes NEQ ''>AND ContactID NOT IN (#okNoVotes#)</cfif>
	</cfquery>
	
	<!--- DELETE NON-APPLICABLE VOTE TRANSACTIONS --->
	<cfquery name="DeleteBadVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contact_transactions
	WHERE (Related_Description LIKE '%Vote%' OR Related_Description LIKE '%VoteComments%')
	AND Related_Identifier=#this_SugID#
	<cfif okYesVotes NEQ ''>AND ContactID NOT IN (#okYesVotes#)</cfif>
	<cfif okNoVotes NEQ ''>AND ContactID NOT IN (#okNoVotes#)</cfif>
	</cfquery>
	
	<cfif winner EQ 'No'>
	
		<!--- IF VOTED NO REMOVE FROM WINNERS. CHANGE TO Stage 3 AND MARK AS RETURNED --->
		<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Suggestion
		SET archived=1,
		SugStage='Stage 3'
		WHERE sugID=#this_SugID#
		</cfquery>
				
		<!--- IF VOTED NO REMOVE WINNER POINTS FOR STAGE 4 --->
		<cfquery name="DeleteBadPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM contact_transactions
		WHERE Related_Description LIKE '%IdeaStage4%'
		AND Related_Identifier=#this_SugID#
		AND ContactID = #this_Author#
		</cfquery>
	
	</cfif>
	
	<tr>
	<td colspan="4" style="padding-right:15px;font-size:12px;font-family:Arial;"><strong>#winner#</strong></td>
	</tr>
	
	</table>
	
	
</td>
</tr>

<tr>
<td colspan="5"><hr size="1" color="e2e2e2"></td>
</tr>	
	

</cfloop>


<tr>
<td colspan="5" style="padding-right:15px;font-size:12px;font-family:Arial;">Total Ideas: <strong>#WinningSuggestions.RecordCount#</strong><br><br>
Winner: <strong>#Total_Win_idea#</strong><br><br>
Loser: <strong>#Total_Lose_Idea#</strong></td>
</tr>

</table><br><br>



</cfoutput>