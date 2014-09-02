<cfinclude template="app_locals.cfm">


<cfinclude template="templates/qry_sectionDetails.cfm">
	
	
<cfif attributes.fuseaction EQ 'homepage'>
	<cfinclude template="homepage/index.cfm">
<cfelse>	
	<cfinclude template="templates/dsp_internal_layout.cfm">
</cfif>


<script type="text/javascript">
window.name = "mymainwindow";
</script>