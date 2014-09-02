<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.FromDate_day" default="#DateFormat(DateAdd('d', -30, localDateTime), "d")#">
	<cfparam name="session.FromDate_month" default="#DateFormat(DateAdd('d', -30, localDateTime), "mm")#">
	<cfparam name="session.FromDate_year" default="#DateFormat(DateAdd('d', -30, localDateTime), "yyyy")#">
	<cfparam name="session.ToDate_day" default="#dateformat(DateAdd('d', 1, localDateTime), 'd')#">
	<cfparam name="session.ToDate_month" default="#dateformat(DateAdd('d', 1, localDateTime), 'mm')#">
	<cfparam name="session.ToDate_year" default="#dateformat(DateAdd('d', 1, localDateTime), 'yyyy')#">	
	<cfparam name="session.current_account" default="points">
	<cfparam name="session.Transactions_MaxRows" default="20">
	<cfparam name="session.search_keywords" default="">
	<cfparam name="session.This_ContactID" default="0">
	<cfparam name="session.search_credit" default="1">
	<cfparam name="session.search_debit" default="1">
	<cfparam name="session.Transactions_StartRow" default="1">
</cflock>
	
<cfif isdefined("form.FromDate_day")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.FromDate_day = form.FromDate_day>
	</cflock>
</cfif>
	
<cfif isdefined("form.FromDate_month")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.FromDate_month = form.FromDate_month>
	</cflock>
</cfif>

<cfif isdefined("form.FromDate_year")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.FromDate_year = form.FromDate_year>
	</cflock>
</cfif>	

<cfif isdefined("form.ToDate_day")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.ToDate_day = form.ToDate_day>
	</cflock>
</cfif>

<cfif isdefined("form.ToDate_month")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.ToDate_month = form.ToDate_month>
	</cflock>
</cfif>

<cfif isdefined("form.ToDate_year")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.ToDate_year = form.ToDate_year>
	</cflock>
</cfif>	

