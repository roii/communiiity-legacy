<cfquery name="DeleteReverseTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
DELETE
FROM contact_transactions
WHERE Transaction_Description LIKE '%Points reversed from multiple goal updates%'
</cfquery>
		
		