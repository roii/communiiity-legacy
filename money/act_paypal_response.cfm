<!-- read post from PayPal system and add 'cmd' -->
<CFSET str="cmd=_notify-validate">
<CFLOOP INDEX="TheField" list="#Form.FieldNames#">
<CFSET str = str & "&#LCase(TheField)#=#URLEncodedFormat(Form[TheField])#">
</CFLOOP>
<CFIF IsDefined("FORM.payment_date")>
<CFSET str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
</CFIF>
<CFIF IsDefined("FORM.subscr_date")>
<CFSET str = str & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
</CFIF>
<CFIF IsDefined("FORM.auction_closing_date")>
<CFSET str = str & "&subscr_date=#URLEncodedFormat(Form.auction_closing_date)#">
</CFIF>
<!-- post back to PayPal system to validate -->
<CFHTTP URL="https://www.paypal.com/cgi-bin/webscr?#str#" METHOD="GET" RESOLVEURL="false">
</CFHTTP>
<!-- assign posted variables to local variables -->
<CFSET item_name=FORM.item_name>
<CFSET payment_status=FORM.payment_status>
<CFSET payment_amount=FORM.mc_gross>
<CFSET payment_currency=FORM.mc_currency>
<CFSET txn_id=FORM.txn_id>
<CFSET receiver_email=FORM.receiver_email>
<CFSET payer_email=FORM.payer_email>
<CFIF IsDefined("FORM.item_number")>
<CFSET item_number=FORM.item_number>
</CFIF>
<!-- check notification validation -->
<CFIF #CFHTTP.FileContent# is "VERIFIED">
<!-- check that payment_status=Completed -->
<!-- check that txn_id has not been previously processed -->
<!-- check that receiver_email is your Primary PayPal email -->
<!-- check that payment_amount/payment_currency are correct -->
<!-- process payment -->
<CFELSEIF #CFHTTP.FileContent# is "INVALID">
<!-- log for investigation -->
<CFELSE>
<!-- error -->
</CFIF>
