<cfoutput>


<cfquery name="Watchlist" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, suggestion.reward, count(SugVote.vote) as voteReceived
FROM SugWatchlist, suggestion, Contacts, SugVote
WHERE SugWatchlist.ContactID=#session.UserID#
AND SugWatchlist.SugID=suggestion.SugID
AND suggestion.ContactID=Contacts.ContactID
AND suggestion.SugID=SugVote.SugID
GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, suggestion.reward
ORDER BY WhenSugMade DESC
</cfquery>


<table width="100%" cellspacing="1" cellspacing="1">

<tr>
<td>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height="35" class="normal">
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;padding-left:5px;">The suggestions/ideas</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">By</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Stage</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Reward</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Votes</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">%<br>Yes</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Your<br>Vote</td>
	<td></td>
	</tr>
	
	<cfif IsDefined("Watchlist")>
					
		
		<!--- loop to display the suggestion --->
		<cfloop query="Watchlist">
			
		<!--- <cfif (session.srch_period NEQ 'ALL') AND (DateCompare(CatSug.WhenSugMade, SearchStart) EQ 1)> --->
			
			<cfset this_sugID = Watchlist.SugID>
			<cfset this_ContactID = Watchlist.ContactID>
			<cfset this_stage = Watchlist.SugStage>
			<cfset this_reward = Watchlist.reward>
			<cfset this_categoryID = Watchlist.categoryID>
			
			<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
			SELECT FirstName, ScreenName
			FROM Contacts
			WHERE ContactID=#this_ContactID#
			</cfquery>
		
		
			<!--- set the background color of the row --->				
			<cfset bgColor="ffffff">
			<cfset vote = 0 >
			
			<cfif session.UserIsAuthenticated EQ 'yes'>
			
				
				
					<!--- check if user has voted for this current suggestion --->
					<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
					SELECT *
					FROM SugVote
					WHERE sugID = #this_sugID#
					AND ContactID=#session.UserID#
					</cfquery>
			
					<!--- user has vote if isUserVote recordCount > 0 or the suggestion was made by the user --->
					<cfif isUserVote.recordCount OR (this_ContactID NEQ '' AND this_ContactID EQ session.UserID)>
				
						<cfset bgColor="ffffff">
						<cfset vote = 1>
					
					</cfif>
				
				
			</cfif>
						
			<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID = #this_sugID#
			</cfquery>
			
			<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID = #this_sugID#
			AND vote > 3
			</cfquery>
			
			<cfif AllVotes.RecordCount>
			
				<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
			
			<cfelse>
				
				<cfset PercentYes = 0>
				
			</cfif>
			
			<tr bgcolor="#bgColor#" height="23">
			<td style="padding-left:5px;"><cfif len(suggestion) GT 50><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=78&ideafunl_mode=WinningDetails&sugID=#sugID#&currentcategory=#this_categoryID#">#mid(suggestion,1,50)#</a> <a title="View Details" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=78&ideafunl_mode=WinningDetails&sugID=#sugID#&currentcategory=#this_categoryID#" style="color:###TRIM(AllSettings.BoxColour)#;">details..</a><cfelse><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=78&ideafunl_mode=WinningDetails&sugID=#sugID#&currentcategory=#this_categoryID#">#suggestion#</a></cfif></td>			
			<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><cfif TRIM(ContactStuff.ScreenName) NEQ ''>#TRIM(ContactStuff.ScreenName)#<cfelse>#TRIM(ContactStuff.FirstName)#</cfif></a></td>	
			<td align="center"><cfif this_stage NEQ 'Stage 4' AND this_stage NEQ 'Stage 5'>#this_stage#<cfelseif this_stage EQ 'Stage 4'>Doing<cfelse>Done</cfif></td>	
			<td align="center">#this_reward#</td>				
			<td align="center">#AllVotes.RecordCount#</td>
			<td align="center">#INT(PercentYes)#%</td>			
			<td align="center"><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>NO<cfelse>YES</cfif><cfelse><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID NEQ session.userID>&ndash;<cfelseif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>Your Idea!<cfelse>&ndash;</cfif></cfif></td>
			<td align="right"><a href="#request.webroot#/ideas/act_watchlist_remove.cfm?SugID=#sugID#&fuseaction=#fuseaction#&ideafunl_mode=#ideafunl_mode#&fusesubaction=#fusesubaction#&documentID=#documentID#&currentcategory=#this_categoryID#" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>Remove</strong></a></td>	
			</tr>				
			
			
			<tr>
			<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
			
			</cfloop>
			
			<tr>
			<td colspan="8"><br></td>
			</tr>	
		
		</cfif>
		
		
		</table>

</td>
</tr>


</table>
		
</cfoutput>
		