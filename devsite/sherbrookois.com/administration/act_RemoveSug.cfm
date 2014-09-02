<cfoutput>

  <cfquery name="ArchiveSug" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE suggestion
	SET whenSugEnded = getdate(),
	archived=1
	WHERE sugID = #URL.SugID#	
  </cfquery>

	<script>
	alert("The suggestion has been archived from the database!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug";
	</script>
	

</cfoutput>