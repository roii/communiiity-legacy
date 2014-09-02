<cftransaction action="BEGIN">
<cfquery name="deleterequest" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM RewardTransactions
WHERE RewardTransID=#RewardTransID#
</cfquery>
<cftransaction action="commit" />
</cftransaction>

<cfoutput>
<script type="text/javascript">
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests";
</script>
</cfoutput>