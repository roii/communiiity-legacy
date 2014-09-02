<cfquery name="CurrentClients" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * 
FROM Contacts, kidclientlinks
WHERE contacts.contactid = kidclientlinks.clientid
AND kidclientlinks.kidid=#session.UserID#
ORDER BY contacts.firstname,contacts.lastname
</cfquery>