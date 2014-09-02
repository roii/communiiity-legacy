<!--- DELETE CONTACT --->
	
	<cfquery name="deleteStaff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus='deleted'
	WHERE ContactID=#ContactID#
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=stafflist">
	