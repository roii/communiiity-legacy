<cfoutput>

<cftransaction action="BEGIN">
  <cfquery name="DeleteNote" datasource="#dsn#" username="#request.username#" password="#request.password#">
   delete from kidsnote WHERE noteid=#attributes.noteid#
  </cfquery>
</cftransaction>

<script>
alert("The selected note has been deleted from the database!");
self.location="#request.webroot#/admin/dsp_kid_edit.cfm?contactid=#attributes.kidsid#";
</script>

</cfoutput>