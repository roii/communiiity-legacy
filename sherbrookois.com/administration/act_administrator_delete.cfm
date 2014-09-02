
	<cfquery name="administratorDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName
	FROM Administrator
	WHERE AdministratorID = #AdministratorID#
	</cfquery>
	
	<cfquery name="Deleteadministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Administrator
	WHERE AdministratorID = #AdministratorID#
	</cfquery>


	
	<cfoutput>
	<cfset logdetails = 'Delete Administrator - (#administratorDetails.FirstName# #administratorDetails.LastName#)'>
	</cfoutput>
	
	<cfinclude template="act_adminlog.cfm">
		
		
		

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#">