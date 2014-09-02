<cfquery name="qry_groups" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT GroupName
FROM ProjectGroups
ORDER BY GroupID
</cfquery>