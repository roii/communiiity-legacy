<cfquery name="KidStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT business.bizideaID, Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
FROM bizKidsLink, Business, Contacts
WHERE bizKidsLink.bizkidslinkid=#bizkidslinkid#
AND bizKidsLink.bizid=Business.BizID
AND bizKidsLink.KidsID=Contacts.ContactID
</cfquery>


<cfquery name="BizStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea 
WHERE bizidea.bizideaID = #KidStuff.BizIdeaID#
</cfquery>


	

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Business Idea - Member Transactions</title>
<cfinclude template="../templates/styles.cfm">

	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<form method="post" action="#request.webroot#/administration/act_biz_transactions_update.cfm">


<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Business Idea - Member Transactions</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="7" style="font-size:12px;">Tick boxes indicate NOT INCLUDED in benchmarking<hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:12px;" colspan="2"><strong>#TRIM(BizStuff.biz_idea)# - #TRIM(KidStuff.Firstname)# #TRIM(KidStuff.Lastname)#</strong></td>
	<td style="font-size:12px;" align="center"><strong>Income</strong></td>
	<td style="font-size:12px;" align="center"><strong>Expense</strong></td>
	<td style="font-size:12px;" align="center"><strong>Profit</strong></td>
	<td style="font-size:12px;" align="center"><strong>Time</strong></td>
	<td style="font-size:12px;" align="right"><strong>Avg.</strong></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="7" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	

	<cfquery name="AllTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM bizTransaction 
	WHERE bizTransaction.bizkidslinkid=#bizkidslinkid#
	ORDER BY tranDate
	</cfquery>
	<input type="hidden" name="TotalTrans" value="#AllTransaction.recordcount#">
	<input type="hidden" name="BizIdeaID" value="#KidStuff.BizIdeaID#">
	<cfloop query="AllTransaction">
	
	<input type="hidden" name="transactionID_#AllTransaction.CurrentRow#" value="#AllTransaction.transactionID#">
	
	<cfset total_income = 0>
	<cfset total_expense = 0>	
	<cfset TotalMins = 0>
	<cfset TotalProfit = 0>
	
	
	<cfif IsNumeric("#AllTransaction.Income1_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income1_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income2_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income2_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income3_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income3_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income4_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income4_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income5_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income5_amount)>
	</cfif>
	
	
	<cfif IsNumeric("#AllTransaction.expense1_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense1_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense2_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense2_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense3_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense3_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense4_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense4_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense5_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense5_amount)>
	</cfif>
	
	
	<cfset TotalProfit = (total_income - total_expense)>
	<cfset TotalMins = (TotalMins + AllTransaction.hours)>
	
	
	
	<cfif TotalMins GT 0>
		<cfset display_hour = INT(TotalMins/60)>
		<cfset display_minutes = TotalMins MOD 60>		
		<cfset profithours = TotalMins / 60>
	
	<cfelse>
		<cfset display_hour = 0>
		<cfset display_minutes = 0>		
		<cfset profithours = 0>
	</cfif>
	
	<cfif profithours GT 0 and TotalProfit GT 0>
		<cfset this_HourRate = TotalProfit / profithours>
	<cfelse>
		<cfset this_HourRate = 0>	
	</cfif>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><input type="checkbox" name="Exclude_#AllTransaction.CurrentRow#" value="1"<cfif AllTransaction.ExcludeBenchmark EQ 1> checked</cfif>></td>
	<td>#DateFormat(AllTransaction.tranDate)# - #TRIM(AllTransaction.description)#</td>
	<td align="center">#DollarFormat(total_income)#</td>
	<td align="center">#DollarFormat(total_expense)#</td>
	<td align="center">#DollarFormat(TotalProfit)#</td>
	<td align="center">#display_hour#:#numberFormat(display_minutes, "00")#</td>
	<td align="right">#DollarFormat(this_HourRate)# p/hr</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="7"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="7"><input type="submit" class="whitefield" value="Update"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	</table><br><br>


	
</td>
</tr>
</form>
</table>

</body>
</html>

</cfoutput>