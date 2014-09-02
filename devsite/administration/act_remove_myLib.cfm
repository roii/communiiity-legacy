<cfoutput>

<cftransaction action="BEGIN">
  <cfquery name="DeletemyLib" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from myLib WHERE myLibID=#attributes.myLibID#
  </cfquery>

</cftransaction>

<script>
alert("The Item has been deleted from myLibrary!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_myLib";
</script>

</cfoutput>