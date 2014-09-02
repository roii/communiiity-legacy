<cfquery name="qry_promos" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM promocodes 
ORDER BY ExpireDate DESC
</cfquery>