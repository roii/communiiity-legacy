<cfparam name="attributes.quoteid" default="0">

<cfquery name="CurrentQuote" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM QuoteOfDay WHERE quoteid = #attributes.quoteid#
</cfquery>

