<cfquery name="AllCountries" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CountryID, Name
FROM Countries
ORDER BY Name
</cfquery>

<cfquery name="AllRegion" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Region ORDER BY Region
</cfquery>
