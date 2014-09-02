<cfquery name="qry_dash_points_earned" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TOP 3 Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName
FROM contacts_benchmarking, Contacts
WHERE contacts_benchmarking.ContactID=Contacts.ContactID
ORDER BY contacts_benchmarking.PointsEarned DESC
</cfquery>