<cfoutput>
<cfparam name="attributes.prizepoolid" default="">

<cftransaction action="BEGIN">

<cfquery name="TDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize_pool WHERE prizepoolid=#attributes.rewardID#
</cfquery>


<cftry>
	<cffile action="DELETE" file="#request.fileroot#\images\prize\#TRIM(TDetails.image)#">
<cfcatch>
</cfcatch>
</cftry>

<cfquery name="dprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  update prize_pool 
  SET deleted=1
  WHERE prizepoolid=#attributes.rewardID#
</cfquery>



</cftransaction>

<script>
alert("You have successfully deleted the reward!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards";
</script>

</cfoutput>