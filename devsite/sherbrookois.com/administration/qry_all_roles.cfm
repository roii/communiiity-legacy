<cfquery name="qry_roles_all" datasource="#dsn#">
SELECT RoleID, RoleName, Description, Active
FROM Roles
ORDER BY RoleName
</cfquery>