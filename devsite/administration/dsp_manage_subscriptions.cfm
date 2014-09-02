<cfoutput>
	
<cfquery name="AllSubSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM subscriptionSettings
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE SUBSCRIPTIONS</strong></td>
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

<tr>
<td class="small">
	
<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	
	<tr>
	<td class="normal" nowrap><strong>Day of month billed</strong></td>
	<td class="normal" nowrap><strong>Amount per month</strong></td>
	<td class="normal" nowrap><strong>Next Bill Date</strong></td>
	<td class="normal" nowrap><strong>Last Billed</strong></td>
	<td align="right"></td>
	</tr>
	
	<cfloop query="AllSubSettings">
	
	<cfif (dateFormat(localDateTime, "d") GTE AllSubSettings.DayBilled)>
		<cfset nextmonth = DateAdd('m', 1, localDateTime)>		
		<cfset nextBillDate = '#DayBilled#' & ' ' & '#dateformat(nextmonth, "mmmm yyyy")#'> 
	<cfelse>
		<cfset nextBillDate = '#DayBilled#' & ' ' & '#dateformat(localDateTime, "mmmm yyyy")#'> 
	</cfif>
	
	
	<tr>
	<td class="normal">#DayBilled#</td>
	<td class="normal">#DollarFormat(MonthlyAmount)#</td>
	<td class="normal">#DateFormat(nextBillDate, "d-mmm-yyyy")#</td>
	<td class="normal">#DateFormat(LastBilled, "d-mmm-yyyy")#</td>
	<td align="right"><a href="#request.webroot#/admin/dsp_subsetting_edit.cfm" target="editsubsettings" ONCLICK="fdbackwindow=window.open ('','editsubsettings','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=200,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Settings" border="0"></a></td>
	</tr>
	</cfloop>
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>