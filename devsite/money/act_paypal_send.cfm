<cfoutput>



<form action="https://www.paypal.com/cgi-bin/webscr" method="post" name="purchase_form">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="business" value="payments@my3p.com">
<input type="hidden" name="undefined_quantity" value="0">
<input type="hidden" name="item_name" value="my3P Points Package">
<input type="hidden" name="item_number" value="PP001">
<input type="hidden" name="amount" value="#numberFormat(session.this_PurchaseAmount, "0.00")#">
<input type="hidden" name="no_shipping" value="1">
<input type="hidden" name="return" value="http://64.38.10.18/dev.my3p.com/money/act_paypal_success.cfm">
<input type="hidden" name="cancel_return" value="http://64.38.10.18/dev.my3p.com/money/act_paypal_cancel.cfm">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
</form>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>my3P.com Purchase Points</title>
</head>
<body onload="javascript:document.purchase_form.submit();">
</body>
</html>

</cfoutput>