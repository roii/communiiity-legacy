<cfoutput>

<!--- DELETE CONTACT --->
<cfquery name="DeleteContact" datasource="#DSN#" username="#request.username#" password="#request.password#">
DELETE
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>


<script language="JavaScript">
<!--
alert("You have successfully removed the contact.");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
// -->
</script>

	
</cfoutput>