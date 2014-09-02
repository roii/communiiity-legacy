<cfoutput>

<!--- UPDATE CONTACT INFO --->

<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE kidsnote
SET note='#trim(form.kidsnote)#',
lastedit=#localDateTime#
WHERE noteid=#form.noteid#
</cfquery>

<script>
alert("The selected note has been updated!");
self.location="#request.webroot#/admin/dsp_kid_edit.cfm?contactid=#form.contactid#";
</script>
	
</cfoutput>