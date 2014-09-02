<cfoutput>

<!--- UPDATE THE ROLE --->
<cfquery name="UpdateRole" datasource="#dsn#">
UPDATE Roles
SET RoleName=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.RoleName#">
WHERE RoleID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.RoleID#">
</cfquery>	

<!--- REDIRECT TO THE ADMINISTRATORS POP-UP TEMPLATE --->
<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
window.opener.document.location = givenURL;
self.close();
}	
// -->
</script>
	
<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles')"></body>
	
</cfoutput>