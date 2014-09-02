<cfquery name="qry_current_roles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Roles
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>

<cfset newRoles = ListDeleteAt(qry_current_roles.Roles, ListFind(qry_current_roles.Roles, 2, ","), ",")>

<cfquery name="qry_update_roles" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET Roles='#newRoles#'
WHERE ContactID=#ContactID#
</cfquery>	


	
<cfoutput>	

<script language="JavaScript">
alert("Moderation rights have been removed for selected moderator.");
self.location = "#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_idea_moderators";
</script>
	
</cfoutput>

<cfabort>
