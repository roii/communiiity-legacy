<cfoutput>

<cfquery name="TransDetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE ContactID=#session.UserID#
ORDER BY AuthoriseDate DESC
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>PURCHASE POINTS - PAYMENT CONFIRMED!</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>


<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2" style="color:##444444;"><strong>PayPal have confirmed your payment was successful. Thanks!</strong><br><br>

Your transaction has been completed and a receipt for your purchase has been emailed to you. You may log into your account at <a href="http://www.paypal.com/row" target="_Blank">www.paypal.com</a> to view details of this transaction.<br><br><br>

<strong>Your Purchase:</strong><br>

	<table width="100%" cellpadding="4" cellspacing="0" style="border:dashed 1px b4b4b4;">
	
	<tr>
	<td>
	
		
		<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
		<tr>
		<td style="padding-right:5px;" align="right"><strong>Transaction Date:</strong></td>
		<td>#DateFormat(localdatetime)#</td>
		</tr>
		
		<tr>
		<td style="padding-right:5px;" align="right"><strong>Points Purchased:</strong></td>
		<td>#TransDetails.PointsAmount#</td>
		</tr>
		
		<tr>
		<td style="padding-right:5px;" align="right"><strong>Amount Paid:</strong></td>
		<td>$USD #NumberFormat(TransDetails.DollarValue)#</td>
		</tr>
	
		</table>
		
	
	</td>
	</tr>
	
	</table>
 
 

</td>
</tr>


</table><br>
</cfoutput>