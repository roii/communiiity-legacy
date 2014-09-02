
<cfparam name="sugID" default="0">

<cfif sugID NEQ "0">
<cfquery name="CurrentSugIdea" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM Suggestion 
	WHERE Suggestion.sugID = #sugID#
</cfquery>
</cfif>