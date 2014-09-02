<cfquery name="RemoveRoleLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM ContactRoles
</cfquery>

<cfquery name="allcontacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE ContactStatus <> 'Deleted'
</cfquery>

<cfloop query="allcontacts">
<cfset this_contact = allcontacts.contactID>

<cfquery name="updatecontacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ContactRoles(ContactID,RoleID)
VALUES(#this_contact#, 4)
</cfquery>

</cfloop>