<cfoutput>
<cfparam name="attributes.activityid" default="">
<cftransaction action="BEGIN">

<cfquery name="DeleteT" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from prize_activity WHERE activityid=#attributes.activityid#
</cfquery>

<cfquery name="DeleteEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from prize_entry WHERE activityid=#attributes.activityid#
</cfquery>

<cfquery name="dprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from activity WHERE activityid=#attributes.activityid#
</cfquery>

</cftransaction>

<script>
alert("All Activity records have been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_activity";
</script>

</cfoutput>