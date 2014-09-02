<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, DateJoined
FROM Contacts
ORDER BY ContactID
</cfquery>


<cfoutput query="AllKids">

<cfif IsDate("#DateJoined#")>
	<cfquery name="UpdateContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET DateVerified=#CreateODBCDateTime(DateJoined)#
	WHERE ContactID=#ContactID#
	</cfquery>
</cfif>

</cfoutput>