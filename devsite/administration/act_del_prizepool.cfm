<cfoutput>
<cfparam name="attributes.prizepoolid" default="">

<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->
<cfquery name="TDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize_pool WHERE prizepoolid=#attributes.prizepoolid#
</cfquery>


<cftry>
	<cffile action="DELETE" file="#request.fileroot#\images\prize\#TDetails.image#">
<cfcatch>
</cfcatch>
</cftry>

<cfquery name="dprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  update prize_pool 
  SET deleted=1
  WHERE prizepoolid=#attributes.prizepoolid#
</cfquery>



</cftransaction>

<script>
alert("You have successfully deleted the prize!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes";
</script>

</cfoutput>