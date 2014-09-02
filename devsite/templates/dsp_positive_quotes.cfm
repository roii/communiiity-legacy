<cfoutput>

<cftry>

<!--- GET QUOTES --->
<cfquery name="AllQuotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM QuoteOfDay 
WHERE display=1
</cfquery>


<cfif IsDefined("DirectQuoteID")>
	
	<cfquery name="QuoteStuff" dbtype="query">
	SELECT QuoteID, QuoteDetails, QuoteCredit
	FROM AllQuotes
	WHERE QuoteID=#DirectQuoteID#
	</cfquery>

<cfelse>

	<cfset AllQuoteIDs = valueList(AllQuotes.QuoteID)>
	<cfset NumberOfQuotes = ListLen(AllQuoteIDs)>
	<cfset this_quote = RandRange(1, NumberOfQuotes)>
	<cfset this_quoteID = ListGetAt(AllQuoteIDs, this_quote, ",")>

	<cfquery name="QuoteStuff" dbtype="query">
	SELECT QuoteID, QuoteDetails, QuoteCredit
	FROM AllQuotes
	WHERE QuoteID=#this_quoteID#
	</cfquery>

</cfif>

<a name="quotes"> </a>
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#;">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>POSITIVE QUOTES</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="150" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td colspan="2" style="font-size:11px;color:black;">"#TRIM(QuoteStuff.QuoteDetails)#"<br><br>
	<em>- #TRIM(QuoteStuff.QuoteCredit)#</em><br></td>
	</tr>
	
	
	<tr>
	<td colspan="2" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><hr width="100%" size="1" color="###AllSettings.BoxColour#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td><cfif QuoteStuff.QuoteID GT 1><span style="color:###AllSettings.BoxColour#;text-decoration:none;"><strong>&laquo;</strong></span> <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DirectQuoteID=#INT(QuoteStuff.QuoteID-1)#<cfif IsDefined("DocumentID")>&DocumentID=#documentID#</cfif><cfif IsDefined("ArticleID")>&ArticleID=#ArticleID#</cfif><cfif IsDefined("BizIdeaID")>&BizIdeaID=#BizIdeaID#</cfif><cfif IsDefined("BizSectonID")>&BizSectonID=#BizSectonID#</cfif><cfif IsDefined("ProjectCategoryID")>&ProjectCategoryID=#ProjectCategoryID#</cfif><cfif IsDefined("ProjectID")>&ProjectID=#ProjectID#</cfif><cfif IsDefined("contact")>&contact=#contact#</cfif>&##quotes" style="color:black;">Prev</a></cfif></td>
	<td align="right"><cfif QuoteStuff.QuoteID LT AllQuotes.RecordCount><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DirectQuoteID=#INT(QuoteStuff.QuoteID+1)#<cfif IsDefined("DocumentID")>&DocumentID=#documentID#</cfif><cfif IsDefined("ArticleID")>&ArticleID=#ArticleID#</cfif><cfif IsDefined("BizIdeaID")>&BizIdeaID=#BizIdeaID#</cfif><cfif IsDefined("BizSectonID")>&BizSectonID=#BizSectonID#</cfif><cfif IsDefined("ProjectCategoryID")>&ProjectCategoryID=#ProjectCategoryID#</cfif><cfif IsDefined("ProjectID")>&ProjectID=#ProjectID#</cfif><cfif IsDefined("contact")>&contact=#contact#</cfif>&##quotes" style="color:black;">Next</a> <span style="color:###AllSettings.BoxColour#;text-decoration:none;"><strong>&raquo;</strong></span></cfif></td>
	</tr>
	
	</table><br>


</td>
</tr>

</table>


<cfcatch></cfcatch>
</cftry>

</cfoutput>