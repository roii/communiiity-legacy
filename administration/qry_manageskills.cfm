<cfquery name="allmanageskills" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM allmanageskills
ORDER BY id DESC
</cfquery>
