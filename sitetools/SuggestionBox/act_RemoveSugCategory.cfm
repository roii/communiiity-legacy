
<cfoutput>

  <cfquery name="ArchiveSugCategory" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	UPDATE 	sugCategory
	SET 	whenCategoryEnded = getdate()
	WHERE	categoryID = #URL.categoryID#	
  </cfquery>



<script>
	alert("The category has been archived from the database!");
	self.location="dsp_manageSugCategory.cfm";
</script>

</cfoutput>