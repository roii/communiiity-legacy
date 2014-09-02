<cfoutput>

<cfparam name="session.purchases_sortby" default="StartDate">
	<cfif IsDefined("purchases_sortby")>
		<cfset session.purchases_sortby = purchases_sortby>
	</cfif>

<cfparam name="session.purchases_sortorder" default="DESC">
	<cfif IsDefined("purchases_sortorder")>
		<cfset session.purchases_sortorder = purchases_sortorder>
	</cfif>

<cfparam name="session.filter_TransactionStatus" default="ALL">
	<cfif IsDefined("filter_TransactionStatus")>
		<cfset session.filter_TransactionStatus = filter_TransactionStatus>
	</cfif>

<cfparam name="session.filter_TransactionType" default="ALL">
	<cfif IsDefined("filter_TransactionType")>
		<cfset session.filter_TransactionType = filter_TransactionType>
	</cfif>

<cfparam name="session.filter_TransactionCurrency" default="ALL">
	<cfif IsDefined("filter_TransactionCurrency")>
		<cfset session.filter_TransactionCurrency = filter_TransactionCurrency>
	</cfif>

<cfparam name="session.filter_fromdate" default="">
	<cfif IsDefined("filter_fromdate")>
		<cfset from_date = DateFormat(form.filter_fromdate, "d-mmm-yyyy")>
		<cfset session.filter_fromdate = from_date>
	</cfif>

<cfparam name="session.filter_todate" default="">
	<cfif IsDefined("filter_todate")>
		<cfset to_date = DateFormat(form.filter_todate, "d-mmm-yyyy")>
		<cfset session.filter_todate = to_date>
	</cfif>

<cfparam name="session.Purchases_StartRow" default="1">
	<cfif isdefined("Purchases_StartRow")>	
		<cfset session.Purchases_StartRow = Purchases_StartRow>
	</cfif>
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Purchases_MaxRows" default="50">
</cflock>

<cfif isdefined("Purchases_MaxRows")>	
	<cfset session.Purchases_MaxRows = Purchases_MaxRows>
</cfif>


<script language="JavaScript">
<!--
function confirmPurchaseDelete(aURL) {
    if(confirm('Are you sure you want to delete this points purchase transaction?')) {
      location.href = aURL;
    }
  }
//-->
</script>
	
	
<cfquery name="qry_all_purchases" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM PurchasePoints
WHERE TransactionID <> 0

<cfif session.filter_TransactionStatus NEQ 'ALL'>
	AND TransactionStatus LIKE '%#session.filter_TransactionStatus#%'
</cfif>

<cfif session.filter_TransactionType NEQ 'ALL'>
	AND TransactionType LIKE '%#session.filter_TransactionType#%'
</cfif>

<cfif session.filter_TransactionCurrency NEQ 'ALL'>
	AND TransactionCurrency LIKE '%#session.filter_TransactionCurrency#%'
</cfif>

<cfif IsDate("#session.filter_fromdate#") AND IsDate("#session.filter_todate#")>
	AND StartDate BETWEEN ('#DateFormat(session.filter_fromdate, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(session.filter_todate, 'mm/dd/yyyy')# 23:59:59')
</cfif>

ORDER BY #session.purchases_sortby# #session.purchases_sortOrder#
</cfquery>	


<!--- SET THE purchases_endrow VALUE --->
<cfif session.Purchases_MaxRows NEQ 'ALL'>	
	<cfif qry_all_purchases.RecordCount GT (session.Purchases_StartRow + session.Purchases_MaxRows) - 1>
		<cfset purchases_endrow = session.Purchases_StartRow + session.Purchases_MaxRows - 1>
	<cfelse>
		<cfset purchases_endrow = qry_all_purchases.RecordCount>
	</cfif>	
<cfelse>
	<cfset purchases_endrow = qry_all_purchases.RecordCount>	
</cfif>	

<!--- SET THE PREV VALUE --->
<cfif session.Purchases_StartRow GT session.Purchases_MaxRows>
	<cfset prev = session.Purchases_StartRow - session.Purchases_MaxRows>	
<cfelse>
	<cfset prev = session.Purchases_StartRow>	
</cfif>	

<!--- SET THE NEXT VALUE --->
<cfif purchases_endrow LT qry_all_purchases.RecordCount>
	<cfset next = (purchases_endrow + 1)>	
<cfelse>
	<cfset next = session.Purchases_StartRow>	
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.Purchases_MaxRows NEQ 'ALL'>	
	<cfset NumberCount=(qry_all_purchases.RecordCount / session.Purchases_MaxRows)>
	<cfset PurchasesNumberCount = Ceiling(NumberCount)>	
<cfelse>	
	<cfset PurchasesNumberCount=1>		
