<cfoutput>

<cfinclude template="qry_current_biz.cfm">



This page shows all your biz transactions for:<br>
<strong style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;">#CurrentBizDetail.bizname#</strong><br><br>



<table width="100%" cellpadding="0" cellspacing="1" border="0">


<cfif AllTransactions.RecordCount>

<tr bgcolor="###TRIM(AllSettings.DkBoxColour)#" height="25">
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;"><strong>Client</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;"><strong>Description</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Date</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Amount</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Hours<br>Invested</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;"></td>
</tr>

<tr>
<td colspan="6" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
</tr>


<cfloop query="AllTransactions">

<cfif AllTransactions.clientid EQ '0'>
	
	<cfset this_client = TRIM(AllTransactions.clientName)>

<cfelse>
	
	<cfquery name="ClientDetail" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * 
	FROM contacts 
	WHERE contactid=#AllTransactions.clientid# 
	</cfquery>
	
	<cfset this_client = "#TRIM(ClientDetail.firstname)# #trim(ClientDetail.lastname)#">

</cfif>


<tr>
<td valign="top" style="padding-left:10px;">#TRIM(this_client)#</td>
<td valign="top" style="padding-left:10px;">#TRIM(AllTransactions.description)#</td>
<td valign="top" align="center">#DateFormat(AllTransactions.tranDate,"dd/mmm/yyyy")#</td>
<td valign="top" style="padding-right:5px;" align="right">
<cfif AllTransactions.income EQ 0>-</cfif>$#DecimalFormat(AllTransactions.amount)#</td>
<td valign="top" style="padding-right:5px;" align="right"><cfset hrs=AllTransactions.hours/60>#DecimalFormat(hrs)#</td>
<td valign="top" style="padding-right:5px;padding-left:5px;" align="center"><a href="index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentid=#documentid#&transactionid=#AllTransactions.transactionID#&BizMode=EditTransaction&bizkidslinkID=#bizkidslinkID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" title="Edit this transaction" border="0"></a></td>
</tr>

<tr>
<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>

<cfset TotalProfit = 0>
<cfset TotalMins = 0>
<cfset HourRate = 0>

<cfloop query="AllTransactions">

<cfif AllTransactions.income EQ 1>
	<cfset TotalProfit = TotalProfit + AllTransactions.amount>
<cfelse>
	<cfset TotalProfit = TotalProfit - AllTransactions.amount>
</cfif>

<cfset TotalMins = TotalMins + AllTransactions.hours>
<cfset HourRate = AllTransactions.hourRate>

</cfloop>


<cfif TotalMins GT 0>
	<cfset TotalMins = TotalMins/60>
</cfif>

<cfif HourRate EQ 0 and TotalMins GT 0 and TotalProfit GT 0>
	<cfset HourRate = TotalProfit/TotalMins>
</cfif>

<tr>
<td valign="top" style="padding-left:10px;"><b>Total:</b></td>
<td valign="top"></td>
<td valign="top"></td>
<td valign="top" align="right" style="padding-right:5px;"><b>$#DecimalFormat(TotalProfit)#</b></td>
<td valign="top" align="right" style="padding-right:5px;"><b>#DecimalFormat(TotalMins)#</b></td>
<td valign="top"></td>
</tr>

<tr>
<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfelse>

<tr>
<td>You haven't entered any transactions for this business yet.</td>
</tr>

</cfif>

</table><br>

<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentid=47" style="color:###TRIM(AllSettings.BoxColour)#;">&laquo; Back to myBusinesses</a>


</cfoutput>