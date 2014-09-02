<!--- DELETE POINTS --->
	
	<cfquery name="deletePoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SponsorPoints
	WHERE SponsorPointsID=#SponsorPointsID#
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=points">
	