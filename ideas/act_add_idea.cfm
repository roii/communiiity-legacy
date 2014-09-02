<!--- GET IDEAfunL SETTINGS --->
<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfquery name="qry_current_topic" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
<cfif IsNumeric("#Form.selCategory#")>
	WHERE CategoryID=#Form.selCategory#
<cfelse>
	WHERE CategoryID=1
</cfif>
</cfquery>

<cfquery name="qry_all_category_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, SugVote
WHERE suggestion.SugID=SugVote.SugID
AND suggestion.Authorise = 'yes'
AND suggestion.Archived=0
AND suggestion.categoryID=#Form.selCategory#
AND (suggestion.SugStage LIKE '%Stage 1%' OR suggestion.SugStage LIKE '%Stage 2%' OR suggestion.SugStage LIKE '%Stage 3%')	
GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
ORDER BY voteReceived DESC
</cfquery>

<cfset activityid = 2>

<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#Form.selCategory#
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
    alert("The topic you are trying to add your idea to has been closed.\nYou can only add ideas to open topics.");
    history.back(-1);
    </script>
    <cfabort>	
<cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
	<script type="text/javascript">
    alert("The topic you are trying to add your idea to has been closed.\nYou can only add ideas to open topics.");
    history.back(-1);
    </script>
    <cfabort>
</cfif>


<cfquery name="AddSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Suggestion(email, categoryID, suggestion, madeBy, contactID, WhenSugMade)
VALUES ('#Trim(Form.txtEmail)#', '#Trim(Form.selCategory)#', '#Form.txtareaSuggestion#', '#Trim(session.User_FirstName)# #Trim(session.User_LastName)#', #session.UserID#, #createODBCDateTime(localDateTime)#)
</cfquery>


<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT SugID
FROM Suggestion
WHERE ContactID=#session.userID#
ORDER BY SugID DESC
</cfquery>



<!--- PROCESS REWARDS --->
<cfset this_activity = 12>
<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "AddIdea">
<cfset this_relatedID = "#LastID.SugID#">

<cfinclude template="../templates/act_activity_reward_payment.cfm">



<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert('Thanks for voting and giving feedback. Your idea has been added to the IDEAfunL.');
	self.close();
}

// -->
</script>


<cfoutput>

<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75')">
</body>


</cfoutput>