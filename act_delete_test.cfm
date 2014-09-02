<cfloop from="1" to="#form.TotalRecs#" index="loopcount">

<cfif IsDefined("delete_#loopcount#") AND Evaluate("delete_" & loopcount) CONTAINS 1>

	<!--- DELETE CONTACT --->
	<cfquery name="DeleteContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Contacts
	WHERE ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	
	
	<!--- DELETE TRANSACTIONS --->
	<cfquery name="DeleteTrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contact_transactions
	WHERE ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	
	<!--- DELETE IDEAS --->
	<cfquery name="DeleteSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Suggestion
	WHERE ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	<!--- DELETE VOTES --->
	<cfquery name="DeleteVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SugVote
	WHERE ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	<!--- DELETE Links --->
	<cfquery name="DeleteVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ParentKidLinks
	WHERE Kid_ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	<!--- DELETE Prize entry --->
	<cfquery name="DeletePrize" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Prize_Entry
	WHERE ContactID=#Evaluate("ContactID_" & loopcount)#
	</cfquery>
	
	
</cfif>


</cfloop>