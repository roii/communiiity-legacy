

<!--- DELETE THE TRANSACTION --->
	
	<cfquery name="RemoveTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contact_transactions
	WHERE TransactionID=#TransactionID#
	</cfquery>


	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney&this_contactID=#contactID#">
	
	
	</cfoutput>
