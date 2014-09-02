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
<cfset vote_idea = 1>

<cfif this_pointsremaining LTE 0>
	<cfset vote_idea = 0>	
<cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
	<cfset vote_idea = 0>
</cfif>

<cfif qry_current_topic.ShowAdd EQ 1>
	<cfset add_idea = 1>
<cfelse>
	<cfset add_idea = 0>	
</cfif>