<cfif isdefined("Transactions_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Transactions_StartRow = Transactions_StartRow>
	</cflock>
</cfif>	

<cfif isdefined("Transactions_MaxRows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Transactions_MaxRows = Transactions_MaxRows>
	</cflock>
</cfif>	
	
<cfif IsDefined("current_account")>
	<cfset session.current_account=current_account>
</cfif>

<cfif IsDefined("search_keywords")>
	<cfset session.search_keywords=search_keywords>
</cfif>

<cfif IsDefined("This_ContactID")>
	<cfset session.This_ContactID=This_ContactID>
</cfif>

<cfif IsDefined("form.search_credit") AND form.search_credit CONTAINS 1>
	<cfset session.search_credit=1>
<cfelseif IsDefined("form.search_credit") AND form.search_credit CONTAINS 0>
	<cfset session.search_credit=0>
</cfif>

<cfif IsDefined("form.search_debit") AND form.search_debit CONTAINS 1>
	<cfset session.search_debit=1>
<cfelseif IsDefined("form.search_debit") AND form.search_debit CONTAINS 0>
	<cfset session.search_debit=0>
</cfif>


<script language="JavaScript">
	<!--
	function confirmTransactionDelete(aURL) {
	    if(confirm('Are you sure you want to delete this transaction?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

<script language="JavaScript"><!--
function checkdate(form) {

var theday = form.FromDate_day.value;
var themonth = form.FromDate_month.value;
var theyear = form.FromDate_year.value;

var theday2 = form.ToDate_day.value;
var themonth2 = form.ToDate_month.value;
var theyear2 = form.ToDate_year.value;

function y2k(number) { return (number < 1000) ? number + 1900 : number; }

function isDate (day,month,year) {
    var today = new Date();
    year = ((!year) ? y2k(today.getYear()):year);
    month = ((!month) ? today.getMonth():month-1);
    if (!day) return false
    var test = new Date(year,month,day);
    if ( (y2k(test.getYear()) == year) &&
         (month == test.getMonth()) &&
         (day == test.getDate()) )
        return true;
    else
        return false
}


if (isDate(theday,themonth,theyear) & isDate(theday2,themonth2,theyear2)) {
    form.submit();
	}
	
else {
alert("The date range you have entered contains an invalid date.");
return;

}
//-->
}
</script>

<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, ScreenName
FROM Contacts
WHERE ContactTypeID IN (1,2,4,5,6,7)
AND ContactStatus = 'active'
ORDER BY LastName, FirstName
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE MONEY</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table border="0" cellpadding="0" cellspacing="2" width="100%">


<tr>
<td width="100%" class="small"><a href="#request.webroot#/admin/dsp_kids_transaction_add.cfm" target="addTransaction" ONCLICK="fdbackwindow=window.open ('','addTransaction','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A TRANSACTION &raquo;</strong></a><br><br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="e2e2e2">
	
	<form method="post" action="#request.webroot#/index.cfm">
	<input type="hidden" name="Transactions_StartRow" value="1">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
    <input type="hidden" name="ShowSearch" value="1">
	<tr>
	<td style="padding-top:5px;padding-right:5px;padding-bottom:5px;" align="right">Member:</td>
	<td style="padding-top:5px;padding-right:5px;padding-bottom:5px;"><select name="This_ContactID" class="whitefield">
	<option value="0"<cfif session.This_ContactID EQ 0> selected</cfif>>DISPLAY ALL KIDS
	<option value="0">-------------------------------
	<cfloop query="AllKids">
	<cfif AllKids.ContactID NEQ 0>
	<option value="#AllKids.ContactID#"<cfif session.This_ContactID EQ AllKids.ContactID> selected</cfif>>#UCASE(TRIM(AllKids.lastName))#, #TRIM(AllKids.firstName)# (#TRIM(AllKids.ScreenName)#)
	</cfif>
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="white"> </td>
	</tr>
	
	<tr>
	<td class="small" style="padding-top:5px;padding-bottom:5px;padding-right:5px;" align="right">Date Range:</td>
	<td style="padding-top:5px;padding-bottom:5px;padding-right:5px;"><select name="FromDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif session.FromDate_day EQ LoopCount> selected</cfif>>#loopcount#</cfloop></select> <select name="FromDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif session.FromDate_month EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="FromDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif session.FromDate_year EQ '#yearloopcount#'> selected</cfif>>#yearloopcount#</cfloop></select>&nbsp;&nbsp;&nbsp; To: <select name="ToDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif session.ToDate_day EQ LoopCount> selected</cfif>>#loopcount#</cfloop></select> <select name="ToDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif session.ToDate_month EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="ToDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif session.ToDate_year EQ '#yearloopcount#'> selected</cfif>>#yearloopcount#</cfloop></select></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="white"> </td>
	</tr>
	
	<input name="search_debit" type="hidden" value="0">
	<input name="search_credit" type="hidden" value="0">
	
	<tr>
	<td style="padding-top:5px;padding-right:5px;padding-bottom:5px;" align="right">Keywords:</td>
	<td style="padding-top:5px;padding-right:5px;padding-bottom:5px;"><input type="text" name="search_keywords" class="whitefield" style="width:200px;" value="#session.search_keywords#"> <input name="search_credit" type="checkbox" class="whitefield" value="1"<cfif session.search_credit CONTAINS 1> checked</cfif>>Credits &nbsp;&nbsp; <input name="search_debit" type="checkbox" class="whitefield" value="1"<cfif session.search_debit CONTAINS 1> checked</cfif>>Debits <input type="submit" class="whitefield" value="Report &raquo;" style="border:1px solid e2e2e2;"></td>
	</tr>
	
	</form>
	
	</table>


	<cfif IsDefined("This_ContactID")><br><br>
	

	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

	<tr>
	<td background="#request.imageroot#/ideaFunL/nav_bg.gif" width="100%" height="25"><cfif session.current_account EQ 'personal'><img src="#request.imageroot#/account_per_on.gif" width="124" height="25" alt="Personal Account" border="0"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&current_account=personal"><img src="#request.imageroot#/account_per_off.gif" width="124" height="25" alt="Personal Account" border="0"></a></cfif><img src="#request.imageroot#/transparent_spc.gif" width="2" height="25" border="0"><cfif session.current_account EQ 'education'><img src="#request.imageroot#/account_edu_on.gif" width="124" height="25" alt="Education Account" border="0"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&current_account=education"><img src="#request.imageroot#/account_edu_off.gif" width="124" height="25" alt="Education Account" border="0"></a></cfif><img src="#request.imageroot#/transparent_spc.gif" width="2" height="25" border="0"><cfif session.current_account EQ 'points'><img src="#request.imageroot#/account_points_on.gif" width="124" height="25" alt="Points Account" border="0"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&current_account=points"><img src="#request.imageroot#/account_points_off.gif" width="124" height="25" alt="Points Account" border="0"></a></cfif></td>
	<td align="right" nowrap background="#request.imageroot#/ideaFunL/nav_bg.gif">View: <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_Maxrows=5&ShowSearch=1">5</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_Maxrows=10&ShowSearch=1">10</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_Maxrows=20&ShowSearch=1">20</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_Maxrows=50&ShowSearch=1">50</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&transactions_Maxrows=ALL&ShowSearch=1">ALL</a></td>
	</tr>

	</table>

	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<cfparam name="session.transactions_sortby" default="transaction_date">
    <cfif IsDefined("transactions_sortby")>
        <cfset session.transactions_sortby = transactions_sortby>
    </cfif>
	<cfparam name="session.transactions_sortby_mode" default="DESC">		
	<cfif IsDefined("transactions_sortby_mode")>
        <cfset session.transactions_sortby_mode = transactions_sortby_mode>
    </cfif>
    
	<cfset FromDate='#session.FromDate_day#' & ' ' & '#MonthAsString(session.FromDate_month)#' & ' ' & '#session.FromDate_year#'>
	<cfset ToDate='#session.ToDate_day#' & ' ' & '#MonthAsString(session.ToDate_month)#' & ' ' & '#session.ToDate_year#'>	
		

	<tr>
	<td width="1" bgcolor="444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td width="100%" bgcolor="White">
		
		
		<table width="100%" cellpadding="10" cellspacing="0" border="0">
		
		<tr>
		<td>
	
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="20">Del.</td>
			<td width="90"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&transactions_sortby=Contact_transactions.transaction_date&transactions_sortby_mode=<cfif session.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&ShowSearch=1" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Date</a></td>
			<td width="120"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&transactions_sortby=Contacts.LastName,Contacts.FirstName&transactions_sortby_mode=<cfif session.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&ShowSearch=1" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Name</a></td>
			<td width="*"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&transactions_sortby=Contact_transactions.transaction_description&transactions_sortby_mode=<cfif session.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&ShowSearch=1" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;">Description</a></td>
			<td width="90" align="right"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&transactions_sortby=Contact_transactions.transaction_amount&transactions_sortby_mode=<cfif session.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&ShowSearch=1" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;"><cfif session.current_account EQ 'points'>Points<cfelse>Money</cfif> In</a></td>
			<td width="90" align="right"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&This_ContactID=#This_ContactID#&transactions_sortby=Contact_transactions.transaction_amount&transactions_sortby_mode=<cfif session.transactions_sortby_mode EQ 'DESC'>ASC<cfelse>DESC</cfif>&ShowSearch=1" style="text-decoration:underline; color:###TRIM(AllSettings.BoxColour)#;"><cfif session.current_account EQ 'points'>Points<cfelse>Money</cfif> Out</a></td>
			<td width="90" align="right">Balance</td>
			<td width="40"></td>
			</tr>
			
			<tr>
			<td colspan="8"><hr width="100%" color="e2e2e2" size="1" noshade></td>
			</tr>
            
            <cfif IsDefined("ShowSearch")>
            
                <cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
            	SELECT Contact_transactions.*, Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName
            	FROM Contact_transactions, Contacts
            	
            	<cfif session.current_account EQ 'personal'>
            		WHERE Contact_transactions.Transaction_Account LIKE '%Personal%'
            	<cfelseif session.current_account EQ 'education'>
            		WHERE Contact_transactions.Transaction_Account LIKE '%Education%'	
            	<cfelse>
            		WHERE Contact_transactions.Transaction_Account LIKE '%Points%'
            	</cfif>	
            		
            	AND Contact_transactions.ContactID=Contacts.ContactID
            	
            	<cfif session.search_credit CONTAINS 1 AND session.search_debit CONTAINS 1>
            		AND (Contact_transactions.Transaction_Type LIKE '%Credit%' OR Contact_transactions.Transaction_Type LIKE '%Debit%')
            	<cfelseif session.search_credit CONTAINS 1>
            		AND Contact_transactions.Transaction_Type LIKE '%Credit%'
            	<cfelseif session.search_debit CONTAINS 1>
            		AND Contact_transactions.Transaction_Type LIKE '%Debit%'
            	</cfif>
            	
            	<cfif session.This_ContactID NEQ 0>
            		AND Contacts.ContactID=#session.This_ContactID#
            	</cfif>	
            	
            	<cfif session.search_keywords NEQ ''>
            		AND (Contact_transactions.Transaction_Description LIKE '%#session.search_keywords#%' OR Contacts.FirstName LIKE '%#session.search_keywords#%' OR Contacts.LastName LIKE '%#session.search_keywords#%' OR Contacts.ScreenName LIKE '%#session.search_keywords#%')
            	</cfif>
            	
            	AND (Contact_transactions.Transaction_Date >= #CreateODBCDate(FromDate)#
            	AND Contact_transactions.Transaction_Date <= #CreateODBCDate(ToDate)#)
            	
            	ORDER BY #session.transactions_sortby# #session.transactions_sortby_mode#
            	</cfquery>
    			
    			<form method="post" action="#request.webroot#/administration/act_money_multidelete.cfm" name="MultiDelete">
    			
    			<cfif IsDefined("This_ContactID")>
    				<input type="hidden" name="This_ContactID" value="#This_ContactID#">
    			</cfif>
    			
    			<cfif TransactionHistory.RecordCount>		
    			
    			<!--- SET THE transactions_endrow VALUE --->
    				<cfif session.transactions_MaxRows NEQ 'ALL'>				
    					<cfif TransactionHistory.RecordCount GT (session.transactions_StartRow + session.transactions_MaxRows)-1>
    						<cfset transactions_endrow = session.transactions_StartRow + session.transactions_MaxRows-1>
    					<cfelse>
    						<cfset transactions_endrow = TransactionHistory.RecordCount>
    					</cfif>				
    				<cfelse>
    					<cfset transactions_endrow = TransactionHistory.RecordCount>				
    				</cfif>			
    				
    				
    				<!--- SET THE PREV VALUE --->
    				<cfif session.transactions_Startrow GT session.transactions_Maxrows>
    					<cfset prev = session.transactions_Startrow-session.transactions_Maxrows>				
    				<cfelse>
    					<cfset prev = session.transactions_StartRow>				
    				</cfif>			
    				
    				
    				<!--- SET THE NEXT VALUE --->
    				<cfif transactions_endrow LT TransactionHistory.RecordCount>
    					<cfset next = (transactions_endrow+1)>				
    				<cfelse>
    					<cfset next = session.transactions_StartRow>				
    				</cfif>
    				
    				
    				
    				<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
    				<cfif session.transactions_MaxRows NEQ 'ALL'>				
    					<cfset NumberCount=(TransactionHistory.RecordCount/session.transactions_Maxrows)>
    					<cfset transactionsNumberCount=Ceiling(NumberCount)>				
    				<cfelse>				
    					<cfset transactionsNumberCount=1>					
    				</cfif>
    							
    				<cfset thistotal=0>		
    				
    				<input type="hidden" name="NumRecs" value="50">
    				
    				<cfset this_row=0>
    				
    				
    				<cfloop query="TransactionHistory" startrow="#session.transactions_StartRow#" endrow="#transactions_endrow#">
    				
    				<cfset this_contactID = TransactionHistory.ContactID>
    				
    				<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
    					<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
    						<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
    					<cfelse>
    						<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
    					</cfif>
    				</cfif>
    				<cfset this_row=this_row+1>
    				
    				<input type="hidden" name="TransactionID_#this_row#" value="#TransactionHistory.transactionID#">
    				<tr>
    				<td style="padding-right:5px;" valign="top"><input type="checkbox" name="DeleteTrans_#this_row#" class="whitefield" value="1"></td>
    				<td width="90" style="font-size:11px;" valign="top">#DateFormat(TransactionHistory.Transaction_Date, "d-mmm-yy")#</td>
    				<td width="120" style="font-size:11px;" valign="top">#TRIM(TransactionHistory.FirstName)# #TRIM(TransactionHistory.LastName)#<br>
    				<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a> <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#">#TRIM(TransactionHistory.ScreenName)#</td>
    				<td width="*" style="font-size:11px;" valign="top">#TRIM(TransactionHistory.Transaction_Description)#</td>
    				<td width="90" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Credit'><cfif session.current_account EQ 'points'>#INT(TransactionHistory.Transaction_Amount)#<cfelse>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></cfif></td>
    				<td width="90" align="right" style="font-size:11px;" valign="top"><cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'><cfif session.current_account EQ 'points'>#INT(TransactionHistory.Transaction_Amount)#<cfelse>#DollarFormat(TransactionHistory.Transaction_Amount)#</cfif></cfif></td>
    				<td width="90" align="right" style="font-size:11px;" valign="top"><cfif thisTotal LT 0>- </cfif><cfif session.current_account EQ 'points'>#INT(thistotal)#<cfelse>#DollarFormat(thistotal)#</cfif></td>
    				<td align="right" width="40"><a href="#request.webroot#/admin/dsp_kids_transaction_edit.cfm?transactionID=#TransactionHistory.transactionID#" target="editTransaction" ONCLICK="fdbackwindow=window.open ('','editTransaction','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Transaction" border="0"></a>&nbsp;<a href="javascript:confirmTransactionDelete('#request.webroot#/admin/act_kids_transaction_delete.cfm?transactionID=#TransactionHistory.transactionID#&contactID=#TransactionHistory.ContactID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Transaction" border="0"></a></td>
    				</tr>
    				
    				<tr>
    				<td colspan="8"><hr width="100%" color="e2e2e2" size="1" noshade></td>
    				</tr>
    				
    				<cfflush interval="10">
    				</cfloop>
    				
    				<tr>
    				<td colspan="3" style="font-size:11px;"><a href="javascript:document.MultiDelete.submit();" style="color:###TRIM(AllSettings.BoxColour)#;">Delete Checked</a></td>
    				<td colspan="3" align="right" style="font-size:11px;"><strong><span style="color:###TRIM(AllSettings.DkTextColor)#;">Current balance: </span></strong></td>
    				<td width="90" align="right" style="font-size:11px;"><strong><cfif thisTotal LT 0><span style="color:red;">- <cfelse><span style="color:###TRIM(AllSettings.DkTextColor)#;"></cfif><cfif session.current_account EQ 'points'>#INT(thistotal)#<cfelse>#DollarFormat(thistotal)#</cfif></span></strong></td>
    				<td align="right" width="40"></td>
    				</tr>
    				
    				
    				<tr>
    				<td colspan="8"><hr width="100%" size="1" color="e2e2e2">
    	
    	<div align="right"><cfif session.transactions_Startrow GT session.transactions_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&transactions_Startrow=#prev#&This_ContactID=#This_ContactID#">Prev Page</a> | </cfif><cfif transactions_endrow LT TransactionHistory.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&transactions_Startrow=#next#&This_ContactID=#This_ContactID#">Next Page</a> &gt;</cfif><cfif session.transactions_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#transactionsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.transactions_Maxrows*NumberCount-session.transactions_Maxrows+1)><cfif thisStartRow EQ session.transactions_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&transactions_Startrow=#thisStartRow#&This_ContactID=#This_ContactID#"></cfif>#NumberCount#<cfif thisStartRow EQ session.transactions_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ transactionsNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div></td>
    				</tr>
    				
    			
    			<cfelse>
    				
    				<tr>
    				<td colspan="8">No transactions were found for this account.</td>
    				</tr>
    			
    			</cfif>
    			</form>
    			<tr>
    			<td colspan="8"><hr width="100%" color="e2e2e2" size="1" noshade></td>
    			</tr>
            
            </cfif>
			
			</table>
	
		
		</td>
		</tr>
	
		</table>
	

	</td>
	<td width="1" bgcolor="444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>

	<tr>
	<td colspan="3" bgcolor="444444"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>

	</table><br>
	
	
	
	</cfif>








</td>
<td align="right" width="30"> </td>
</tr>


</table><br>



</cfoutput>