
<cfoutput>

<cftry>
<!--- all available suggestions authorise to vote 
<cfquery name="Suggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	
	select 	s.sugID,
			s.suggestion,
			convert(varchar(8),s.whenVotingClose,3) as whenVotingClose,
			s.madeBy,
			s.contactID,
			s.categoryID,
			s.archived,
			count(sv.vote) as voteReceived,
			'avgVote'=
			CASE
				WHEN round(sum(sv.vote)/count(sv.sugID),0) = 1 THEN	'It stinks'
				WHEN round(sum(sv.vote)/count(sv.sugID),0) = 2 THEN	'Not so good'
				WHEN round(sum(sv.vote)/count(sv.sugID),0) = 3 THEN	'Its Ok'
				WHEN round(sum(sv.vote)/count(sv.sugID),0) = 4 THEN	'Its good'
				WHEN round(sum(sv.vote)/count(sv.sugID),0) = 5 THEN	'Its a winner'
			END	
		
	from	suggestion as s,
			sugVote as sv
	
	where   s.SugID *= sv.SugID AND
			(s.whenVotingClose >= s.whenSugMade) AND
			s.whenSugEnded is null AND
			s.authorise ='yes' AND
			s.archived = 0
		
	group by s.sugID,
			s.suggestion,
			s.whenVotingClose,
			s.madeBy,
			s.contactID,
			s.categoryID

</cfquery>

--->

<!--- all available suggestions authorise to vote  --->
<cfstoredproc procedure="dp_Suggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	<cfprocresult name="Suggestion">
	
</cfstoredproc>


<!--- all suggestion category order by priority 
<cfquery name="Category" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	select	 *
	from 	sugCategory
	where 	whenCategoryEnded is null	
	Order by priority asc,
		 	[name] asc	

</cfquery>
--->

<!--- all suggestion category order by priority --->
<cfstoredproc procedure="dp_Category" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	<cfprocresult name="Category">
	
</cfstoredproc>

<cfif session.UserIsAuthenticated EQ 'yes'>

<!--- select all suggestion that has been vote by the user 
<cfquery name="UserVotedSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	select 	sv.sugID
	from 	suggestion as s,
			sugvote as sv
	Where	 s.sugID = sv.sugID	and
		 	sv.contactID = #session.UserID#
</cfquery>
--->

<!--- select all suggestion that has been vote by the user --->
<cfstoredproc procedure="dp_UserVotedSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	<cfprocparam value="#session.UserID#" cfsqltype="cf_sql_integer">
	<cfprocresult name="UserVotedSuggestion">	
	
</cfstoredproc>

</cfif>

<cfcatch type="any">


</cfcatch>

</cftry>

</cfoutput>