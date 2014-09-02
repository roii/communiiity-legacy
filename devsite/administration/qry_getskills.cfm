<cfquery name="getSkills" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM allmanageskills
WHERE id = #skillID#
</cfquery>