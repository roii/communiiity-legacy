<cfinclude template="app_locals.cfm">


<cfoutput>

<cfif attributes.fusesubaction EQ 'index'>

	
	<cfinclude template="dsp_search_form.cfm">


<cfelseif attributes.fusesubaction EQ 'advancedresults'>

	<cfinclude template="qry_advanced_search.cfm">
	<cfinclude template="dsp_advanced_results.cfm">
	
	
</cfif>

</cfoutput>