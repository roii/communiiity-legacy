<cfoutput>

<cftransaction action="BEGIN">
  
  <cfquery name="Deleteideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from bizidea WHERE biz_ideatypeID=#attributes.bizideatypeID#
  </cfquery>
  
  <cfquery name="DeleteGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from bizidea_type WHERE bizideatypeID=#attributes.bizideatypeID#
  </cfquery>

</cftransaction>

<script>
alert("The Biz Idea type has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=9&articleID=17";
</script>

</cfoutput>