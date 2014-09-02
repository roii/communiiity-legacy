
<cfif IsDate("#form.WhenSugEnded#")>
	<cfset enddate = CREATEDATE(mid(form.WhenSugEnded,7,4), mid(form.WhenSugEnded,4,2), mid(form.WhenSugEnded,1,2))>
	<cfset enddate = DateFormat(enddate,"d mmmm yyyy")>
<cfelse>
	<cfset enddate = DateFormat(localdatetime,"d mmmm yyyy")>
</cfif>

	<cfquery name="IdeaDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.suggestion, suggestion.SugStage, Suggestion.DisplayAsWinner, Suggestion.ContactID, Contacts.FirstName, Contacts.EmailAddress, SugCategory.SponsorID, SugCategory.CategoryID
	FROM suggestion, SugCategory, Contacts
	WHERE suggestion.SugID=#form.SugID#
	AND suggestion.CategoryID=SugCategory.CategoryID
	AND Suggestion.ContactID=Contacts.ContactID
	</cfquery>	
	
	<cfif IdeaDetails.DisplayAsWinner NEQ 1 AND form.DisplayAsWinner EQ 1>	
		
        <cfset this_categoryID = IdeaDetails.CategoryID>
        <cfinclude template="../ideas/act_topic_stages.cfm">
        
		<!--- PROCESS REWARDS FOR MAKING STAGE 4 --->
		<cfset this_activity = 18>
		<cfset this_contactID = IdeaDetails.ContactID>
		<cfset this_relatedDescription = "IdeaStage4">
		<cfset this_relatedID = "#form.SugID#">
		<cfset this_sponsorID = "#IdeaDetails.sponsorID#">
        <cfset this_IdeaStagePoints = "#thisTopic_Points_Stage_4#">
        <cfset this_IdeaStagePrizes = "#thisTopic_Prize_Stage_4#">
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<cfquery name="CheckReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT TransactionID
		FROM contact_transactions
		WHERE Related_Description LIKE '%#this_relatedDescription#%'
		AND Related_Identifier=#this_relatedID#
		AND ContactID=#this_contactID#
		</cfquery>
		
		<cfif CheckReward.RecordCount>
		<cfelse>
		
		<cfinclude template="../ideas/act_email_stage4_approve.cfm">
		
		</cfif>
	
	</cfif>	

<!--- UPDATE IDEA INFO --->	
	<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE suggestion
	SET suggestion='#form.suggestion#',
	details='#TRIM(form.details)#',
	CategoryID=#form.CategoryID#,
	SugStage='#form.SugStage#',
	archived=#form.archived#,	
	<cfif form.SugStage NEQ 'Pending'>
		Authorise='Yes',
	<cfelse>
		Authorise='No',
	</cfif>	
	<cfif IsDefined("form.DisplayAsWinner") AND form.DisplayAsWinner EQ 1>
		DisplayAsWinner=1,
	<cfelse>
		DisplayAsWinner=0,
	</cfif>	
	<cfif IsDate("#enddate#")>
		WhenSugEnded='#enddate#',
	</cfif>	
	reward='#form.reward#',	
	comments='#TRIM(form.comments)#'
	WHERE SugID=#form.SugID#
	</cfquery>


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("You have successfully updated the idea");
		window.opener.document.location = givenURL;
		self.close();
	}	
	// -->
	</script>	
	
	<cfoutput>
		
		<cfif isDefined("form.winnerIdeas")>
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=78')"></body>
		<cfelse>
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug')"></body>
		</cfif>
	
	</cfoutput>
