<cfparam name="attributes.prizeactid" default="">
<cfparam name="attributes.prizepoolid" default="">
<cfif attributes.prizeactid eq "">
<cfoutput>
  <script>
	alert("Deletion Failed!");
	self.location="#request.webroot#/administration/dsp_add_prizepool.cfm";
  </script>
</cfoutput>
<cfabort>
</cfif>

<cfquery name="delprize_ACTIVITY" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from prize_activity where prize_actid = #attributes.prizeactid#
</cfquery>

<cfoutput>
  <script>
	alert("Prize pool has been removed from activity successfully!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_prizepool&prizepoolid=#attributes.prizepoolid#";
  </script>
</cfoutput>