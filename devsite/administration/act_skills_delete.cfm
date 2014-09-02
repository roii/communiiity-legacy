<cfquery name="DeleteSkill" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE FROM allmanageskills 
	WHERE id = #URL.skillID#
</cfquery>

<cfoutput> 
	 <cflocation addtoken="no" url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manageskills&suc=3">
</cfoutput>