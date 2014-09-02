<cfparam name="FORM.quoteid" default="0">

<cfquery name="UpdateTerm" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE QuoteOfDay
SET 
quotedetails='#TRIM(form.quotedetails)#'
,quotecredit='#TRIM(form.quotecredit)#'
,whoseesit=#FORM.whoseesit#
,display=#FORM.showhide#
WHERE quoteid=#form.quoteid#
</cfquery>

<cfoutput>
		<script>
			alert("Quote details have been saved successfully!");
			self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_quote&quoteid=#form.quoteid#";
		</script>
</cfoutput>