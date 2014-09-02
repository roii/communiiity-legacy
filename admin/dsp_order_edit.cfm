
<cfoutput>

<cfquery name="OrderStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Orders
WHERE OrderID=#OrderID#
</cfquery>


<cfquery name="BasketStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Basket.*, Products.ProductName
FROM Basket, Products
WHERE Basket.BasketID IN (#OrderStuff.BasketDetails#)
AND Basket.ProductID=Products.ProductID
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit Order</title>
<cfinclude template="../templates/styles.cfm">



</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Order Details</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<cfform method="post" action="#request.webroot#/admin/act_order_edit.cfm" name="FileAddForm">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="OrderID" value="#OrderID#">
	
	
	<input type="hidden" name="BasketItemCount" value="#BasketStuff.RecordCount#">

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver">
	<strong>ORDER DETAILS</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Order Status</td>
	<td class="normal" valign="top"><select name="OrderStatus" class="whitefield">
	<option value="pending"<cfif #TRIM(orderstuff.orderstatus)# EQ 'pending'> selected</cfif>>Pending
	<option value="paid"<cfif #TRIM(orderstuff.orderstatus)# EQ 'paid'> selected</cfif>>Paid
	<option value="picked"<cfif #TRIM(orderstuff.orderstatus)# EQ 'picked'> selected</cfif>>Picked
	<option value="packed"<cfif #TRIM(orderstuff.orderstatus)# EQ 'packed'> selected</cfif>>Packed
	<option value="Shipped"<cfif #TRIM(orderstuff.orderstatus)# EQ 'Shipped'> selected</cfif>>Shipped
	<option value="Delivered"<cfif #TRIM(orderstuff.orderstatus)# EQ 'Delivered'> selected</cfif>>Delivered
	<option value="Archived"<cfif #TRIM(orderstuff.orderstatus)# EQ 'Archived'> selected</cfif>>Archived
	</select></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Order Date</td>
	<td class="normal" valign="top"><input type="text" class="whitefield" size="55" name="OrderDate" value="#dateformat(orderstuff.orderdate, "d-mmm-yyyy")#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Paid Date</td>
	<td class="normal" valign="top"><input type="text" class="whitefield" size="55" name="PaidDate" value="#dateformat(orderstuff.PaidDate, "d-mmm-yyyy")#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Shipped Date</td>
	<td class="normal" valign="top"><input type="text" class="whitefield" size="55" name="ShippedDate" value="#dateformat(orderstuff.ShippedDate, "d-mmm-yyyy")#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Delivered Date</td>
	<td class="normal" valign="top"><input type="text" class="whitefield" size="55" name="DeliveredDate" value="#dateformat(orderstuff.DeliveredDate, "d-mmm-yyyy")#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Shipping Price</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="55" name="shipping" value="#DollarFormat(OrderStuff.shippingprice)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="5" border="0"></td>
	<td colspan="2"> </td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Total Price</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="55" name="TotalPrice" value="#DollarFormat(OrderStuff.TotalPrice)#"></td>
	</tr>		
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Notes</td>
	<td Class="normal" valign="top"><textarea class="whitefield" cols="55" rows="4" name="notes">#TRIM(OrderStuff.Notes)#</textarea></td>
	</tr>		
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><br><hr width="100%" size="1" color="silver">
	<strong>BASKET ITEMS</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<cfloop query="basketStuff">
	
	<input type="hidden" name="basketID_#basketstuff.currentrow#" value="#basketStuff.basketID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Product</td>
	<td Class="normal" valign="top">#TRIM(basketStuff.productname)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Quantity</td>
	<td Class="normal" valign="top"><input type="text" name="quantity_#basketstuff.currentrow#" class="whitefield" size="55" value="#basketstuff.quantity#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Unit Price</td>
	<td Class="normal" valign="top"><input type="text" name="unitprice_#basketstuff.currentrow#" class="whitefield" size="55" value="#dollarformat(basketStuff.unitprice)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Total Price</td>
	<td Class="normal" valign="top"><input type="text" name="totalprice_#basketstuff.currentrow#" class="whitefield" size="55" value="#dollarformat(basketStuff.totalprice)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</cfform>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


