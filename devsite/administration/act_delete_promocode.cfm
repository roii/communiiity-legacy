<!--- DELETE SCHOOL --->

<cfquery name="deletePromo" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM PromoCodes
WHERE PromoID=#PromoID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes">
