<cfquery name="UpdateOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Orders
SET OrderStatus='#form.OrderStatus#',

<cfif IsDate("#form.orderdate#")>
orderdate=#createODBCDateTime(form.orderdate)#,
</cfif>

<cfif IsDate("#form.paiddate#")>
PaidDate=#createODBCDateTime(form.paiddate)#,
</cfif>

<cfif IsDate("#form.shippeddate#")>
shippeddate=#createODBCDateTime(form.shippeddate)#,
</cfif>

<cfif IsDate("#form.delivereddate#")>
delivereddate=#createODBCDateTime(form.delivereddate)#,
</cfif>

shippingprice=#Replace("#form.shipping#", "$", "")#,
totalprice=#Replace("#form.totalprice#", "$", "")#,
notes='#TRIM(form.notes)#'

WHERE OrderID=#form.OrderID#
</cfquery>


<cfloop from="1" to="#form.BasketItemCount#" index="loopcount">


<cfquery name="updatebasketitem" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Basket
SET Quantity=#evaluate("form.quantity_" & loopcount)#,
UnitPrice=#evaluate("form.UnitPrice_" & loopcount)#,
TotalPrice=#evaluate("form.TotalPrice_" & loopcount)#
WHERE BasketID=#evaluate("form.basketID_" & loopcount)#
</cfquery>


</cfloop>






<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orderID=#orderID#')"></body>
	
	
	</cfoutput>
	