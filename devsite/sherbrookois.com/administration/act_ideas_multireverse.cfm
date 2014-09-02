<!--- LOOP SUG --->
<cfloop from="1" to="#form.TotalRecs#" index="loopcount">

<!--- CHECK IF MARKED TO REVERSE --->
<cfif IsDefined("form.Delete_#loopcount#") AND Evaluate("form.Delete_" & loopcount) EQ 1>

	<!--- GET DETAILS --->
	<cfquery name="SugStuff"  datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Suggestion
	WHERE SugID=#Evaluate("form.SugID_" & loopcount)#
	</cfquery>
	
	
	<!--- REVERSE POINTS --->
	<cfquery name="RemovePoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contact_transactions
	WHERE ContactID=#SugStuff.ContactID#
	AND Related_Description LIKE '%AddIdea%'
	AND Related_Identifier=#Evaluate("form.SugID_" & loopcount)#	
	</cfquery>

	<!--- DELETE IDEA --->
	<cfquery name="RemoveIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Suggestion
	WHERE SugID=#Evaluate("form.SugID_" & loopcount)#	
	</cfquery>



</cfif>

</cfloop>


<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug">