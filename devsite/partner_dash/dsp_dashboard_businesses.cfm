<cfoutput>

<!--- GET ALL BUSINESSES --->
<cfquery name="AllBusinesses" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT bizkidslinkid
FROM bizkidslink
</cfquery>

<!--- GET ALL BUSINESSES STARTED IN RANGE --->
<cfquery name="StartedBusiness" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Count(bizkidslinkid) AS TotalStartedBiz
FROM bizkidslink
</cfquery>

<cfset totalincome=0>
<cfset totalexpenses=0>
<cfset totalMinutes=0>


<!---<cfloop query="AllBusinesses">

<cfset this_bizkidslinkid = AllBusinesses.bizkidslinkid>

<!--- GET ALL TRANSACTIONS --->
<cfquery name="AllTransactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount) AS TotalBizIncome, SUM(expense1_amount+expense2_amount+expense3_amount+expense4_amount+expense5_amount) AS TotalBizExpense, SUM(hours) AS TotalBizHours
FROM bizTransaction
WHERE bizkidslinkid=#this_bizkidslinkid#
AND bizTransaction.ExcludeBenchmark=0
</cfquery>

<cfif AllTransactions.RecordCount>
	
	<cfif AllTransactions.TotalBizIncome NEQ ''>
		<cfset totalincome = (totalincome+AllTransactions.TotalBizIncome)>
	</cfif>
	
	<cfif AllTransactions.TotalBizExpense NEQ ''>
		<cfset totalexpenses = (totalexpenses+AllTransactions.TotalBizExpense)>
	</cfif>
	
	<cfif AllTransactions.TotalBizHours NEQ ''>
		<cfset totalMinutes = (totalMinutes+AllTransactions.TotalBizHours)>
	</cfif>
		
</cfif>


</cfloop>--->

<cfset TotalProfit = totalincome - totalexpenses>


<cfset TotalHours = INT(totalMinutes / 60)>
<cfset DisplayMinutes = (totalMinutes MOD 60)>


<cfif totalProfit NEQ 0 OR TotalHours NEQ 0>
	<cfset averageProfitPerHour = (totalProfit/TotalHours)>
<cfelse>
	<cfset averageProfitPerHour = 0>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Businesses</strong></td>
	<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/Businesses_sml.jpg" alt="Businesses" border="0"> ---></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Total Businesses:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllBusinesses.RecordCount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Profit:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DollarFormat(TotalProfit)#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Hours invested:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#INT(totalHours)#:#NumberFormat(DisplayMinutes, "00")# hrs</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Avg Profit p/hr:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DollarFormat(averageProfitPerHour)#</td>
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