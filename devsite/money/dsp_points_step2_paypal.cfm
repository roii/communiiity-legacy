<cfoutput>

<cfquery name="TransDetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE ContactID=#session.UserID#
ORDER BY StartDate DESC
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>PURCHASE POINTS - PAYPAL TRANSACTION</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>


<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<cfset session.this_PurchaseAmount = TransDetails.DollarValue>

<form action="#request.webroot#/money/act_paypal_send.cfm" method="post">
<tr>
<td colspan="2" style="color:##444444;"><strong>Your <span style="color:###TRIM(AllSettings.BoxColour)#;">#TransDetails.PointsAmount# point</span> purchase transaction has been logged into our system.<br>
This purchase will cost you <span style="color:###TRIM(AllSettings.BoxColour)#;">#DollarFormat(TransDetails.DollarValue)#</span> US dollars.</strong><br><br>

PayPal transactions typically take between 30 seconds and 1 mintue to process before the points will be available in your my3P account.<br><br>

Please click the "Confirm Purchase" button to make payment for this transaction now, otherwise give our administration team a break and click "Cancel Purchase".<br><br>
	
	
<input type="image" src="#request.imageroot#/but_confirm_purchase.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"><img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="20" border="0"><a href="#request.webroot#/money/act_cancel_purchase.cfm"><img src="#request.imageroot#/but_cancel_purchase.gif" width="149" height="20" alt="Cancel Purchase" border="0"></a><br>
<br>
	
</td>
</tr>
</form>

</table>
</cfoutput>