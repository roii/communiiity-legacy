<cfquery name="qry_all_maincats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MainCatID, MainCatTitle, DisplayOrder, Active
FROM SugMainCategory
WHERE Active=1
ORDER BY DisplayOrder
</cfquery>