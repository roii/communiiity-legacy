<cfquery name="DeleteReverseTrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM contact_transactions
WHERE Transaction_Description LIKE '%Points reversed from multiple goal updates%'
</cfquery>
		
		