<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.CategoryID, SugCategory.Name, SugCategory.SponsorID, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<cfset ExtraDescription = "<BR>Idea: #TRIM(IdeaStuff.Suggestion)#">
<cfset this_categoryID = IdeaStuff.CategoryID>

<cfinclude template="../ideas/act_topic_stages.cfm">


<!--- GET DEFAULT EMAIL TEXT --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails
FROM EmailAlerts
WHERE AlertID=10
</cfquery>


<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{member_firstname}',  '#TRIM(IdeaStuff.FirstName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{member_firstname}',  '#TRIM(IdeaStuff.FirstName)#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(session.AllSettings_SiteName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(session.AllSettings_SiteName)#',  "ALL")>

<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>

<!--- REPLACE {idea_title} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{idea_title}',  '...#chr(10)##chr(10)#"#TRIM(IdeaStuff.suggestion)#"#chr(10)##chr(10)#...' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{idea_title}',  '...#chr(10)##chr(10)#"#TRIM(IdeaStuff.suggestion)#"#chr(10)##chr(10)#...' ,  "ALL")>

<!--- REPLACE {reason} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{reason}',  '#TRIM(form.comments)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{reason}',  '#TRIM(form.comments)#',  "ALL")>


<cfif form.moveStage EQ 'Returned'>

	<!--- REPLACE {idea_stage} --->
	<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{idea_stage}',  'Returned Ideas',  "ALL")>
	<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{idea_stage}',  'Returned Ideas',  "ALL")>

<cfelse>

	<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{idea_stage}',  'Stage #form.moveStage#',  "ALL")>
	<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{idea_stage}',  'Stage #form.moveStage#',  "ALL")>

</cfif>



<cfif form.moveStage EQ 'Returned'>

	<!--- UPDATE THE IDEA --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Suggestion
		SET Archived=1,
		comments='#form.comments#'
		WHERE SugID=#form.SugID#
		</cfquery>
		
		
		<cfif SiteMode NEQ 'dev'>
			<!--- EMAIL MEMBER --->
			<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		<cfelse>
			<!--- TEST EMAIL (GOES TO ADMIN) --->
			<cfmail server="#application.emailserver#" to="#TRIM(session.User_Email)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		</cfif>
		
		
<cfelse>



	<cfif TRIM(IdeaStuff.SugStage) CONTAINS 'Pending'>
		
		
		<cfif form.moveStage EQ 1>
			
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 1',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
			<cfset this_activity = 15>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage1">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
            
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_1 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_1>
            </cfif>
            
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
						
            <cfinclude template="../templates/act_activity_reward_payment.cfm">

				
		<cfelseif moveStage EQ 2>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 2',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
			<cfset this_activity = 15>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage1">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_1#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_2 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_2>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			
		<cfelseif moveStage EQ 3>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 3',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
			<cfset this_activity = 15>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage1">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_1#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_2#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_3 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_3>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<cfelseif moveStage EQ 4>
			
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 4',
			comments='#form.comments#',
			Authorise='Yes',
			WhenSugEnded=#createODBCdatetime(localdatetime)#
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 1 --->
			<cfset this_activity = 15>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage1">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_1#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_1#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_2#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_3#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
			<cfset this_activity = 18>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage4">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_4 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_4>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_4#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">			
		
		
		</cfif>
	

		<cfif SiteMode NEQ 'dev'>
			<!--- EMAIL MEMBER --->
			<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		<cfelse>
			<!--- TEST EMAIL (GOES TO ADMIN) --->
			<cfmail server="#application.emailserver#" to="#TRIM(session.User_Email)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		</cfif>
		
		
	
	<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 1'>
	
	
		<cfif moveStage EQ 2>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 2',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_2 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_2>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<cfelseif moveStage EQ 3>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 3',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_2#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_3 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_3>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<cfelseif moveStage EQ 4>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 4',
			comments='#form.comments#',
			Authorise='Yes',
			WhenSugEnded=#createODBCdatetime(localdatetime)#
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 2 --->
			<cfset this_activity = 16>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage2">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_2#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_2#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_3#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 18>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage4">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_4 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_4>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_4#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		</cfif>
		

		<cfif SiteMode NEQ 'dev'>
			<!--- EMAIL MEMBER --->
			<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		<cfelse>
			<!--- TEST EMAIL (GOES TO ADMIN) --->
			<cfmail server="#application.emailserver#" to="#TRIM(session.User_Email)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		</cfif>
		
	
	<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 2'>
	
	
		<cfif moveStage EQ 3>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 3',
			comments='#form.comments#',
			Authorise='Yes'
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_3 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_3>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<cfelseif moveStage EQ 4>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 4',
			comments='#form.comments#',
			Authorise='Yes',
			WhenSugEnded=#createODBCdatetime(localdatetime)#
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 3 --->
			<cfset this_activity = 17>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage3">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
			<cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_3#">
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_3#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
			<cfset this_activity = 18>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage4">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">			
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_4 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_4>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_4#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">			
		
		
		</cfif>
		

		<cfif SiteMode NEQ 'dev'>
			<!--- EMAIL MEMBER --->
			<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		<cfelse>
			<!--- TEST EMAIL (GOES TO ADMIN) --->
			<cfmail server="#application.emailserver#" to="#TRIM(session.User_Email)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		</cfif>
	
	
	<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 3'>
	
	
	
		<cfif moveStage EQ 4>
		
			<!--- UPDATE THE IDEA --->
			<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET SugStage='Stage 4',
			comments='#form.comments#',
			Authorise='Yes',
			WhenSugEnded=#createODBCdatetime(localdatetime)#
			WHERE SugID=#form.SugID#
			</cfquery>
			
			
			<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
			<cfset this_activity = 18>
			<cfset this_contactID = IdeaStuff.ContactID>
			<cfset this_relatedDescription = "IdeaStage4">
			<cfset this_relatedID = "#form.sugID#">
			<cfset this_sponsorID = "#IdeaStuff.SponsorID#">
            <cfif IsDefined("form.Reward") AND IsNumeric("#form.Reward#")>
			    <cfset this_IdeaStagePoints = (thisTopic_Points_Stage_4 + form.reward)>
            <cfelse>
                <cfset this_IdeaStagePoints = thisTopic_Points_Stage_4>
            </cfif>
            <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_4#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">			
		
		
		</cfif>
		
		
		<cfif SiteMode NEQ 'dev'>
			<!--- EMAIL MEMBER --->
			<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		<cfelse>
			<!--- TEST EMAIL (GOES TO ADMIN) --->
			<cfmail server="#application.emailserver#" to="#TRIM(session.User_Email)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
		
		</cfif>
	
	
	</cfif>

</cfif>


<!--- ADD MODERATOR LOG --->
<cfquery name="AddModLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ModeratorLog(ModDate, Moderator, type, RelatedID)
VALUES(#createODBCDateTime(localdatetime)#, #session.UserID#, 'Idea', #form.sugID#)
</cfquery>



<cfoutput>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location.reload(true);
    self.close();
}
// -->
</script>
	

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#form.currentcategory#&IdeaFunL_StartRow=1&srch_stage=ALL')">
</body>

</cfoutput>