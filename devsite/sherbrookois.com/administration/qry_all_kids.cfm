<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.contactid, contacts.contactType, contacts.contactstatus, contacts.parentconfirmed, contacts.datejoined, contacts.title, contacts.firstname, contacts.lastname, contacts.nickname, contacts.gender, contacts.city, contacts.regionID, contacts.workphone, contacts.mobilephone, contacts.homephone, contacts.emailaddress,
contacts.dateofbirth, contacts.parentsname, contacts.parentsemail, Contacts.ScreenName, Countries.Name
FROM Contacts, Countries
WHERE Contacts.ContactTypeID IN (1,2)

<cfif deletedmode EQ 'hide'>
	AND Contacts.ContactStatus <> 'deleted'
</cfif>

AND Contacts.CountryID=Countries.CountryID

<cfif session.search_keywords NEQ ''>
	
	<cfif session.search_field EQ 'FirstName'>
		AND Contacts.FirstName LIKE '%#session.search_keywords#%'
	<cfelseif session.search_field EQ 'Surname'>
		AND Contacts.LastName LIKE '%#session.search_keywords#%'
	<cfelseif session.search_field EQ 'City'>
		AND Contacts.City LIKE '%#session.search_keywords#%'		
	<cfelseif session.search_field EQ 'Country'>
		AND Countries.Name LIKE '%#session.search_keywords#%'
	</cfif>
	
</cfif>
	
	
GROUP BY Contacts.contactid, contacts.contactType, contacts.contactstatus, contacts.parentconfirmed, contacts.datejoined, contacts.title, contacts.firstname, contacts.lastname, contacts.nickname, contacts.gender, contacts.city, contacts.regionID, contacts.workphone, contacts.mobilephone, contacts.homephone, contacts.emailaddress,
contacts.dateofbirth, contacts.parentsname, contacts.parentsemail, Contacts.ScreenName, Countries.Name
ORDER BY #TRIM(session.kids_sortby)# #session.sortorder#
</cfquery>


<cfquery name="TotalKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.*
FROM Contacts
WHERE Contacts.ContactType='kid'
</cfquery>

<cfquery name="TotalKidsConfirmed" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.* FROM Contacts WHERE Contacts.ContactType='kid' and Contacts.ContactStatus = 'Active'
</cfquery>
