<cfoutput>

<cftransaction action="BEGIN">
  <cfquery name="DeleteBusiness" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM bizidea 
	WHERE bizideaID=#attributes.bizideaID#
  </cfquery>
  
  <cfquery name="DeleteSubSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM BizIdea_Sections 
	WHERE bizideaID=#attributes.bizideaID#
  </cfquery>

</cftransaction>

<script>
alert("The Biz Idea has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas";
</script>

</cfoutput>