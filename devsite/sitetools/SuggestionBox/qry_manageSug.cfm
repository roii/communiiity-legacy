
<cfparam name="sortby" default="date">
<cfparam name="sortorder" default="desc">
<cfparam name="sugID" default="0">

<cfif sugID NEQ 0>
<!--- Editing a suggestion --->
	<cfquery name="CurrentSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
		SELECT 	sug.sugID,
				convert(varchar(8),sug.whenSugMade,3) as [date],
				sug.suggestion,
				sug.email, 
				sug.authorise,
				ceiling(totalVote/voteNumReceived) as rated,
				sug.voteNumReceived as voteReceived,
				convert(varchar(8),sug.whenVotingClose,3) as voteCloseDate,
				cat.CategoryID,
				cat.Name
		FROM suggestion as sug, sugCategory as cat
		WHERE sug.categoryID = cat.categoryID AND
			  sug.sugID = #sugID#
	</cfquery>
	
	<cfquery name="CurrentCategory" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
		SELECT 	*
		FROM 	sugCategory
	</cfquery>
	
<cfelse>
<!--- View all suggestions --->
	<cfquery name="selAllSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
		SELECT 	sug.sugID,
				convert(varchar(8),sug.whenSugMade,3) as [date],
				sug.suggestion,
				sug.email, 
				sug.authorise,
				ceiling(totalVote/voteNumReceived) as rated,
				sug.voteNumReceived as voteReceived,
				convert(varchar(8),sug.whenVotingClose,3) as voteCloseDate,
				cat.Name
		FROM 	suggestion as sug, sugCategory as cat
		WHERE 	sug.categoryID = cat.categoryID AND
				sug.whenSugEnded is null
		ORDER BY #sortby# #sortorder#	
	</cfquery>
</cfif>