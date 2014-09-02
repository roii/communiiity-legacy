<cfparam name="attributes.prizeid" default="">
<cfparam name="attributes.prizepoolid" default="">
<cfif attributes.prizeid neq ''>

<cfquery name="prizeQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize_entry pe,prize p where p.prizepoolid = pe.prizepoolid and 
  pe.prizepoolid = #attributes.prizepoolid# and p.status = 1
</cfquery>

<cfif prizeQ.recordcount>

<cfquery name="select_draw" datasource="#dsn#" username="#request.username#" password="#request.password#">
   select top 1 prize_entryid from prize_entry where prizepoolid = #attributes.prizepoolid# and winner = 0 order by newid()
</cfquery>

<cfquery name="update_entry" datasource="#dsn#" username="#request.username#" password="#request.password#">
  update prize_entry set winner = 1,prizeid=#attributes.prizeid# where prize_entryid = #select_draw.prize_entryid#
</cfquery>

<!---
<cfquery name="update_prize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  update prize set status = 0 where prizeid = #attributes.prizeid#
</cfquery>
---->

<cfoutput>
  <script>
	alert("You've successfully selected a winner!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#attributes.prizepoolid#";
  </script>
</cfoutput>

<cfelse>
<cfoutput>
  <script>
	alert("This prize is already closed, please re-open it first.");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#attributes.prizepoolid#";
  </script>
</cfoutput>
</cfif>
</cfif>
