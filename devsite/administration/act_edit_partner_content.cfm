
<!--- UPDATE ORGANISATION INFO --->	
<cfquery name="UpdateProfile" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Organisations
SET ProfileContent='#form.ProfileContent#'
WHERE OrganisationID=#form.OrganisationID#
</cfquery>



<!--- REFRESH THE CALLING PAGE --->
	
<cfoutput>
	
<script language="JavaScript">
alert("You have successfully updated the partner profile content");
self.location="#request.webroot#/administration/dsp_edit_partner_popup.cfm?organisationID=#form.organisationID#&updatemode=viewprofile";
</script>
	
</cfoutput>
