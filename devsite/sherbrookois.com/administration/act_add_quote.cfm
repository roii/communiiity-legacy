
<cfquery name="nextID" datasource="#dsn#" username="#request.username#" password="#request.password#">
select top 1 max(quoteid)+1 as nextid from QuoteOfDay
</cfquery>

<cfquery name="addquote" datasource="#dsn#" username="#request.username#" password="#request.password#">
insert into QuoteOfDay(quoteid,quotedetails,quotecredit,whoseesit,display)
values(#nextID.nextid#,'#TRIM(form.quotedetails)#','#TRIM(form.quotecredit)#',#FORM.whoseesit#,#FORM.showhide#)
</cfquery>

<cfoutput>
		<script>
			alert("Quote has been added successfully!");
			self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_quote";
		</script>
</cfoutput>