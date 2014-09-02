	
	<cfquery name="DeleteGroup" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ProjectGroups
	WHERE GroupID=#GroupID#
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Delete Cash Project Group'>
	<cfinclude template="act_adminlog.cfm">
	</cfoutput>


	

	
	<cfoutput>
		
		<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups">

	</cfoutput>
		
		


