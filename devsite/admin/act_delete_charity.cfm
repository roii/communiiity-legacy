<cfparam name="organisationID" default="0">

<cfquery name="DeletePartner" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Organisations
SET Organisation_Status = 'Deleted'
WHERE organisationID = #organisationID#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_partners" addtoken="No">