</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE POINT PURCHASES</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form method="post" action="#request.webroot#/index.cfm" name="filterform">

<input type="hidden" name="fuseaction" value="administration">
<input type="hidden" name="fusesubaction" value="pointspurchases">

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td colspan="2" style="font-size:11px;">From: <input type="text" name="filter_fromdate" readonly class="whitefield" style="width:80px;" value="#session.filter_fromdate#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.filterform.filter_fromdate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a> &nbsp;&nbsp; To: <input type="text" name="filter_todate" readonly class="whitefield" style="width:80px;" value="#session.filter_todate#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.filterform.filter_todate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Filter: <select class="whitefield" name="filter_TransactionStatus">
<option value="ALL"<cfif session.filter_TransactionStatus EQ 'ALL'> selected</cfif>>-- All Status --</option>
<option value="pending"<cfif session.filter_TransactionStatus EQ 'pending'> selected</cfif>>Pending</option>
<option value="authorised"<cfif session.filter_TransactionStatus EQ 'authorised'> selected</cfif>>Authorised</option>
</select> <select class="whitefield" name="filter_TransactionType">
<option value="ALL"<cfif session.filter_TransactionType EQ 'ALL'> selected</cfif>>-- All Types --</option>
<option value="bank"<cfif session.filter_TransactionType EQ 'bank'> selected</cfif>>Bank</option>
<option value="paypal"<cfif session.filter_TransactionType EQ 'paypal'> selected</cfif>>PayPal</option>
</select> <select class="whitefield" name="filter_TransactionCurrency">
<option value="ALL"<cfif session.filter_TransactionCurrency EQ 'ALL'> selected</cfif>>-- All $ --</option>
<option value="nzd"<cfif session.filter_TransactionCurrency EQ 'nzd'> selected</cfif>>NZD</option>
<option value="usd"<cfif session.filter_TransactionCurrency EQ 'usd'> selected</cfif>>USD</option>
</select> <input type="submit" class="whitefield" value="Run Search Filters &raquo;"></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

</form>



