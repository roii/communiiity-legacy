<cfquery name="Housedetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT BusinessName
	FROM FulfilmentHouses
	WHERE fulfilmenthouseID=#fulfilmenthouseID#
	</cfquery>
	
	
	<cfquery name="DeleteHouse" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM FulfilmentHouses
	WHERE fulfilmenthouseID=#fulfilmenthouseID#
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Delete Fulfilment House - (#Housedetails.BusinessName#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=fulfilment">
	
	
	</cfoutput>
