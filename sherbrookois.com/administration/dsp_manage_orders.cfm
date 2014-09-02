<cfoutput>

<script language="JavaScript">
	<!--
	function confirmOrderDelete(aURL) {
	    if(confirm('Are you sure you want to delete this order?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

<cfparam name="orders_sortby" default="orderID">
<cfparam name="sortorder" default="ASC">


<cfinclude template="qry_orders_pending.cfm">
<cfinclude template="qry_orders_inprogress.cfm">
<cfinclude template="qry_orders_archived.cfm">



<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="section_subheader" width="100%">#TRIM(SectionDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>


<tr>
<td class="section_header" width="100%">Manage Orders</td>
<td align="right" width="30"> </td>
</tr>


</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
	
	
	<span class="normal"><strong>PENDING - AWAITING PAYMENT</strong></span>
	<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="80"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Order Number</a></span></td>
	<td width="140"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Date/Time</a></span></td>
	<td width="*"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Name</a></span></td>
	<td width="100"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.ordertype&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.ordertype&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Invoice Type</a></span></td>
	<td align="right" width="120"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Invoice Amount</a></span></td>	
	<td align="right" width="100"><span class="small">&nbsp;</span></td>
	</tr>
	
	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	
	<cfloop query="PendingOrders">
	<tr>
	<td><span class="small"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=orderdetails&orderid=#pendingorders.orderid#" style="color:blue;text-decoration:underline;">MKB_#NumberFormat(pendingorders.orderid, "0000")#</a></span></td>
	<td><span class="small">#Dateformat(pendingorders.OrderDate, "d-mmm-yyyy")#&nbsp; &nbsp;#Timeformat(pendingorders.OrderDate, "h:mm tt")#</span></td>
	<td><span class="small">#TRIM(pendingorders.firstname)# #TRIM(pendingorders.lastname)#</span></td>
	<td><span class="small">#TRIM(pendingorders.ordertype)#</span></td>
	<td align="right"><span class="small">#dollarformat(pendingorders.totalprice)#</span></td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_order_edit.cfm?orderID=#pendingorders.orderID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Order" border="0"></a>&nbsp;<a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Order" border="0"></a></td>
	</tr>
	</cfloop>
	
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>



</table><br><br>







<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
	
	
	<span class="normal"><strong>IN-PROGRESS</strong></span>
	<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="80"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Order Number</a></span></td>
	<td width="140"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Date/Time</a></span></td>
	<td width="*"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Name</a></span></td>
	<td width="100"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.orderstatus&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.orderstatus&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Order Status</a></span></td>
	<td align="right" width="120"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Invoice Amount</a></span></td>	
	<td align="right" width="100"><span class="small">&nbsp;</span></td>
	</tr>
	
	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	
	<cfloop query="inProgressOrders">
	<tr>
	<td><span class="small"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=orderdetails&orderid=#inProgressOrders.orderid#" style="color:blue;text-decoration:underline;">MKB_#NumberFormat(inProgressOrders.orderid, "0000")#</a></span></td>
	<td><span class="small">#Dateformat(inProgressOrders.OrderDate, "d-mmm-yyyy")#&nbsp; &nbsp;#Timeformat(inProgressOrders.OrderDate, "h:mm tt")#</span></td>
	<td><span class="small">#TRIM(inProgressOrders.firstname)# #TRIM(inProgressOrders.lastname)#</span></td>
	<td><span class="small">#TRIM(UCASE(inProgressOrders.orderstatus))#</span></td>
	<td align="right"><span class="small">#dollarformat(inProgressOrders.totalprice)#</span></td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_order_edit.cfm?orderID=#inProgressOrders.orderID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Order" border="0"></a>&nbsp;<a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Order" border="0"></a></td>
	</tr>
	</cfloop>
	
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table><br><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
	
	
	<span class="normal"><strong>ARCHIVED</strong></span>
	<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="80"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderID&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Order Number</a></span></td>
	<td width="140"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.OrderDate&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Date/Time</a></span></td>
	<td width="*"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=contacts.firstname,contacts.lastname&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Name</a></span></td>
	<td width="100"><!--- <span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.ordertype&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.ordertype&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Invoice Type</a></span> ---></td>
	<td align="right" width="120"><span class="small"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orders_sortby=orders.TotalPrice&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Invoice Amount</a></span></td>	
	<td align="right" width="100"><span class="small">&nbsp;</span></td>
	</tr>
	
	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	
	<cfloop query="ArchivedOrders">
	<tr>
	<td><span class="small"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=orderdetails&orderid=#ArchivedOrders.orderid#" style="color:blue;text-decoration:underline;">MKB_#NumberFormat(ArchivedOrders.orderid, "0000")#</a></span></td>
	<td><span class="small">#Dateformat(ArchivedOrders.OrderDate, "d-mmm-yyyy")#&nbsp; &nbsp;#Timeformat(ArchivedOrders.OrderDate, "h:mm tt")#</span></td>
	<td><span class="small">#TRIM(ArchivedOrders.firstname)# #TRIM(ArchivedOrders.lastname)#</span></td>
	<td><!--- <span class="small">#TRIM(ArchivedOrders.ordertype)#</span> ---></td>
	<td align="right"><span class="small">#dollarformat(ArchivedOrders.totalprice)#</span></td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_order_edit.cfm?orderID=#ArchivedOrders.orderID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Order" border="0"></a>&nbsp;<a href="javascript:confirmOrderDelete('#request.webroot#/administration/act_order_status.cfm?orderID=#orderID#&status=deleted')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Order" border="0"></a></td>
	</tr>
	</cfloop>
	
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>