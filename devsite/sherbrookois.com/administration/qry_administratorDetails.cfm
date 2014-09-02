<cfquery name="AdminDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Administrator
WHERE AdministratorID=#AdministratorID#
</cfquery>

