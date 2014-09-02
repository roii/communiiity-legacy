<cfquery name="CampaignsDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT campaigns.*, ProjectCategories.Title as CategoryTitle,ProjectCategories.displayorder
FROM campaigns, ProjectCategories
WHERE campaigns.CampaignsID=#CampaignsID#
AND campaigns.ProjectCategoryID=ProjectCategories.ProjectCategoryID
order by displayorder
</cfquery>

<cfquery name="campaignsComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT campaigns.*, campaignsComments.*
FROM campaigns, campaignsComments
WHERE campaigns.CampaignsID=#CampaignsID#
AND campaigns.CampaignsID=campaignsComments.CampaignsID
order by DateAdded
</cfquery>