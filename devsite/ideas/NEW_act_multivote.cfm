<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfset returnIdeas = "">

<cfloop from="1" to="#form.TotalIdeas#" index="loopcount">

<cfif IsDefined("form.votevalue_#loopcount#") AND Evaluate("form.votevalue_" & loopcount) NEQ 'Z'>	
	
	<cfset this_SugID = #Evaluate("form.SugID_" & loopcount)#>
	
	<!--- GET THE IDEA DETAILS FOR TRANSACTION LOG --->
	<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.suggestion, suggestion.SugStage, Suggestion.ContactID, Contacts.FirstName, Contacts.EmailAddress, SugCategory.SponsorID
	FROM suggestion, SugCategory, Contacts
	WHERE suggestion.SugID=#this_SugID#
	AND suggestion.CategoryID=SugCategory.CategoryID
	AND Suggestion.ContactID=Contacts.ContactID
	</cfquery>
			
			
	<!--- get the total votes for this suggestion --->
	<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugVote
	WHERE sugID=#this_SugID#
	</cfquery>
	
	
	<cfif TotalVotes.RecordCount GTE IdeaSettings.Required_Stage_1>
	
		<!--- check if this is a Stage 1 suggestion --->
		<cfif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 1'>
			
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
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
				
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET SugStage='Stage 2'
				WHERE sugID=#this_SugID#
				</cfquery>					
				
				<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
				<cfset this_activity = 16>
				<cfset this_contactID = IdeaStuff.ContactID>
				<cfset this_relatedDescription = "IdeaStage2">
				<cfset this_relatedID = "#this_SugID#">
				<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">					
				
				<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Points
				FROM Activity
				WHERE ActivityID=16
				</cfquery>
				
				<cfinclude template="act_email_stage2_approve.cfm">				
			
			<cfelseif NoVotes GTE IdeaSettings.Required_Stage_1>
				
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET archived=1,
				WhenSugEnded=#createODBCdatetime(localdatetime)#
				WHERE sugID=#this_SugID#
				</cfquery>	
					
				<cfinclude template="act_email_stage2_decline.cfm">
			
			</cfif>		
				
	
	
	
		<!--- check if this is a Stage 2 suggestion --->
		<cfelseif IdeaStuff.SugStage CONTAINS 'Stage 2'>
				
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
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
				
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET SugStage='Stage 3'
				WHERE sugID=#this_SugID#
				</cfquery>					
				
				<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
				<cfset this_activity = 17>
				<cfset this_contactID = IdeaStuff.ContactID>
				<cfset this_relatedDescription = "IdeaStage3">
				<cfset this_relatedID = "#this_SugID#">
				<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">					
				
				<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Points
				FROM Activity
				WHERE ActivityID=17
				</cfquery>
									
				<cfinclude template="act_email_stage3_approve.cfm">				
			
			<cfelseif NoVotes GTE IdeaSettings.Required_Stage_2>
			
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET archived=1,
				WhenSugEnded=#createODBCdatetime(localdatetime)#
				WHERE sugID=#this_SugID#
				</cfquery>	
					
				<cfinclude template="act_email_stage3_decline.cfm">
			
			</cfif>
			
			
	
		<!--- check if this is a Stage 3 suggestion --->
		<cfelseif IdeaStuff.SugStage CONTAINS 'Stage 3'>
			
			<!--- get the total votes for this suggestion --->
			<cfquery name="TotalVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
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
			
			<!--- If it has received the required number of YES VOTES then move to Stage 4 --->
			<cfif YesVotes GTE IdeaSettings.Required_Stage_3>
				
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET SugStage='Stage 4',
				WhenSugEnded=#createODBCdatetime(localdatetime)#
				WHERE sugID=#this_SugID#
				</cfquery>					
				
				<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
				<cfset this_activity = 18>
				<cfset this_contactID = IdeaStuff.ContactID>
				<cfset this_relatedDescription = "IdeaStage4">
				<cfset this_relatedID = "#this_SugID#">
				<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">
				
				<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Points
				FROM Activity
				WHERE ActivityID=18
				</cfquery>
				
				<cfinclude template="act_email_stage4_approve.cfm">				
				
			<!--- if the vote average is NO dump it --->
			<cfelseif NoVotes GTE IdeaSettings.Required_Stage_3>
							
				<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Suggestion
				SET archived=1,
				WhenSugEnded=#createODBCdatetime(localdatetime)#
				WHERE sugID=#this_SugID#
				</cfquery>	
				
				<cfinclude template="act_email_stage4_decline.cfm">
				
			</cfif>
				
		</cfif>	
		
		
	<cfelse>
	
	
		<cfif Evaluate("form.votevalue_" & loopcount) CONTAINS '5'>
			<cfset this_Vote = 5>
		<cfelse>
			<cfset this_Vote = 1>
		</cfif>
		
		<cfif Evaluate("form.comments_" & loopcount) NEQ '' AND Evaluate("form.comments_" & loopcount) NEQ 'Add your feedback to help grow this idea...'>
			<cfset this_Comments = Evaluate("form.comments_" & loopcount)>	
		<cfelse>
			<cfset this_Comments = "">
		</cfif>
		
		<!--- CHECK THEY HAVEN'T VOTED ALREADY --->
		<cfquery name="CheckVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT vote
		FROM SugVote
		WHERE sugID=#this_SugID#
		AND ContactID=#Session.UserID#
		</cfquery>
		
		<cfif NOT CheckVote.RecordCount>
			
			<!--- GET THE IDEA DETAILS FOR TRANSACTION LOG --->
			<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT suggestion.suggestion, suggestion.SugStage, Suggestion.ContactID, Contacts.FirstName, Contacts.EmailAddress, SugCategory.SponsorID
			FROM suggestion, SugCategory, Contacts
			WHERE suggestion.SugID=#this_SugID#
			AND suggestion.CategoryID=SugCategory.CategoryID
			AND Suggestion.ContactID=Contacts.ContactID
			</cfquery>
			
			<cfset ExtraDescription = "<BR>Idea: #TRIM(IdeaStuff.Suggestion)#">		
			
			<!--- CHECK IT'S NOT THEIR IDEA --->
			<cfif IdeaStuff.ContactID EQ session.UserID>
			
			<cfelse>
			
				<cfset returnIdeas = returnIdeas & "#this_SugID#,">
			
				<cfquery name="updVoteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO SugVote(sugID, ContactID, vote, comments, whenVoteMade)
				VALUES(#this_SugID#, #Session.UserID#, #this_Vote#, '#Replace(this_Comments, "'", "'", "ALL")#', #createODBCDateTime(localDateTime)#)	
				</cfquery>
				
				<!--- PROCESS REWARDS --->
				<cfset this_activity = 13>
				<cfset this_contactID = session.UserID>
				<cfset this_relatedDescription = "Vote">
				<cfset this_relatedID = "#this_SugID#">
				<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">
					
				<!--- IF THEY GAVE REAL FEEDBACK GIVE THEM MORE REWARDS --->
				<cfif this_Comments NEQ '' AND this_Comments NEQ 'Add your feedback to help grow this idea...'>
					<cfset this_activity = 14>
					<cfset this_contactID = session.UserID>
					<cfset this_relatedDescription = "VoteComments">
					<cfset this_relatedID = "#this_SugID#">
					<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
					<cfinclude template="../templates/act_activity_reward_payment.cfm">			
				</cfif>		
				
			</cfif>
				
		</cfif>
		
	</cfif>

</cfif>

</cfloop>
	
<cfoutput>

<cfif IsDefined("returnIdeas") AND TRIM(returnIdeas) NEQ ''><script type="text/javascript">self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=voteresults&returnIdeas=#TRIM(returnIdeas)#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75";</script><cfelse><script type="text/javascript">self.location="#request.webroot#/index.cfm?fuseaction=ideas&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75&IdeaFunL_hideIdeas=No";</script></cfif>

</cfoutput>
