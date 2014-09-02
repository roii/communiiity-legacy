<cfquery name="inprogressOrders" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Orders.*, Contacts.FirstName, Contacts.LastName
FROM Orders, Contacts
WHERE Orders.OrderStatus<>'pending'
AND Orders.OrderStatus<>'archived'
AND Orders.OrderStatus<>'deleted'
AND Orders.ContactID=Contacts.ContactID
ORDER BY #orders_sortby#
</cfquery>