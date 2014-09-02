<cfoutput>

<cfquery name="TransDetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE ContactID=#session.UserID#
ORDER BY StartDate DESC
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>PURCHASE POINTS - ASB BANK DEPOSIT</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>


<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2" style="color:##444444;"><strong>Your <span style="color:###TRIM(AllSettings.BoxColour)#;">#TransDetails.PointsAmount# point</span> purchase transaction has been logged into our system.<br>
This purchase will cost you <span style="color:###TRIM(AllSettings.BoxColour)#;">#DollarFormat(TransDetails.DollarValue)#</span> New Zealand dollars.</strong><br><br>

Transactions typically take between 24-72 hours to process before the points will be available in your my3P account depending on which day of the week and what time of day the deposit is made.<br><br>

Please click "Confirm Purchase" if you are planning on making payment for this transaction at a branch of the ASB Bank, otherwise give our administration team a break and click "Cancel Purchase".<br><br>
	
	<a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122&PurchaseMode=confirmed"><img src="#request.imageroot#/but_confirm_purchase.gif" width="149" height="20" alt="Confirm Purchase" border="0"></a><img src="#request.imageroot#/transparent_spc.gif" width="5" height="20" border="0"><a href="#request.webroot#/money/act_cancel_purchase.cfm"><img src="#request.imageroot#/but_cancel_purchase.gif" width="149" height="20" alt="Cancel Purchase" border="0"></a><br>
	<br>
	
</td>
</tr>


</table>
</cfoutput>