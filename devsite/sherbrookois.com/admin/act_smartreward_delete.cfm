
	


<!--- update reward --->
	
	<cfquery name="updatereward" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SmartRewards
	WHERE SmartRewardID=#SmartRewardID#
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Delete Smart Reward'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentID=26">
	
	
	</cfoutput>
