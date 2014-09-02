<cfif session.Charities_sortby CONTAINS 'TotalMembers'>
	
	<cfquery name="AllCharities" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT count(Contacts.ContactID) AS TotalMembers, Organisations.OrganisationID, Organisations.Organisation_Name, Organisations.City, Organisations.PrimaryContactID, Countries.Name
	FROM Organisations, Countries, Contacts
	WHERE Organisations.Charity=1
	AND Organisations.Organisation_Status LIKE '%Active%'
	AND Organisations.CountryID=Countries.CountryID
	AND Organisations.OrganisationID=Contacts.Charity
	AND Contacts.ContactTypeID IN (1,2)
	
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
		
	GROUP BY Organisations.OrganisationID, Organisations.Organisation_Name, Organisations.City, Organisations.PrimaryContactID, Countries.Name
	ORDER BY #session.Charities_sortby# #session.sortorder#
	</cfquery>
	
<cfelse>

	<cfquery name="AllCharities" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisations.*, Countries.Name
	FROM Organisations, Countries
	WHERE Organisations.Charity=1
	AND Organisations.Organisation_Status LIKE '%Active%'
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
		
		
	ORDER BY #session.Charities_sortby# #session.sortorder#
	</cfquery>
	
</cfif>