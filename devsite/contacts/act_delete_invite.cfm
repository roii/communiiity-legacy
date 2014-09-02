
<!--- DELETE INVITATION --->
<cfquery name="DeleteInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Invitations
WHERE InvitationID=#InvitationID#
</cfquery>


<cfoutput>

<script type="text/javascript">
alert("You have successfully deleted the invitation!");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
</script>

</cfoutput>
