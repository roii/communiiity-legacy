<cfinclude template="app_locals.cfm">


<cfoutput>



	
	
<!--- DISPLAY SECTION INFORMATION, LINKED DOCUMENTS --->
<cfif #attributes.fusesubaction# EQ 'index'>

	
	<cfinclude template="qry_download_cats.cfm">
	<cfinclude template="dsp_downloads.cfm">
	
	
<cfelseif #attributes.fusesubaction# EQ 'template'>

	
	<cfinclude template="qry_download_details.cfm">
	<cfinclude template="dsp_download_details.cfm">

	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">
		

</cfif>

</cfoutput>