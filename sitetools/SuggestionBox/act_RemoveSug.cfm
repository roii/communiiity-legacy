
<cfoutput>

  <cfquery name="ArchiveSug" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	UPDATE 	suggestion
	SET 	whenSugEnded = getdate()
	WHERE	sugID = #URL.SugID#	
  </cfquery>



	<script>
	alert("The suggestion has been archived from the database!");
	self.location="dsp_manageSug.cfm";
	</script>

</cfoutput>