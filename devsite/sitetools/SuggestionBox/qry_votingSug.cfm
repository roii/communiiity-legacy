


<cfquery name="votingSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	SELECT		sug.sugID,
				convert(varchar(8),sug.whenSugMade,3) as [date],
				suggestion,
				convert(varchar(8),sug.whenVotingClose,3) as [Closedate],
				cat.name as sugName,
				cat.priority
	
	FROM		suggestion as sug,
				sugCategory as cat
	
	WHERE		sug.categoryID = cat.categoryID AND
				(sug.whenVotingClose >= whenSugMade) AND
				sug.whenSugEnded is null AND
				authorise ='yes'
	
	ORDER BY	cat.priority asc,[date] desc	

</cfquery>

<cfquery name="votingCategory" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">

	SELECT		distinct cat.name,
				cat.priority
	
	FROM		suggestion as sug,
				sugCategory as cat
	
	WHERE		sug.categoryID = cat.categoryID AND
				(sug.whenVotingClose >= whenSugMade) AND
				sug.whenSugEnded is null AND
				authorise ='yes'
	
	ORDER BY	cat.priority asc	

</cfquery>