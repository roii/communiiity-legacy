<cfquery name="qry_groups" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GroupName
FROM ProjectGroups
ORDER BY GroupID
</cfquery>