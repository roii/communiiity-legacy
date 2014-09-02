<cfif session.schools_sortby CONTAINS 'TotalMembers'>

	<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT count(Contacts.ContactID) AS TotalMembers, Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	FROM Schools, Countries, Contacts
	WHERE Schools.CountryID=Countries.CountryID
	AND Schools.SchoolID=Contacts.SchoolID
	AND Contacts.ContactTypeID IN (1,2)
	
	
	<cfif session.search_keywords NEQ ''>
		
		<cfif session.search_field EQ 'Name'>
			AND Schools.SchoolName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'City'>
			AND Schools.City LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'State'>
			AND Schools.State LIKE '%#session.search_keywords#%'		
		<cfelseif session.search_field EQ 'Country'>
			AND Countries.Name LIKE '%#session.search_keywords#%'	
		<cfelseif session.search_field EQ 'Notes'>
			AND Schools.Notes LIKE '%#session.search_keywords#%'
		</cfif>
		
	</cfif>
		
		
	GROUP BY Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	ORDER BY #session.schools_sortby# #session.sortorder#
	</cfquery>
	
	
<cfelse>

	
	<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	FROM Schools, Countries
	WHERE Schools.CountryID=Countries.CountryID
	
	
	
	<cfif session.search_keywords NEQ ''>
		
		<cfif session.search_field EQ 'Name'>
			AND Schools.SchoolName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'City'>
			AND Schools.City LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'State'>
			AND Schools.State LIKE '%#session.search_keywords#%'		
		<cfelseif session.search_field EQ 'Country'>
			AND Countries.Name LIKE '%#session.search_keywords#%'	
		<cfelseif session.search_field EQ 'Notes'>
			AND Schools.Notes LIKE '%#session.search_keywords#%'
		</cfif>
		
	</cfif>
		
		
	GROUP BY Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	ORDER BY #session.schools_sortby# #session.sortorder#
	</cfquery>

</cfif>


<cfquery name="TotalSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Schools.SchoolID
FROM Schools
WHERE SchoolStatus <> 'deleted'
</cfquery>
