<cfoutput>

<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>


<!--- GET ALL PENDING --->
<cfquery name="allPending" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE SugStage LIKE '%Pending%'
AND Authorise LIKE '%No%'
AND Archived=0
ORDER BY SugID
</cfquery>




<!--- loop thru the number of suggestion available for voting --->
<cfloop query="allPending">

	
	<cfset this_sugID = allPending.sugID>
		
	<!--- GET THE IDEA DETAILS FOR TRANSACTION LOG --->
	<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion
	FROM suggestion
	WHERE SugID=#this_SugID#
	</cfquery>
	
	<cfset ExtraDescription = "<BR>Idea: #TRIM(IdeaStuff.Suggestion)#">
		
		
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
				<cfif IsNumeric("#this_contactID#")>
					<cfinclude template="../templates/act_activity_reward_payment.cfm">
				</cfif>
				
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
	
</cfloop>

<script>
alert('Finito!');
</script>

</cfoutput>
