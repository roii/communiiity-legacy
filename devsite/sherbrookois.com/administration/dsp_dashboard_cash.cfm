<cfoutput>

<!--- GET ALL EARNED --->
<cfquery name="AllEarnedCash" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalEarnedCash
FROM contact_transactions
WHERE Transaction_Account LIKE '%Personal%'
AND Transaction_Type LIKE '%Credit%'
AND Transaction_Date BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<!--- GET ALL REDEEEMED --->
<cfquery name="AllSpentCash" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalSpentCash
FROM contact_transactions
WHERE Transaction_Account LIKE '%Personal%'
AND Transaction_Type LIKE '%Debit%'
AND Transaction_Date BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<cfif AllEarnedCash.RecordCount AND IsNumeric("#AllEarnedCash.TotalEarnedCash#")>
	<cfset totalearned_cash = AllEarnedCash.TotalEarnedCash>
<cfelse>
	<cfset totalearned_cash = 0>
</cfif>

<cfif AllSpentCash.RecordCount AND IsNumeric("#AllSpentCash.TotalSpentCash#")>
	<cfset totalspent_cash = AllSpentCash.TotalSpentCash>
<cfelse>
	<cfset totalspent_cash = 0>
</cfif>

<cfset Cashbalance = (totalearned_cash - totalspent_cash)>

<br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Cash Account</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Profits_sml.jpg" alt="Cash Account" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Earned:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DollarFormat(totalearned_cash)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Spent:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DollarFormat(totalspent_cash)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr><tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Balance:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DollarFormat(Cashbalance)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>