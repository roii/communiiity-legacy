<cfif form.archivecheck eq ''>
	<script>
		alert("Please select an idea to archive first!");
		self.location="http://www.mykidsbiz.com/index.cfm?fuseaction=administration&fusesubaction=manage_sug";
	</script>  
	<cfabort>
</cfif>


<cfquery name="ArchiveSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
  update suggestion set archived = 1 where sugid in (#form.archivecheck#)	
</cfquery>

<script>
	alert("Selected ideas have been archived successfully!");
	self.location="http://www.mykidsbiz.com/index.cfm?fuseaction=administration&fusesubaction=manage_sug";
</script>  