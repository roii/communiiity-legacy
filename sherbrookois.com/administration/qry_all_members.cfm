<!--- SUPER SEARCH --->
<cfif IsDefined("session.ShowEverything") AND session.ShowEverything EQ 1>
	
	<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT contactid, contactTypeID, contactstatus, datejoined, firstname, lastname, mobilephone, emailaddress, dateofbirth, ScreenName, referralcode, CountryID, DateVerified
	FROM Contacts
	
	<cfif session.search_keywords NEQ ''>
		
		WHERE FirstName LIKE '%#session.search_keywords#%'
		OR LastName LIKE '%#session.search_keywords#%'
		OR ScreenName LIKE '%#session.search_keywords#%'
		OR EmailAddress LIKE '%#session.search_keywords#%'
		OR City LIKE '%#session.search_keywords#%'
		
	</cfif>
	
	ORDER BY #TRIM(session.kids_sortby)# #session.sortorder#
	</cfquery>
	
<cfelse>
	
	<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT contactid, contactTypeID, contactstatus, datejoined, firstname, lastname, mobilephone, emailaddress, dateofbirth, ScreenName, referralcode, CountryID, DateVerified
	FROM Contacts
	WHERE ContactTypeID IN (1,2)
	AND ContactStatus <> 'deleted'
	
	<cfif session.ShowPending EQ 'no'>
		AND ContactStatus <> 'pending'
	</cfif>
	
	<cfif TRIM(session.search_keywords) NEQ ''>
		
		<cfif session.search_field EQ 'FirstName'>
			AND FirstName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'Surname'>
			AND LastName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'ScreenName'>
			AND ScreenName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'Email'>
			AND EmailAddress LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'City'>
			AND City LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'mobile'>
			AND mobilePhone LIKE '%#session.search_keywords#%'
		</cfif>
		
	</cfif>
		
	ORDER BY #TRIM(session.kids_sortby)# #session.sortorder#
	</cfquery>

</cfif>	


<cfquery name="TotalKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.* FROM Contacts
WHERE Contacts.ContactTypeID IN (1,2)
AND Contacts.ContactStatus <> 'deleted'
 </cfquery>

<cfquery name="TotalKidsConfirmed" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.* FROM Contacts 
WHERE Contacts.ContactStatus = 'Active'
AND Contacts.ContactTypeID IN (1,2)
</cfquery>
