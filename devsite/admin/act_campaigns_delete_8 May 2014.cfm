
	


<!--- DELETE --->
	
	<cfquery name="DeleteCampaign" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM campaigns
	WHERE CampaignsID = #CampaignsID#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&documentID=#documentID#">
	
	
	</cfoutput>
