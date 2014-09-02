<cfquery name="UpdateOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Orders
SET OrderStatus='#status#'

<cfif #status# EQ 'paid'>
,
PaidDate=#localDateTime#
</cfif>


WHERE OrderID=#OrderID#
</cfquery>


<cfif #status# EQ 'deleted'>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=orders">

<cfelse>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=orderdetails&orderID=#orderID#">

</cfif>