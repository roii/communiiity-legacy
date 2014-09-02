<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#session.UserID#
</cfquery>

<cfif ContactDetails.recordcount GT 0>

<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Name
FROM Countries
WHERE CountryID=#ContactDetails.CountryID#
</cfquery>

</cfif>