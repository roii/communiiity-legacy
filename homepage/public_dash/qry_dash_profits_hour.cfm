<cfquery name="qry_dash_profits_hour" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TOP 3 contacts.contactID, contacts.firstname, contacts.Screenname
FROM contacts_benchmarking, Contacts
WHERE contacts_benchmarking.ContactID=Contacts.ContactID
ORDER BY HrProfits DESC
</cfquery>