<cfif qry_all_purchases.RecordCount>

	<tr>
	<td colspan="2" align="right" style="font-size:11px;">::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_MaxRows=20&Purchases_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_MaxRows=50&Purchases_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_MaxRows=100&Purchases_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_MaxRows=ALL&Purchases_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</tr>
	
	<tr>
	<td colspan="2">
	
	<hr width="100%" size="1" color="e2e2e2">
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td style="font-size:11px;" width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=DollarValue&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Reference</strong></a></td>
		<td style="font-size:11px;" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=ScreenName&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Member</strong></a></td>
		<td style="font-size:11px;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=StartDate&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Start Date</strong></a></td>
		<td style="font-size:11px;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=AuthoriseDate&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Auth. Date</strong></a></td>
		<td style="font-size:11px;" width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=PointsAmount&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Points</strong></a></td>
		<td style="font-size:11px;" width="100"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=DollarValue&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"><br><strong>Price</strong></a></td>
		<td style="font-size:11px;" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=TransactionType&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Type</strong></a></td>
		<td style="font-size:11px;" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&purchases_sortby=TransactionStatus&purchases_sortorder=<cfif session.purchases_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Status</strong></a></td>
		<td align="right" width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		<cfset total_confirmed_points = 0>
		<cfset total_confirmed_NZdollars = 0>
		<cfset total_confirmed_USdollars = 0>
		
		<cfset total_pending_points = 0>
		<cfset total_pending_NZdollars = 0>
		<cfset total_pending_USdollars = 0>
		
		<cfloop query="qry_all_purchases" startrow="#session.Purchases_StartRow#" endrow="#purchases_endrow#">
		
		<cfset this_TransactionID = qry_all_purchases.TransactionID>
		<cfset this_TransactionType = qry_all_purchases.TransactionType>
		<cfset this_TransactionStatus = qry_all_purchases.TransactionStatus>
		<cfset this_StartDate = qry_all_purchases.StartDate>
		<cfset this_AuthoriseDate = qry_all_purchases.AuthoriseDate>
		<cfset this_PointsAmount = qry_all_purchases.PointsAmount>
		<cfset this_DollarValue = qry_all_purchases.DollarValue>
		<cfset this_TransactionCurrency = qry_all_purchases.TransactionCurrency>
		<cfset this_Identifier = qry_all_purchases.Identifier>
		<cfset this_ContactID = qry_all_purchases.ContactID>
		<cfset this_ScreenName = qry_all_purchases.ScreenName>
		
		<cfif IsNumeric("#this_PointsAmount#")>
			<cfif this_TransactionStatus CONTAINS 'Authorised'>
				<cfset total_confirmed_points = (total_confirmed_points + this_PointsAmount)>
			<cfelse>
				<cfset total_pending_points = (total_pending_points + this_PointsAmount)>
			</cfif>	
		</cfif>
		
		<cfif IsNumeric("#this_DollarValue#") AND this_TransactionCurrency CONTAINS 'NZD'>
			<cfif this_TransactionStatus CONTAINS 'Authorised'>
				<cfset total_confirmed_NZdollars = (total_confirmed_NZdollars + this_DollarValue)>
			<cfelse>
				<cfset total_pending_NZdollars = (total_pending_NZdollars + this_DollarValue)>
			</cfif>		
		<cfelseif IsNumeric("#this_DollarValue#") AND this_TransactionCurrency CONTAINS 'USD'>
			<cfif this_TransactionStatus CONTAINS 'Authorised'>
				<cfset total_confirmed_USdollars = (total_confirmed_USdollars + this_DollarValue)>
			<cfelse>
				<cfset total_pending_USdollars = (total_pending_USdollars + this_DollarValue)>
			</cfif>	
		</cfif>
		
				
		<tr>
		<td style="font-size:11px;color:##444444;" valign="top"><strong>#UCASE(TRIM(this_Identifier))#</strong></td>
		<td style="font-size:11px;" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(this_ScreenName)#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(this_ScreenName)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(this_ScreenName)#</strong></td>
		<td style="font-size:11px;" valign="top">#DateFormat(this_StartDate, "dd/mm/yy")#&nbsp;&nbsp;#TimeFormat(this_StartDate, "HH:MM")#</td>
		<td style="font-size:11px;" valign="top">#DateFormat(this_AuthoriseDate, "dd/mm/yy")#&nbsp;&nbsp;#TimeFormat(this_AuthoriseDate, "HH:MM")#</td>
		<td style="font-size:11px;" valign="top">#INT(this_PointsAmount)#</td>
		<td style="font-size:11px;" valign="top">#this_TransactionCurrency# #DollarFormat(this_DollarValue)#</td>
		<td style="font-size:11px;" valign="top">#this_TransactionType#</td>
		<td style="font-size:11px;" valign="top">#this_TransactionStatus#</td>
		<td align="right"><cfif this_transactionstatus CONTAINS 'pending'><a href="#request.webroot#/administration/act_authorise_pointpurchase.cfm?TransactionID=#this_TransactionID#"><img src="#request.imageroot#/but_authorise.gif" width="26" height="10" alt="Authorise Purchase and Transfer Points" border="0"></a>&nbsp;<a href="javascript:confirmPurchaseDelete('#request.webroot#/administration/act_delete_pointpurchase.cfm?TransactionID=#this_TransactionID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Purchase" border="0"></a></cfif></td>
		</tr>
		
		<tr>
		<td colspan="9" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
			
		</cfloop>
		
		
		
		<tr>
		<td colspan="9" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="2" bgcolor="##444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:11px;color:##444444;" colspan="4"><strong>CONFIRMED</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>#INT(total_confirmed_points)# pts</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>NZD #DollarFormat(total_confirmed_NZdollars)#</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>USD #DollarFormat(total_confirmed_USdollars)#</strong></td>
		<td></td>
		<td></td>
		</tr>
		
		<tr>
		<td colspan="9" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="2" bgcolor="##444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:11px;color:##444444;" colspan="4"><strong>PENDING</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>#INT(total_pending_points)# pts</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>NZD #DollarFormat(total_pending_NZdollars)#</strong></td>
		<td style="font-size:11px;color:##444444;"><strong>USD #DollarFormat(total_pending_USdollars)#</strong></td>
		<td></td>
		<td></td>
		</tr>
		
		<tr>
		<td colspan="9" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="2" bgcolor="##444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="9" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		</table>
		
		
		<div align="right"><cfif session.Purchases_StartRow GT session.Purchases_MaxRows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_StartRow=#prev#">Prev Page</a> | </cfif><cfif purchases_endrow LT qry_all_purchases.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_StartRow=#next#">Next Page</a> &gt;</cfif><cfif session.Purchases_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#PurchasesNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Purchases_MaxRows*NumberCount-session.Purchases_MaxRows+1)><cfif thisStartRow EQ session.Purchases_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Purchases_StartRow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Purchases_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ PurchasesNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>
	
	
	</td>
	</tr>
	
	
<cfelse>

<tr>
<td colspan="2" style="color:##444444;"><br><strong>NO TRANSACTIONS WERE FOUNDING USING FILTER SELECTION ABOVE</strong><br><br>

<hr width="100%" size="1" color="e2e2e2"></td>
</tr>

</cfif>

</table>

</cfoutput>