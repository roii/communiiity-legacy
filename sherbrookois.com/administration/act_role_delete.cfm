<cfoutput>

<!--- MARK THE ROLE AS DELETED --->
<cfquery name="DeleteRole" datasource="#dsn#">
DELETE
FROM Roles
WHERE RoleID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#RoleID#">
</cfquery>

<!--- REDIRECT TO THE ROLE EDITOR POP-UP TEMPLATE --->
<script language="JavaScript">
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles";
</script>

</cfoutput>