<!--- UPDATE SCHOOL INFO --->
	
	<cfquery name="UpdateStaff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET FirstName='#form.FirstName#', 
	LastName='#form.LastName#', 
	EmailAddress='#form.EmailAddress#',
	Password='#form.Profile_Password#'
	WHERE ContactID=#form.ContactID#
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#form.OrganisationID#&updatemode=stafflist">
	