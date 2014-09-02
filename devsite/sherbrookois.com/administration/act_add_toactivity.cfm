<cfquery name="Prizeact" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM prize_activity pa WHERE pa.prizepoolid = #form.prizepoolid#
and pa.activityid = #form.activityID#
</cfquery>

<cfif Prizeact.recordcount or form.activityID eq 0>
<cfoutput>
  <script>
	alert("Either you didn't choose an activity or \nthis Prize has already been added to this activity!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_prizepool&prizepoolid=#form.prizepoolid#";
  </script>
</cfoutput>
<cfabort>
</cfif>

<cfquery name="Addprize_ACTIVITY" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO prize_activity(
		prizepoolid,
		activityid
		)
		VALUES(
		#form.prizepoolid#,
		#form.activityID#
		)
</cfquery>

<cfoutput>
  <script>
	alert("Prize pool has been added to activity successfully!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_prizepool&prizepoolid=#form.prizepoolid#";
  </script>
</cfoutput>