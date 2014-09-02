<cfoutput>

<cftransaction action="BEGIN">
  <cfquery name="DeleteGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from Goals WHERE goalid=#attributes.goalid#
  </cfquery>

</cftransaction>

<script>
alert("The Public Goal has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_publicGoals";
</script>

</cfoutput>