<cfoutput>

<!--- GET QUOTES --->
<cfquery name="AllQuotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM QuoteOfDay
</cfquery>

<cfset AllQuoteIDs = valueList(AllQuotes.QuoteID)>
<cfset NumberOfQuotes = ListLen(AllQuoteIDs)>

<cfset this_quote = RandRange(1, NumberOfQuotes)>

<cfset this_quoteID = ListGetAt(AllQuoteIDs, this_quote, ",")>

<cfquery name="QuoteStuff" dbtype="query">
SELECT QuoteDetails, QuoteCredit
FROM AllQuotes
WHERE QuoteID=#this_quoteID#
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="440" height="8" border="0"></td>
</tr>

<tr>
<td width="52" valign="top"><img src="#request.imageroot#/homepage/icon_quotes.gif" width="49" height="70" alt="Quote Of The Day" border="0"></td>
<td width="*" valign="top" style="padding-left:10px;color:###AllSettings.DkTextColor#"><img src="#request.imageroot#/transparent_spc.gif" width="400" height="8" border="0"><br>
<span style="font-size:12px;color:###AllSettings.DkHeadingColor#"><strong>Quote of The Day!</strong></span><br><br>
"#TRIM(QuoteStuff.QuoteDetails)#"<br>

<em>- #TRIM(QuoteStuff.QuoteCredit)#</em><br><img src="#request.imageroot#/transparent_spc.gif" width="400" height="30" border="0"></td>
</tr>

<tr>
<td colspan="2" background="#request.imageroot#/dots_horizontal.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="30" border="0"></td>
</tr>

</table>


</cfoutput>