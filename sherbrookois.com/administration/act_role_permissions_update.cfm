<cfoutput>


<!--- DELETE EXISTING ROLE PERMISSIONS --->
<cfquery name="DeleteAllPermissions"  datasource="#dsn#" maxrows="1">
DELETE
FROM RolePermissions
WHERE RoleID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.RoleID#">
</cfquery>

<!--- GET NUMBER OF PERMISSIONS TO LOOP --->
<cfquery name="AllPermissions" datasource="#dsn#">
SELECT PermissionID
FROM Permissions
</cfquery>

<!--- INSERT THE NEW ROLE PERMISSIONS --->
<cfloop from="1" to="#AllPermissions.RecordCount#" index="ThisRow">


<cfif IsDefined("form.Permission_#ThisRow#_View") OR IsDefined("form.Permission_#ThisRow#_Add") OR IsDefined("form.Permission_#ThisRow#_Edit") OR IsDefined("form.Permission_#ThisRow#_Delete")>

	
	<!--- insert details --->
	<cfquery name="InsertProjectUserpermissions"  datasource="#dsn#" maxrows="1">
	INSERT INTO RolePermissions(
	RoleID, 
	PermissionID,
	AllowView,
	AllowAdd,
	AllowEdit,
	AllowDelete	
	)
	VALUES(
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.RoleID#">, 
	#ThisRow#,
	<cfif IsDefined("form.Permission_#ThisRow#_View")>
		1,
	<cfelse>
		0,
	</cfif>
	<cfif IsDefined("form.Permission_#ThisRow#_Add")>
		1,
	<cfelse>
		0,
	</cfif>
	<cfif IsDefined("form.Permission_#ThisRow#_Edit")>
		1,
	<cfelse>
		0,
	</cfif>
	<cfif IsDefined("form.Permission_#ThisRow#_Delete")>
		1
	<cfelse>
		0
	</cfif>
	)
	</cfquery>

	
</cfif>


</cfloop>


<script language="JavaScript">
alert("You have successfully updated the Role Permissions.");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles&open_RoleID=#form.RoleID#";
</script>


</cfoutput>