<cfquery name="RemoveRoleLinks" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
DELETE
FROM ContactRoles
</cfquery>

<cfquery name="allcontacts" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ContactID
FROM Contacts
WHERE ContactStatus <> 'Deleted'
</cfquery>

<cfloop query="allcontacts">
<cfset this_contact = allcontacts.contactID>

<cfquery name="updatecontacts" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
INSERT INTO ContactRoles(ContactID,RoleID)
VALUES(#this_contact#, 4)
</cfquery>

</cfloop>