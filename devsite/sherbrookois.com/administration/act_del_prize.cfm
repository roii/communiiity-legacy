<cfoutput>
<cfparam name="attributes.prizeid" default="">
<cfparam name="attributes.prizepoolid" default="">
<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->
<cfquery name="TDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize WHERE prizeid=#attributes.prizeid#
</cfquery>

<cftry>
<cfif TDetails.recordcount GT 0>
  <cfif TDetails.image NEQ ''>
     <cffile action="DELETE" file="#request.fileroot#\images\prize\#TDetails.image#">
  </cfif>
</cfif>
<cfcatch>
	<cfset uploadFileError = true>
</cfcatch>
</cftry>

<cfquery name="dprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from prize WHERE prizeid=#attributes.prizeid#
</cfquery>

</cftransaction>

<script>
alert("All Prize records have been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#attributes.prizepoolid#";
</script>

</cfoutput>