
	


<!--- DELETE --->

    <cfquery name="SelectTasks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ProjectID FROM Projects WHERE related_campaign = #CampaignsID#
	</cfquery> 
	<cfif SelectTasks.recordcount gt 0>
		<cfoutput query="SelectTasks">
			<cfset ProjectID = SelectTasks.ProjectID>
			<cfquery name="DeleteProjectComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
				DELETE
				FROM ProjectComments
				WHERE ProjectID = #ProjectID#
			</cfquery>
		</cfoutput>
		<cfquery name="DeleteProjects" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM projects
			WHERE related_campaign = #CampaignsID#
		</cfquery>
    </cfif>   
	
	<cfquery name="SelectCampaignsComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM campaignsComments WHERE CampaignsID = #CampaignsID#
	</cfquery>
	<cfif SelectCampaignsComments.recordcount gt 0>
		<cfquery name="DeleteCampaignsComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE FROM campaignsComments WHERE CampaignsID = #CampaignsID#
		</cfquery>  
	</cfif> 
	
	<cfquery name="SelectFollowedCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM followed_campaigns WHERE campaignid = #CampaignsID#
	</cfquery>
	<cfif SelectFollowedCampaigns.recordcount gt 0>
		<cfquery name="DeleteFollowedCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE
			FROM followed_campaigns
			WHERE campaignid = #CampaignsID#
		</cfquery> 
	</cfif> 
	
	<cfquery name="DeleteCampaign" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM campaigns
		WHERE CampaignsID = #CampaignsID#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	
	<cfoutput>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&documentID=#documentID#">
	
	
	</cfoutput>
