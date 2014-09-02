<cfoutput>

<cfquery maxrows="25" name="WinningSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT sugID, suggestion, WhenSugMade, WhenSugEnded, SugStage
FROM suggestion
WHERE SugStage LIKE '%Stage 4%' OR SugStage LIKE '%Stage 5%'
ORDER BY WhenSugMade DESC
</cfquery>

<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>ID</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Idea</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Submitted</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Finished</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;"><strong>Stage</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center"><strong>Total Votes</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center"><strong>Yes</strong></td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center"><strong>No</strong></td>
</tr>

<tr>
<td colspan="8"><hr size="1" color="e2e2e2"></td>
</tr>

<cfloop query="WinningSuggestions">

<cfquery name="AllYesVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE SugID=#WinningSuggestions.SugID#
AND Vote > 3
ORDER BY WhenVoteMade
</cfquery>

<cfquery name="AllNoVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE SugID=#WinningSuggestions.SugID#
AND Vote < 3
ORDER BY WhenVoteMade
</cfquery>

<tr>
<td style="padding-right:15px;font-size:11px;font-family:Arial;">#WinningSuggestions.SugID#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;">#WinningSuggestions.suggestion#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;">#DateFormat(WinningSuggestions.WhenSugMade)# #TimeFormat(WinningSuggestions.WhenSugMade, "h:mm tt")#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;">#DateFormat(WinningSuggestions.WhenSugEnded)# #TimeFormat(WinningSuggestions.WhenSugEnded, "h:mm tt")#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;">#WinningSuggestions.SugStage#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center">#INT(AllYesVotes.RecordCount + AllNoVotes.RecordCount)#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center">#AllYesVotes.RecordCount#</td>
<td style="padding-right:15px;font-size:11px;font-family:Arial;" align="center">#AllNoVotes.RecordCount#</td>
</tr>

<tr>
<td colspan="8"><cfdump var="#AllYesVotes#"></td>
</tr>

<tr>
<td colspan="8"><hr size="1" color="e2e2e2"></td>
</tr>


</cfloop>

</table>

</cfoutput>