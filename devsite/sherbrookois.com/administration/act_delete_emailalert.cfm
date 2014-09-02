<cfquery name="DeleteEmailAlert" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM EmailAlerts
WHERE AlertID=#AlertID#
</cfquery>


<cfoutput>

<script language="JavaScript">
alert("You have successfully deleted the email alert.");
self.location="#request.webroot#/index.cfm?Fuseaction=administration&Fusesubaction=manage_alerts";
</script>

</cfoutput>