<cfoutput>

<cfparam name="orders_sortby" default="orderID">
<cfparam name="sortorder" default="ASC">


<cfquery name="OrderStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Orders
WHERE OrderID=#OrderID#
</cfquery>


<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#OrderStuff.ContactID#
</cfquery>



<cfquery name="BasketStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Basket.Quantity, Basket.UnitPrice, Basket.TotalPrice, Products.ProductName
FROM Basket, Products
<cfif OrderStuff.BasketDetails NEQ ''>
	WHERE Basket.BasketID IN (#OrderStuff.BasketDetails#)
<cfelse>
	WHERE Basket.BasketID IN (0)
</cfif>
AND Basket.ProductID=Products.ProductID
</cfquery>


<script language="JavaScript">
	<!--
	function confirmOrderDelete(aURL) {
	    if(confirm('Are you sure you want to delete this order?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="section_subheader" width="100%">#TRIM(SectionDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>


<tr>
<td class="section_header" width="100%">Order Details</td>
<td align="right" width="30"> </td>
</tr>


</table>




<table width="100%" cellpaddinig="0" cellspacing="0" border="0">
	
<tr>
<td class="normal">

<cfif #TRIM(OrderStuff.OrderStatus)# EQ 'pending'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=paid" style="color:blue;text-decoration:underline;">>> Mark as paid and notify fulfilment houses</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

<cfelseif #TRIM(OrderStuff.OrderStatus)# EQ 'Paid'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=picked" style="color:blue;text-decoration:underline;">>> Mark as picked</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

<cfelseif #TRIM(OrderStuff.OrderStatus)# EQ 'Picked'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=packed" style="color:blue;text-decoration:underline;">>> Mark as packed</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

<cfelseif #TRIM(OrderStuff.OrderStatus)# EQ 'packed'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=shipped" style="color:blue;text-decoration:underline;">>> Mark as shipped</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

<cfelseif #TRIM(OrderStuff.OrderStatus)# EQ 'shipped'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=delivered" style="color:blue;text-decoration:underline;">>> Mark as delivered</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

<cfelseif #TRIM(OrderStuff.OrderStatus)# EQ 'delivered'>
<hr width="100%" size="1" color="e2e2e2">	
	<li><a href="#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=archived" style="color:blue;text-decoration:underline;">>> Archive this order</a><br>
	<li><a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')" style="color:blue;text-decoration:underline;">>> Delete this order</a>

</cfif>
	
	<li><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=orders" style="color:blue;text-decoration:underline;"><< Back to Orders</a>


<hr width="100%" size="1" color="e2e2e2">
<br>



<strong>Order Date:</strong><br>
#Dateformat(orderstuff.OrderDate, "d-mmm-yyyy")#&nbsp; &nbsp;#Timeformat(orderstuff.OrderDate, "h:mm tt")#<br><br>


<strong>Ordered Number:</strong><br>
MKB_#NumberFormat(OrderStuff.OrderID, "0000")#<br><br>

<strong>Order Status:</strong><br>
#TRIM(OrderStuff.OrderStatus)#<br><br>

<strong>Order Type:</strong><br>
#TRIM(OrderStuff.OrderType)#<br>

<br>


<strong>Ordered by:</strong><br>
#ContactStuff.FirstName# #ContactStuff.LastName#<br>
<a href="mailto:#ContactStuff.EmailAddress#" style="color:blue;text-decoration:underline;">#ContactStuff.EmailAddress#</a><br>
<cfif #ContactStuff.WorkPhone# NEQ ''>
#ContactStuff.WorkPhone#
</cfif>

<br><br>


<strong>Shipping Address:</strong><br>

<cfif #TRIM(ContactStuff.Address1)# NEQ ''>
#TRIM(ContactStuff.Address1)#<br>
</cfif>

<cfif #TRIM(ContactStuff.Address2)# NEQ ''>
#TRIM(ContactStuff.Address2)#<br>
</cfif>

<cfif #TRIM(ContactStuff.Address3)# NEQ ''>
#TRIM(ContactStuff.Address3)#<br>
</cfif>

<cfif #TRIM(ContactStuff.City)# NEQ ''>
#TRIM(ContactStuff.City)#<br>
</cfif>

<br>






	<table width="100%" cellpadding="0" cellspacing="1" border="0">
	
	<tr bgcolor="e2e2e2">
	<td width="*"><strong>Product</strong></td>
	<td align="center" width="100"><strong>Unit Price</strong></td>
	<td width="80" align="center"><strong>Quantity</strong></td>
	<td align="right" width="100"><strong>Total Price</strong>&nbsp;&nbsp;</td>
	</tr>
	
	<cfset TotalBasketValue=0>
	
	<cfloop query="BasketStuff">
	
	<cfif #BasketStuff.Quantity# GT 0>
	
	<tr>
	<td>#TRIM(BasketStuff.ProductName)#</td>
	<td align="center">#dollarFormat(BasketStuff.UnitPrice)#</td>
	<td align="center">#BasketStuff.Quantity#</td>
	<td align="right"><strong>#dollarFormat(BasketStuff.TotalPrice)#</strong>&nbsp;&nbsp;</td>
	</tr>
	
	<cfset TotalBasketValue=(#TotalBasketValue#+#BasketStuff.TotalPrice#)>
	
	</cfif>
	
	
	</cfloop>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td>Shipping:</td>
	<td colspan="2" align="right"></td>
	<td align="right"><strong>#dollarFormat(OrderStuff.shippingprice)#</strong>&nbsp;&nbsp;</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td></td>
	<td colspan="2"></td>
	<td align="right"><strong>#dollarFormat(Evaluate(TotalBasketValue+OrderStuff.shippingprice))#</strong>&nbsp;&nbsp;</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	</table>
	<br><br>



</td>
</tr>

</table>




</cfoutput>