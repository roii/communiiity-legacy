<cfquery name="AllKids" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ContactID, DateJoined
FROM Contacts
ORDER BY ContactID
</cfquery>


<cfoutput query="AllKids">

<cfif IsDate("#DateJoined#")>
	<cfquery name="UpdateContacts" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	UPDATE Contacts
	SET DateVerified=#CreateODBCDateTime(DateJoined)#
	WHERE ContactID=#ContactID#
	</cfquery>
</cfif>

</cfoutput>