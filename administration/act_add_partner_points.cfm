<!--- GENERATE NEW ID --->
	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT SponsorPointsID
FROM SponsorPoints
ORDER BY SponsorPointsID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.SponsorPointsID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	
	
	
	<!--- INSERT INFO --->
	
	<cfquery name="AddPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO SponsorPoints(
	SponsorPointsID,
	SponsorID,
	DatePurchased,
	PointsPurchased,
	PointsRemaining,
	Activities,
	Countries,
	PricePaid,
	Currency)
	VALUES(#newid#, 
	#form.OrganisationID#,
	#createODBCDateTime(localDateTime)#,
	#form.PointsPurchased#,
	#form.PointsPurchased#,
	'#form.Activities#',
	'ALL',
	#form.PricePaid#,
	'#form.currency#')
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#form.OrganisationID#&updatemode=points">
	