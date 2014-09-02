<cfquery name="AllAdministrators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Administrator
ORDER BY LastName, FirstName
</cfquery>
