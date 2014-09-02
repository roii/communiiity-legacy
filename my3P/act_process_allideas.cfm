<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM IdeaFunl_Settings
</cfquery>


<!--- GET ALL IDEAS --->
<cfquery name="qry_ideas_pond" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT suggestion.sugID, suggestion.authorise, suggestion.SugStage, suggestion.ContactID, SugCategory.SponsorID
FROM suggestion, SugCategory
WHERE suggestion.Archived=0
AND suggestion.CategoryID=SugCategory.CategoryID
ORDER BY suggestion.SugStage, suggestion.sugID
</cfquery>

<cfloop query="qry_ideas_pond">

<cfset this_SugID = qry_ideas_pond.SugID>
<cfset this_authorise = qry_ideas_pond.authorise>
<cfset this_SugStage = qry_ideas_pond.SugStage>
<cfset this_ContactID = qry_ideas_pond.ContactID>

<cfif IsNumeric("#qry_ideas_pond.SponsorID#")>
	<cfset this_sponsorID = qry_ideas_pond.SponsorID>
<cfelse>
	<cfset this_sponsorID = 1>
</cfif>

<!--- GET ALL VOTES --->
<cfquery name="qry_votes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM SugVote
WHERE SugID=#this_SugID#
</cfquery>

<!--- check if this is a Stage 1 suggestion --->
<cfif this_SugStage CONTAINS 'Pending'>
	
	<!--- get the total votes for this suggestion --->
	<cfquery name="TotalVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT *
	FROM SugVote
	WHERE sugID=#this_SugID#
	</cfquery>
	
	<!--- Get the number of YES and NO votes --->
	<cfset YesVotes = 0>
	<cfset NoVotes = 0>
	
	<cfloop query="TotalVotes">
		<cfif TotalVotes.vote GT 1>
			<cfset YesVotes = YesVotes + 1>
		<cfelse>						
			<cfset NoVotes = NoVotes + 1>
		</cfif>
	</cfloop>
	
	<!--- If it has received the required number of YES VOTES then move to Stage 2 --->
	<!--- if the vote average is YES move to Stage 1 --->
	<cfif YesVotes GTE IdeaSettings.Required_Pending>
		
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET Authorise='Yes',
		SugStage = 'Stage 1'
		WHERE sugID=#this_sugID#
		</cfquery>						
		
		<!--- GET IDEA AND USER DETALS --->
		<cfquery name="IdeaStuff" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT suggestion.suggestion, SugCategory.SponsorID, Contacts.ContactID, Contacts.FirstName, Contacts.EmailAddress
		FROM suggestion, SugCategory, Contacts
		WHERE suggestion.SugID=#this_SugID#
		AND suggestion.CategoryID=SugCategory.CategoryID
		AND Suggestion.ContactID=Contacts.ContactID
		</cfquery>						
		
		<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
		<cfset this_activity = 15>
		<cfset this_relatedDescription = "IdeaStage1">
		<cfset this_relatedID = "#this_sugID#">
		<cfinclude template="templates/act_activity_reward_payment.cfm">					
		
		<cfquery name="RewardDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT Points
		FROM Activity
		WHERE ActivityID=15
		</cfquery>
		
		<!--- <cfinclude template="act_email_stage1_approve.cfm"> --->						
	
	<!--- if the vote average is NO dump it --->
	<cfelseif NoVotes GTE IdeaSettings.Required_Pending>>
	
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET archived=1
		WHERE sugID=#this_sugID#
		</cfquery>	
		
		<!--- GET IDEA AND USER DETALS --->
		<cfquery name="IdeaStuff" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT suggestion.suggestion, SugCategory.SponsorID, Contacts.ContactID, Contacts.FirstName, Contacts.EmailAddress
		FROM suggestion, SugCategory, Contacts
		WHERE suggestion.SugID=#this_SugID#
		AND suggestion.CategoryID=SugCategory.CategoryID
		AND Suggestion.ContactID=Contacts.ContactID
		</cfquery>
		
		<!--- <cfinclude template="act_email_stage1_decline.cfm"> --->
	
	</cfif>		
	
	
