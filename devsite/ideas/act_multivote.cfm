<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfquery name="qry_current_topic" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
<cfif IsNumeric("#currentcategory#")>
	WHERE CategoryID=#currentcategory#
<cfelse>
	WHERE CategoryID=1
</cfif>
</cfquery>

<cfset this_categoryID = qry_current_topic.CategoryID>
<cfinclude template="act_topic_stages.cfm">

<cfquery name="qry_all_category_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, SugVote
WHERE suggestion.SugID=SugVote.SugID
AND suggestion.Authorise = 'yes'
AND suggestion.Archived=0
AND suggestion.categoryID=#currentcategory#
AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)	
GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
ORDER BY voteReceived DESC
</cfquery>

<cfset activityid = 2>

<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#currentcategory#
AND Authorise LIKE '%No%'
AND Archived = 0
GROUP BY SugID
</cfquery>
		
<cfif qry_all_category_suggestions.RecordCount>
	<cfset ThisCatideas = valueList(qry_all_category_suggestions.SugID)>
<cfelse>
	<cfset ThisCatideas = "0">		
</cfif>

<cfif AllCat_InActiveIdeas.RecordCount>
	<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
</cfif>

<cfquery name="AllPointsEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Count(Transaction_Amount) AS TotalPointsEarned
FROM contact_transactions
WHERE (Related_Description LIKE '%AddIdea%'
OR Related_Description LIKE '%Vote%'
OR Related_Description LIKE '%VoteComments%'
OR Related_Description LIKE '%IdeaStage1%'
OR Related_Description LIKE '%IdeaStage2%'
OR Related_Description LIKE '%IdeaStage3%'
OR Related_Description LIKE '%IdeaStage4%'
OR Related_Description LIKE '%IdeaStage5%')
AND Related_Identifier IN (#ThisCatideas#)
AND Transaction_Type LIKE '%Credit%'
AND Transaction_Account LIKE '%Points%'
</cfquery>

<cfset this_pointsremaining = INT(qry_current_topic.PointsAllocated - AllPointsEarned.TotalPointsEarned)>

<cfif this_pointsremaining LTE 0>
	<script type="text/javascript">
    alert("The topic you are trying to vote on has been closed.\nYou can only vote on ideas in open topics.");
    history.back(-1);
    </script>
    <cfabort>	
<cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
	<script type="text/javascript">
    alert("The topic you are trying to vote on has been closed.\nYou can only vote on ideas in open topics.");
    history.back(-1);
    </script>
    <cfabort>
</cfif>


<cfset returnIdeas = "">

<cfloop from="1" to="#form.TotalIdeas#" index="loopcount">

<cfif IsDefined("form.votevalue_#loopcount#") AND Evaluate("form.votevalue_" & loopcount) NEQ 'Z'>	
	
	<cfset this_SugID = Evaluate("form.SugID_" & loopcount)>
	
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
		<cfset this_SugStage=IdeaStuff.SugStage>
		<cfset this_sponsorID=IdeaStuff.SponsorID>		
		
		<!--- CHECK IT'S NOT THEIR IDEA --->
		<cfif IdeaStuff.ContactID EQ session.UserID>
		
		<cfelse>
			
			<cfif this_SugStage DOES NOT CONTAIN 'Stage 4' AND this_SugStage DOES NOT CONTAIN 'Stage 5'>
			
				<cfset returnIdeas = ListAppend(returnIdeas, this_SugID, ",")>
			
				<cfquery name="updVoteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO SugVote(sugID, ContactID, vote, comments, whenVoteMade)
				VALUES(#this_SugID#, #Session.UserID#, #this_Vote#, '#Replace(this_Comments, "'", "'", "ALL")#', #createODBCDateTime(localDateTime)#)	
				</cfquery>
				
				<!--- PROCESS REWARDS --->
				<cfset this_activity = 13>
				<cfset this_contactID = session.UserID>
				<cfset this_relatedDescription = "Vote">
				<cfset this_relatedID = "#this_SugID#">
				<cfset this_sponsorID = "#this_sponsorID#">
				<cfset this_VotePoints = "#thisTopic_Points_Vote#">
				<cfset this_VotePrizes = "#thisTopic_Prize_Vote#">
				<cfinclude template="../templates/act_activity_reward_payment.cfm">
					
				<!--- IF THEY GAVE REAL FEEDBACK GIVE THEM MORE REWARDS --->
				<cfif this_Comments NEQ '' AND this_Comments NEQ 'Add your feedback to help grow this idea...'>
					<cfset this_activity = 14>
					<cfset this_contactID = session.UserID>
					<cfset this_relatedDescription = "VoteComments">
					<cfset this_relatedID = "#this_SugID#">
					<cfset this_sponsorID = "#this_sponsorID#">
				    <cfset this_FeedbackPoints = "#thisTopic_Points_Feedback#">
				    <cfset this_FeedbackPrizes = "#thisTopic_Prize_Feedback#">
					<cfinclude template="../templates/act_activity_reward_payment.cfm">			
				</cfif>
				
				<!--- check if this is a Stage 1 suggestion --->
				<cfif this_SugStage CONTAINS 'Pending'>
					
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
					<cfif YesVotes EQ thisTopic_Required_Pending>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET SugStage='Stage 1'
						WHERE sugID=#this_SugID#
						</cfquery>					
						
						<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
						<cfset this_activity = 15>
						<cfset this_contactID = IdeaStuff.ContactID>
						<cfset this_relatedDescription = "IdeaStage1">
						<cfset this_relatedID = "#this_SugID#">
						<cfset this_sponsorID = "#this_sponsorID#">
                        <cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_1#">
                        <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
						<cfinclude template="../templates/act_activity_reward_payment.cfm">					
						
						<cfinclude template="act_email_stage1_approve.cfm">				
					
					<cfelseif NoVotes EQ INT((thisTopic_Total_Pending - thisTopic_Required_Pending) + 1)>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1,
						WhenSugEnded=#createODBCdatetime(localdatetime)#
						WHERE sugID=#this_SugID#
						</cfquery>	
							
						<cfinclude template="act_email_stage1_decline.cfm">
					
					</cfif>		
					
					
					
				<!--- check if this is a Stage 1 suggestion --->
				<cfelseif this_SugStage CONTAINS 'Stage 1'>
					
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
					<cfif YesVotes EQ thisTopic_Required_Stage_1>
						
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
						<cfset this_sponsorID = "#this_sponsorID#">
						<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_2#">
                        <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
						<cfinclude template="../templates/act_activity_reward_payment.cfm">					
												
						<cfinclude template="act_email_stage2_approve.cfm">				
					
					<cfelseif NoVotes EQ (INT(thisTopic_Total_Stage_1 - thisTopic_Required_Stage_1) + 1)>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1,
						WhenSugEnded=#createODBCdatetime(localdatetime)#
						WHERE sugID=#this_SugID#
						</cfquery>	
							
						<cfinclude template="act_email_stage2_decline.cfm">
					
					</cfif>		
						
				<!--- check if this is a Stage 2 suggestion --->
				<cfelseif this_SugStage CONTAINS 'Stage 2'>
						
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
					<cfif YesVotes EQ thisTopic_Required_Stage_2>				
						
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
						<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_3#">
                        <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
                        <cfset this_sponsorID = "#this_sponsorID#">
						<cfinclude template="../templates/act_activity_reward_payment.cfm">					
																	
						<cfinclude template="act_email_stage3_approve.cfm">				
					
					<cfelseif NoVotes EQ (INT(thisTopic_Total_Stage_2 - thisTopic_Required_Stage_2) + 1)>
					
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1,
						WhenSugEnded=#createODBCdatetime(localdatetime)#
						WHERE sugID=#this_SugID#
						</cfquery>	
							
						<cfinclude template="act_email_stage3_decline.cfm">
					
					</cfif>
			
				<!--- check if this is a Stage 3 suggestion --->
				<cfelseif this_SugStage CONTAINS 'Stage 3'>
					
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
					<cfif YesVotes EQ thisTopic_Required_Stage_3>
						
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET SugStage='Stage 4',
						WhenSugEnded=#createODBCdatetime(localdatetime)#,
						DisplayAsWinner=0
						WHERE sugID=#this_SugID#
						</cfquery>										
						
					<!--- if the vote average is NO dump it --->
					<cfelseif NoVotes EQ (INT(thisTopic_Total_Stage_3 - thisTopic_Required_Stage_3) + 1)>
									
						<cfquery name="updateSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Suggestion
						SET archived=1,
						WhenSugEnded=#createODBCdatetime(localdatetime)#
						WHERE sugID=#this_SugID#
						</cfquery>	
						
						<cfinclude template="act_email_stage4_decline.cfm">
						
					</cfif>
						
				</cfif>	
				
			</cfif>
			
		</cfif>
			
	</cfif>	

</cfif>

</cfloop>
	
<cfoutput>

<cfif IsDefined("returnIdeas") AND TRIM(returnIdeas) NEQ ''><script type="text/javascript">self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=voteresults&returnIdeas=#TRIM(returnIdeas)#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75";</script><cfelse><script type="text/javascript">self.location="#request.webroot#/index.cfm?fuseaction=ideas&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75&IdeaFunL_hideIdeas=No";</script></cfif>

</cfoutput>
