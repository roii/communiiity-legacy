<cfoutput>

<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>


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

	
		<cfquery name="updVoteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO SugVote(sugID, ContactID, vote, comments, whenVoteMade)
		VALUES(#this_sugID#, #Session.UserID#, #evaluate("form.rate" & loopcount)#, '#Replace("#evaluate("form.comments" & loopcount)#", "'", "&##39", "ALL")#', #createODBCDateTime(localDateTime)#)	
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
		<cfquery name="SuggestionStage" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SugStage
		FROM Suggestion
		WHERE sugID=#this_sugID#
		</cfquery>
			
			
			
		<!--- check if this is a Stage 1 suggestion --->
		<cfif SuggestionStage.SugStage CONTAINS 'Stage 1'>
			
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID=#this_sugID#
			</cfquery>
			
			
			<!--- check if this is the last required vote for it --->
			<cfif TotalVotes.recordcount GTE IdeaSettings.Total_Stage_1>
			
				<!--- If it is, get the number of YES votes --->
				<cfset YesVotes = 0>
				
				<cfloop query="TotalVotes">
					<cfif TotalVotes.vote GT 1>
						<cfset YesVotes = YesVotes+1>
					</cfif>
				</cfloop>
			
				
				
				<!--- If it has received the required number of YES VOTES then move to Stage 2 --->
				<cfif YesVotes GTE IdeaSettings.Required_Stage_1>
					
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET SugStage = 'Stage 2'
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					
					<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
					<cfset this_activity = 16>
					<cfset this_contactID = IdeaStuff.ContactID>
					<cfset this_relatedDescription = "IdeaStage2">
					<cfset this_relatedID = "#this_sugID#">
					<cfinclude template="../templates/act_activity_reward_payment.cfm">
					
					
					<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Points
					FROM Activity
					WHERE ActivityID=16
					</cfquery>
					
					<cfinclude template="act_email_stage2_approve.cfm">
				
				
				
				<!--- if the vote average is NO dump it --->
				<cfelse>
				
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET archived=1,
					WhenSugEnded=#createdatetime(localdatetime)#
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					<cfinclude template="act_email_stage2_decline.cfm">
				
				</cfif>
				
			
			</cfif>
			
			
		
			
			
			
			
			
		<!--- check if this is a Stage 2 suggestion --->
		<cfelseif SuggestionStage.SugStage CONTAINS 'Stage 2'>
			
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID=#this_sugID#
			</cfquery>
			
			
			<!--- check if this is the last required vote for it --->
			<cfif TotalVotes.recordcount GTE IdeaSettings.Total_Stage_2>
			
				<!--- If it is, get the number of YES votes --->
				<cfset YesVotes = 0>
				
				<cfloop query="TotalVotes">
					<cfif TotalVotes.vote GT 1>
						<cfset YesVotes = YesVotes+1>
					</cfif>
				</cfloop>
			
				
				
				<!--- If it has received the required number of YES VOTES then move to Stage 3 --->
				<cfif YesVotes GTE IdeaSettings.Required_Stage_2>
				
					
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET SugStage = 'Stage 3'
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					
					<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
					<cfset this_activity = 17>
					<cfset this_contactID = IdeaStuff.ContactID>
					<cfset this_relatedDescription = "IdeaStage3">
					<cfset this_relatedID = "#this_sugID#">
					<cfinclude template="../templates/act_activity_reward_payment.cfm">
					
					
					<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Points
					FROM Activity
					WHERE ActivityID=17
					</cfquery>
					
					<cfinclude template="act_email_stage3_approve.cfm">
				
				
				
				<!--- if the vote average is NO dump it --->
				<cfelse>
				
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET archived=1,
					WhenSugEnded=#createdatetime(localdatetime)#
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					<cfinclude template="act_email_stage3_decline.cfm">
				
				</cfif>
				
			
			</cfif>
			
		
			
			
		
			
		<!--- check if this is a Stage 3 suggestion --->
		<cfelseif SuggestionStage.SugStage CONTAINS 'Stage 3'>
			
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID=#this_sugID#
			</cfquery>
			
			
			<!--- check if this is the last required vote for it --->
			<cfif TotalVotes.recordcount GTE IdeaSettings.Total_Stage_3>
			
				<!--- If it is, get the number of YES votes --->
				<cfset YesVotes = 0>
				
				<cfloop query="TotalVotes">
					<cfif TotalVotes.vote GT 1>
						<cfset YesVotes = YesVotes+1>
					</cfif>
				</cfloop>
			
				
				
				<!--- If it has received the required number of YES VOTES then move to Stage 3 --->
				<cfif YesVotes GTE IdeaSettings.Required_Stage_3>
				
					
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET SugStage = 'Stage 4',
					WhenSugEnded=#createdatetime(localdatetime)#
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					
					<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
					<cfset this_activity = 18>
					<cfset this_contactID = IdeaStuff.ContactID>
					<cfset this_relatedDescription = "IdeaStage4">
					<cfset this_relatedID = "#this_sugID#">
					<cfinclude template="../templates/act_activity_reward_payment.cfm">
					
					
					<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Points
					FROM Activity
					WHERE ActivityID=18
					</cfquery>
					
					<cfinclude template="act_email_stage4_approve.cfm">
				
				
				
				<!--- if the vote average is NO dump it --->
				<cfelse>
				
					<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Suggestion
					SET archived=1,
					WhenSugEnded=#createdatetime(localdatetime)#
					WHERE sugID=#this_sugID#
					</cfquery>	
					
					<!--- GET IDEA AND USER DETALS --->
					<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT Suggestion.ContactID, Suggestion.Suggestion, Contacts.FirstName, Contacts.EmailAddress
					FROM Suggestion, Contacts
					WHERE Suggestion.SugID=#this_sugID#
					AND Suggestion.ContactID=Contacts.ContactID
					</cfquery>
					
					<cfinclude template="act_email_stage4_decline.cfm">
				
				</cfif>
				
			
			</cfif>
			
		
		</cfif>
		
		
	</cfif>

		
</cfif>
</cfloop>



<cfset session.CriticalVotes = 1>


<script>
alert('Thanks for voting and giving feedback.\nYou will now be connected to the Voting Area.');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75";
</script>


</cfoutput>