<!--- check if this is a Stage 1 suggestion --->
<cfelseif this_SugStage CONTAINS 'Stage 1'>
	
	<!--- get the total votes for this suggestion --->
	<cfquery name="TotalVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT *
	FROM SugVote
	WHERE sugID=#this_SugID#
	</cfquery>
	
	<!--- Get the number of YES and NO votes --->
	<cfset YesVotes = 0>
	<cfset NoVotes = 0>
	
	<cfloop query="TotalVotes">
		<cfif TotalVotes.vote GT 1>
			<cfset YesVotes = YesVotes + 1>
		<cfelse>						
			<cfset NoVotes = NoVotes + 1>
		</cfif>
	</cfloop>
	
	<!--- If it has received the required number of YES VOTES then move to Stage 2 --->
	<cfif YesVotes GTE IdeaSettings.Required_Stage_1>
		
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET SugStage='Stage 2'
		WHERE sugID=#this_SugID#
		</cfquery>					
		
		<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_relatedDescription = "IdeaStage2">
		<cfset this_relatedID = "#this_SugID#">
		<cfinclude template="templates/act_activity_reward_payment.cfm">					
		
		<cfquery name="RewardDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT Points
		FROM Activity
		WHERE ActivityID=16
		</cfquery>
		
		<!--- <cfinclude template="act_email_stage2_approve.cfm"> --->
		
	<cfelseif NoVotes GTE IdeaSettings.Required_Stage_1>
	
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET archived=1,
		WhenSugEnded=#createODBCdatetime(localdatetime)#
		WHERE sugID=#this_SugID#
		</cfquery>
		
		<!--- <cfinclude template="act_email_stage2_decline.cfm"> --->
		
	</cfif>
		
<!--- check if this is a Stage 2 suggestion --->
<cfelseif this_SugStage CONTAINS 'Stage 2'>
		
	<!--- get the total votes for this suggestion --->
	<cfquery name="TotalVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT *
	FROM SugVote
	WHERE sugID=#this_SugID#
	</cfquery>
	
	<!--- Get the number of YES and NO votes --->
	<cfset YesVotes = 0>
	<cfset NoVotes = 0>
	
	<cfloop query="TotalVotes">
		<cfif TotalVotes.vote GT 1>
			<cfset YesVotes = YesVotes + 1>
		<cfelse>						
			<cfset NoVotes = NoVotes + 1>
		</cfif>
	</cfloop>
	
	<!--- If it has received the required number of YES VOTES then move to Stage 3 --->
	<cfif YesVotes GTE IdeaSettings.Required_Stage_2>				
		
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET SugStage='Stage 3'
		WHERE sugID=#this_SugID#
		</cfquery>					
		
		<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
		<cfset this_activity = 17>
		<cfset this_relatedDescription = "IdeaStage3">
		<cfset this_relatedID = "#this_SugID#">
		<cfinclude template="templates/act_activity_reward_payment.cfm">					
		
		<cfquery name="RewardDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT Points
		FROM Activity
		WHERE ActivityID=17
		</cfquery>
							
		<!--- <cfinclude template="act_email_stage3_approve.cfm">	 --->			
	
	<cfelseif NoVotes GTE IdeaSettings.Required_Stage_2>
	
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET archived=1,
		WhenSugEnded=#createODBCdatetime(localdatetime)#
		WHERE sugID=#this_SugID#
		</cfquery>	
			
		<!--- <cfinclude template="act_email_stage3_decline.cfm"> --->
	
	</cfif>

<!--- check if this is a Stage 3 suggestion --->
<cfelseif this_SugStage CONTAINS 'Stage 3'>
	
	<!--- get the total votes for this suggestion --->
	<cfquery name="TotalVotes" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT *
	FROM SugVote
	WHERE sugID=#this_SugID#
	</cfquery>
	
	<!--- Get the number of YES and NO votes --->
	<cfset YesVotes = 0>
	<cfset NoVotes = 0>
	
	<cfloop query="TotalVotes">
		<cfif TotalVotes.vote GT 1>
			<cfset YesVotes = YesVotes + 1>
		<cfelse>						
			<cfset NoVotes = NoVotes + 1>
		</cfif>
	</cfloop>
	
	<!--- If it has received the required number of YES VOTES then move to Stage 3 --->
	<cfif YesVotes GTE IdeaSettings.Required_Stage_3>
		
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET SugStage='Stage 4',
		WhenSugEnded=#createODBCdatetime(localdatetime)#
		WHERE sugID=#this_SugID#
		</cfquery>					
		
		<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
		<cfset this_activity = 18>
		<cfset this_relatedDescription = "IdeaStage4">
		<cfset this_relatedID = "#this_SugID#">
		<cfinclude template="templates/act_activity_reward_payment.cfm">
		
		<cfquery name="RewardDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT Points
		FROM Activity
		WHERE ActivityID=18
		</cfquery>
		
		<!--- <cfinclude template="act_email_stage4_approve.cfm"> --->				
		
	<!--- if the vote average is NO dump it --->
	<cfelseif NoVotes GTE IdeaSettings.Required_Stage_3>
					
		<cfquery name="updateSuggestion" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE Suggestion
		SET archived=1,
		WhenSugEnded=#createODBCdatetime(localdatetime)#
		WHERE sugID=#this_SugID#
		</cfquery>	
		
		<!--- <cfinclude template="act_email_stage4_decline.cfm"> --->
		
	</cfif>
		
</cfif>	
	

</cfloop>