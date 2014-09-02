<cfoutput>

<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfif form.unauthorised EQ 'yes'>

	<!--- loop thru the number of suggestion available for voting --->
	<cfloop index="loopcount" from="1" to="3">
	
	<cfif IsDefined("form.sugID#loopcount#")>
	
		<cfset this_sugID = evaluate("form.sugID" & loopcount)>
		
		<!--- GET THE IDEA DETAILS FOR TRANSACTION LOG --->
		<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT suggestion
		FROM suggestion
		WHERE SugID=#this_SugID#
		</cfquery>
		
		<cfset ExtraDescription = "<BR>Idea: #TRIM(IdeaStuff.Suggestion)#">
			
		<cfif IsDefined("form.rate#loopcount#") AND evaluate("form.rate" & loopcount) GT 0>
	
	
		<!--- CHECK THEY HAVEN'T VOTED ALREADY --->
		<cfquery name="CheckVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT vote
		FROM SugVote
		WHERE sugID=#this_sugID#
		AND ContactID=#Session.UserID#
		</cfquery>
		
		<cfif CheckVote.RecordCount>
		
		<cfelse>
	
	
			<cfquery name="updVoteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SugVote(sugID, ContactID, vote, whenVoteMade, comments)
			VALUES(#this_sugID#, #Session.UserID#, #evaluate("form.rate" & loopcount)#, #createODBCDateTime(localDateTime)#, '#evaluate("form.comments" & loopcount)#')	
			</cfquery>
		
			<!--- PROCESS REWARDS --->
			<cfset this_activity = 13>
			<cfset this_contactID = session.UserID>
			<cfset this_relatedDescription = "Vote">
			<cfset this_relatedID = "#this_sugID#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
			<!--- IF THEY GAVE FEEDBACK GIVE THEM MORE REWARDS --->
			<cfif IsDefined("form.comments#loopcount#") AND evaluate("form.comments" & loopcount) NEQ ''>
		
				<!--- PROCESS REWARDS --->
				<cfset this_activity = 14>
				<cfset this_contactID = session.UserID>
				<cfset this_relatedDescription = "VoteComments">
				<cfset this_relatedID = "#this_sugID#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
			</cfif>
		
			<!--- get the suggestion status --->
			<cfquery name="SuggestionStatus" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Authorise
			FROM Suggestion
			WHERE sugID=#this_sugID#
			</cfquery>
		
		
		
			<!--- check if this is an un-authorised suggestion --->
			<cfif SuggestionStatus.Authorise CONTAINS 'No' OR SuggestionStatus.Authorise CONTAINS 'no'>
		
		
				<!--- get the total votes for this suggestion --->
				<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID=#this_sugID#
				</cfquery>
				
				
				<!--- check if this is the third vote for it --->
				<cfif TotalVotes.recordcount GTE IdeaSettings.Total_Pending>
				
					<!--- If it is, get the vote average --->
					<cfset voteaverage = 0>
					
					<cfloop query="TotalVotes">
						<cfset voteaverage = (voteaverage + TotalVotes.vote)>
					</cfloop>
					
					<cfset voteaverage = (voteaverage/3)>
					
					<!--- if the vote average is YES move to Stage 1 --->
					<cfif voteaverage GTE 3>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET Authorise='Yes',
						SugStage = 'Stage 1'
						WHERE sugID=#this_sugID#
						</cfquery>
						
						<!--- GET IDEA AND USER DETALS --->
						<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
						FROM Suggestion, Contacts
						WHERE Suggestion.SugID=#this_SugID#
						AND Suggestion.ContactID=Contacts.ContactID
						</cfquery>
						
						
						<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
						<cfset this_activity = 15>
						<cfset this_contactID = IdeaStuff.ContactID>
						<cfset this_relatedDescription = "IdeaStage1">
						<cfset this_relatedID = "#this_sugID#">
						<cfinclude template="../templates/act_activity_reward_payment.cfm">
						
						
						<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT Points
						FROM Activity
						WHERE ActivityID=15
						</cfquery>
						
						<cfinclude template="act_email_stage1_approve.cfm">
						
					
					<!--- if the vote average is NO dump it --->
					<cfelse>
					
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1
						WHERE sugID=#this_sugID#
						</cfquery>	
						
						<!--- GET IDEA AND USER DETALS --->
						<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
						FROM Suggestion, Contacts
						WHERE Suggestion.SugID=#this_SugID#
						AND Suggestion.ContactID=Contacts.ContactID
						</cfquery>
						
						<cfinclude template="act_email_stage1_decline.cfm">
					
					</cfif>
					
				
				</cfif>
		
		
			</cfif>
		
		</cfif>
		
	</cfif>
	
			
	</cfif>
	</cfloop>

				
</cfif>



<cfset session.CriticalVotes = 1>


<script>
alert('Thanks for voting and giving feedback.\nYou will now be connected to the Voting Area.');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75";
</script>


</cfoutput>
