<cfquery name="AllPartners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Organisations.*, Countries.Name
FROM Organisations, Countries
WHERE Organisations.OrgCatID=5
AND Organisations.CountryID=Countries.CountryID


<cfif session.search_keywords NEQ ''>
	
	<cfif session.search_field EQ 'Name'>
		AND Organisations.Organisation_Name LIKE '%#session.search_keywords#%'
	<cfelseif session.search_field EQ 'City'>
		AND Organisations.City LIKE '%#session.search_keywords#%'
	<cfelseif session.search_field EQ 'State'>
		AND Organisations.State LIKE '%#session.search_keywords#%'		
	<cfelseif session.search_field EQ 'Country'>
		AND Countries.Name LIKE '%#session.search_keywords#%'	
	<cfelseif session.search_field EQ 'Notes'>
		AND Organisations.Notes LIKE '%#session.search_keywords#%'
	</cfif>
	
</cfif>
	
	
ORDER BY #session.Partners_sortby# #session.sortorder#
</cfquery>