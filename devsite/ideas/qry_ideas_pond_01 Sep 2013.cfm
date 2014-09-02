<cfif thisTopic_Use_Pending EQ 1 AND IsDefined("ShowPending")>

	<cfquery name="qry_ideas_pond" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sugID, suggestion, details, whenVotingClose, contactID, categoryID, archived, authorise, WhenSugMade, SugStage
	FROM suggestion
	WHERE categoryID=#currentcategory#
	AND SugID IN (#returnideas#)
	ORDER BY WhenSugMade
	</cfquery>
	
<cfelseif IsDefined("ShowReturned")>

	<cfquery name="qry_ideas_pond" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sugID, suggestion, details, whenVotingClose, contactID, categoryID, archived, authorise, WhenSugMade, SugStage
	FROM suggestion
	WHERE categoryID=#currentcategory#
	AND SugID IN (#returnideas#)
	AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
	ORDER BY WhenSugMade
	</cfquery>

<cfelse>

	<cfquery name="qry_ideas_pond" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
	FROM suggestion, Contacts
	WHERE suggestion.ContactID=Contacts.ContactID
	AND suggestion.categoryID=#currentcategory#
	
	<cfif IsDefined("returnIdeas") AND returnIdeas NEQ ''>
		AND suggestion.SugID IN (#returnideas#)
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.IdeaFunL_hideIdeas EQ 'Yes' AND votedList NEQ ''>
			AND suggestion.SugID NOT IN (#votedList#)
		</cfif>	
	<cfelse>
		AND suggestion.Authorise = 'yes'
		AND suggestion.Archived=0
		<cfif session.srch_stage NEQ 'ALL'>
			AND suggestion.SugStage LIKE '%#session.srch_stage#%'	
		<cfelse>
			AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)	
		</cfif>	
		<cfif session.srch_keywords NEQ '' AND  session.srch_keywords DOES NOT CONTAIN 'Keywords...'>
			AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
			OR suggestion.Details LIKE '%#session.srch_keywords#%' 
			OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
			OR contacts.lastName LIKE '%#session.srch_keywords#%' 
			OR contacts.ScreenName LIKE '%#session.srch_keywords#%')	
		</cfif>	
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.IdeaFunL_hideIdeas EQ 'Yes' AND votedList NEQ ''>
			AND suggestion.SugID NOT IN (#votedList#)
		</cfif>	
	</cfif>
	ORDER BY suggestion.WhenSugMade
	</cfquery>

</cfif>