<cfquery name="AllShoppers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactType='shopper'

<cfif #deletedmode# EQ 'hide'>
AND ContactStatus <> 'deleted'
</cfif>

ORDER BY #TRIM(shoppers_sortby)# #sortorder#
</cfquery>

<cfquery name="TotalShoppers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactType='shopper'
</cfquery>


<cfquery name="TotalShoppersConfirmed" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Contacts WHERE ContactType='shopper' and ContactStatus='Active'
</cfquery>