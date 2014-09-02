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
		SELECT suggestion.suggestion, SugCategory.CategoryID, SugCategory.SponsorID, Contacts.FirstName, Contacts.EmailAddress
		FROM suggestion, SugCategory, Contacts
		WHERE suggestion.SugID=#this_SugID#
		AND suggestion.CategoryID=SugCategory.CategoryID
		AND Suggestion.ContactID=Contacts.ContactID
		</cfquery>       
        
        <cfset this_categoryID = IdeaStuff.CategoryID>
        <cfinclude template="act_topic_stages.cfm">
		
		<cfset ExtraDescription = "<BR>Idea: #TRIM(IdeaStuff.Suggestion)#">
			
		<cfif IsDefined("form.rate#loopcount#") AND evaluate("form.rate" & loopcount) GT 0>	
	
			<!--- CHECK THEY HAVEN'T VOTED ALREADY --->
			<cfquery name="CheckVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT vote
			FROM SugVote
			WHERE sugID=#this_sugID#
			AND ContactID=#Session.UserID#
			</cfquery>
			
			<cfif CheckVote.RecordCount EQ 0>
				
				<cfif IsDefined("form.comments#loopcount#") AND evaluate("form.comments" & loopcount) NEQ '' AND evaluate("form.comments" & loopcount) NEQ 'Add your feedback to help grow this idea...'>
					<cfset this_comments = "#evaluate("form.comments" & loopcount)#">
				<cfelse>
					<cfset this_comments = "">
				</cfif>
		
				<cfquery name="updVoteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO SugVote(sugID, ContactID, vote, whenVoteMade, comments)
				VALUES(#this_sugID#, #Session.UserID#, #evaluate("form.rate" & loopcount)#, #createODBCDateTime(localDateTime)#, '#Replace(this_comments, "'", "'", "ALL")#')	
				</cfquery>
			
				<!--- PROCESS REWARDS --->
				<cfset this_activity = 13>
				<cfset this_contactID = session.UserID>
				<cfset this_relatedDescription = "Vote">
				<cfset this_relatedID = "#this_sugID#">
				<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
                <cfset this_VotePoints = "#thisTopic_Points_Vote#">
				<cfset this_VotePrizes = "#thisTopic_Prize_Vote#">				
				<cfinclude template="../templates/act_activity_reward_payment.cfm">		
			
				<!--- IF THEY GAVE REAL FEEDBACK GIVE THEM MORE REWARDS --->
				<cfif IsDefined("form.comments#loopcount#") AND evaluate("form.comments" & loopcount) NEQ '' AND evaluate("form.comments" & loopcount) NEQ 'Add your feedback to help grow this idea...'>
					<cfset this_activity = 14>
					<cfset this_contactID = session.UserID>
					<cfset this_relatedDescription = "VoteComments">
					<cfset this_relatedID = "#this_sugID#">
					<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
				    <cfset this_FeedbackPoints = "#thisTopic_Points_Feedback#">
				    <cfset this_FeedbackPrizes = "#thisTopic_Prize_Feedback#">
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
				
					<!--- if the vote average is YES move to Stage 1 --->
					<cfif YesVotes GTE thisTopic_Required_Pending>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET Authorise='Yes',
						SugStage = 'Stage 1'
						WHERE sugID=#this_sugID#
						</cfquery>						
						
						<!--- GET IDEA AND USER DETALS --->
						<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT suggestion.suggestion, SugCategory.SponsorID, Contacts.ContactID, Contacts.FirstName, Contacts.EmailAddress
						FROM suggestion, SugCategory, Contacts
						WHERE suggestion.SugID=#this_SugID#
						AND suggestion.CategoryID=SugCategory.CategoryID
						AND Suggestion.ContactID=Contacts.ContactID
						</cfquery>						
						
						<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
						<cfset this_activity = 15>
						<cfset this_contactID = IdeaStuff.ContactID>
						<cfset this_relatedDescription = "IdeaStage1">
						<cfset this_relatedID = "#this_sugID#">
						<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
                        <cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_1#">
                        <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
						<cfinclude template="../templates/act_activity_reward_payment.cfm">					
												
						<cfinclude template="act_email_stage1_approve.cfm">						
					
					<!--- if the vote average is NO dump it --->
					<cfelseif NoVotes GTE (INT(thisTopic_Total_Pending - thisTopic_Required_Pending) + 1)>
					
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1
						WHERE sugID=#this_sugID#
						</cfquery>	
						
						<!--- GET IDEA AND USER DETALS --->
						<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT suggestion.suggestion, SugCategory.SponsorID, Contacts.ContactID, Contacts.FirstName, Contacts.EmailAddress
						FROM suggestion, SugCategory, Contacts
						WHERE suggestion.SugID=#this_SugID#
						AND suggestion.CategoryID=SugCategory.CategoryID
						AND Suggestion.ContactID=Contacts.ContactID
						</cfquery>
						
						<cfinclude template="act_email_stage1_decline.cfm">
					
					</cfif>		
		
				</cfif>
		
			</cfif>
		
		</cfif>
	
	</cfif>
	
	</cfloop>
				
</cfif>


<!--- ADD NEW IDEA --->
    
        
<!--- CHECK IF THIS IS A DRAFT IDEA --->
<cfif IsDefined("form.DraftID") AND form.DraftID NEQ 0>
    
    <cfset this_categoryID = Form.selCategory>
    <cfinclude template="act_topic_stages.cfm">
	
	<cfquery name="ActionDraft" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Suggestion
	SET categoryID=#Form.selCategory#, 
	suggestion='#Form.txtareaSuggestion#', 
	details='#Form.txtareaDetails#',
	SugStage='Pending'
	WHERE SugID=#form.DraftID#
	</cfquery>

	<cfset this_relatedID = "#form.DraftID#">
	
<cfelse>
    
    <cfset this_categoryID = Form.selCategory>
    <cfinclude template="act_topic_stages.cfm">
    
	<cfquery name="AddSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Suggestion(categoryID, suggestion, details, madeBy, contactID, Authorise, SugStage, WhenSugMade, Archived)
	VALUES (#Form.selCategory#, '#Form.txtareaSuggestion#', '#Form.txtareaDetails#', '#Trim(session.User_FirstName)# #Trim(session.User_LastName)#', #session.UserID#, 'no', 'Pending', #createODBCDateTime(localDateTime)#, 0)
	</cfquery>

	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SugID
	FROM Suggestion
	WHERE ContactID=#session.userID#
	ORDER BY SugID DESC
	</cfquery>
	
	<cfset this_relatedID = "#LastID.sugID#">	
	
	<cfquery name="IdeaCatStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugCategory.SponsorID
	FROM SugCategory
	WHERE CategoryID=#Form.selCategory#
	</cfquery>
	
	<cfset ExtraDescription = "<BR>Idea: #TRIM(Form.txtareaSuggestion)#">
		
	<!--- PROCESS REWARDS --->
	<cfset this_activity = 12>
	<cfset this_contactID = session.UserID>
	<cfset this_relatedDescription = "AddIdea">
	<cfset this_sponsorID = "#IdeaCatStuff.SponsorID#">
    <cfset this_IdeaStagePoints = "#thisTopic_Points_SubmitIdea#">
    <cfset this_IdeaStagePrizes = "#thisTopic_Prize_SubmitIdea#">
	<cfinclude template="../templates/act_activity_reward_payment.cfm">

</cfif>

<cfif IsNumeric("#Form.selCategory#") AND Form.selCategory NEQ 0>
	
	<script>
	alert('Thanks for voting and giving feedback. Your idea has been added to the IDEAfunL.');
	self.location="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#selCategory#";
	</script>

<cfelse>	
	
	<script>
	alert('Thanks for voting and giving feedback. Your idea has been added to the IDEAfunL.');
	self.location="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75";
	</script>

</cfif>

</cfoutput>
