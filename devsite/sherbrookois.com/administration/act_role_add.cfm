<!--- AUTHORISATION REQUIRED - ADMINISTRATION USERS --->
<cfif session.permission95_view EQ 1 OR session.permission1_view EQ 1>


<cfoutput>

<!--- Insert the currnecy details --->	
<cfquery name="AddRole" datasource="#dsn#" maxrows="1">
INSERT INTO Roles( RoleName) VALUES(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.RoleName#">)
</cfquery>

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

<cfelse>

	<script>
	alert("You don't have permission to access this page.");
	window.close();
	</script>
	<cfabort>

</cfif>