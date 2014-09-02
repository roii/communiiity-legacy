<cfquery name="UpdateSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE IdeaFunl_Settings
SET Total_Pending=#form.Total_Pending#,
Required_Pending=#form.Required_Pending#,
Total_Stage_1=#form.Total_Stage_1#,
Required_Stage_1=#form.Required_Stage_1#,
Total_Stage_2=#form.Total_Stage_2#,
Required_Stage_2=#form.Required_Stage_2#,
Total_Stage_3=#form.Total_Stage_3#,
Required_Stage_3=#form.Required_Stage_3#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_stages">