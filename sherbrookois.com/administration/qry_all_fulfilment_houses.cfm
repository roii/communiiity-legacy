<!--- <cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.*, Count(KidClientLinks.KidClientLinkID) AS ClientCount
FROM Contacts, KidClientLinks
WHERE Contacts.ContactType='kid'
AND Contacts.ContactID=KidClientLinks.KidID


<cfif #deletedmode# EQ 'hide'>
AND Contacts.ContactStatus <> 'deleted'
</cfif>

ORDER BY #TRIM(kids_sortby)# #sortorder#
</cfquery> --->


<cfquery name="allhouses" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Fulfilmenthouses
ORDER BY #TRIM(houses_sortby)# #sortorder#
</cfquery>