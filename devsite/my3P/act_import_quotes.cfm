<cfoutput>

<cffile action="READ" file="#request.fileroot#/quotes.csv" variable="QuoteDetails">

<cfset clean_list = Replace(QuoteDetails, '"', '', 'ALL')>

<cfloop list="#Replace(QuoteDetails, '"', '', 'ALL')#" delimiters="#Chr(10)#" index="Loopitem">


	<cfset thiscount=0>
	
	<cfloop list="#loopitem#" delimiters="," index="this_item">
	
		<cfset thiscount=thiscount+1>
		
		<cfif thiscount EQ 1>
			<cfset insert_quotedetails = "#Replace(this_item, "|", ",", "ALL")#">
		<cfelse>
			<cfset insert_quotecredit = "#Replace(this_item, "|", ",", "ALL")#">
		</cfif>
	
	</cfloop>

	<cfquery name="LastID" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
	SELECT QuoteID
	FROM QuoteOfDay
	ORDER BY QuoteID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.QuoteID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT QUOTE INFO --->
	
	<cfquery name="AddQuote" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	INSERT INTO QuoteOfDay(QuoteID, QuoteDetails, QuoteCredit)
	VALUES(#newid#, '#TRIM(insert_quotedetails)#', '#TRIM(insert_quotecredit)#')
	</cfquery>



</cfloop>

<script>
alert("Done");
</script>
	
	</cfoutput>