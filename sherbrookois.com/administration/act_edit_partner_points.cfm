
	<!--- UPDATE INFO --->
	
	<cfquery name="UpdatePoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE SponsorPoints
	SET PointsPurchased=#form.PointsPurchased#,
	PointsRemaining=#form.PointsPurchased#,
	Activities='#form.Activities#',
	PricePaid=#val(REReplace(form.PricePaid,"[^0-9.]","","ALL"))#,
	Currency='#form.currency#'
	WHERE SponsorPointsID=#form.SponsorPointsID#
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#form.OrganisationID#&updatemode=points">
	