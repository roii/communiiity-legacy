
	


<!--- UPDATE --->
	
	<cfquery name="DeleteProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Projects
	WHERE ProjectID=#ProjectID#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#">
	
	
	</cfoutput>
