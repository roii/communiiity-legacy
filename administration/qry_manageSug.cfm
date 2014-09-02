
<cfparam name="sortby" default="Authorise">
<cfparam name="sortorder" default="asc">
<cfparam name="sugID" default="0">
<cfparam name="archived" default="false">

<cfif sugID NEQ 0>
<!--- Editing a suggestion --->
	<cfquery name="CurrentSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
		
		SELECT 	sug.sugID,
				count(vot.sugID) as voteReceived,
				round(sum(vot.vote)/count(vot.sugID),0) as rate,
				sug.madeBy as [by],
				convert(varchar(8),sug.whenSugMade,3) as [date],
				sug.suggestion,
				sug.email, 
				sug.authorise,
				sug.contactid,
				sug.comments,
				sug.archived,
				convert(varchar(8),sug.whenVotingClose,3) as voteCloseDate,
				cat.CategoryID,
				cat.Name
		
		FROM 	suggestion as sug, sugCategory as cat, sugVote as vot
		
		WHERE 	sug.categoryID = cat.categoryID AND
				sug.sugID *= vot.sugID AND
			 	sug.sugID = #sugID#
				
		Group 	by sug.sugID,sug.madeBy, sug.whenSugMade, sug.suggestion, sug.email, sug.authorise,sug.contactid,sug.comments,
				sug.archived, sug.whenVotingClose, cat.CategoryID,cat.Name
	</cfquery>
	
	<cfquery name="CurrentCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT 	*
		FROM 	sugCategory
		WHERE	WhenCategoryEnded is null
	</cfquery>
	
<cfelse>
<!--- View all suggestions --->
	<cfquery name="selAllSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
		
		SELECT 	sug.sugID,
				count(vot.sugID) as voteReceived,
				round(sum(vot.vote)/count(vot.sugID),0) as rate,
				sug.madeBy as [by],
				convert(varchar(8),sug.whenSugMade,3) as [date],
				sug.suggestion,
				sug.email, 
				sug.authorise,
				sug.archived,
				convert(varchar(8),sug.whenVotingClose,3) as voteCloseDate,
				cat.Name
		FROM 	suggestion as sug, sugCategory as cat, sugVote as vot
		
		WHERE 	sug.categoryID = cat.categoryID AND
				sug.sugID *= vot.sugID AND
				<cfif archived eq "true">
				  sug.archived = 1 AND
				<cfelse>
				  sug.archived = 0 AND
				</cfif>
				sug.whenSugEnded is null
		
		Group	 by sug.sugID,sug.madeBy, sug.whenSugMade, sug.suggestion, sug.email, sug.authorise, sug.archived,
				 sug.whenVotingClose, cat.Name
				 
		ORDER BY #sortby# #sortorder#	
	</cfquery>
</cfif>