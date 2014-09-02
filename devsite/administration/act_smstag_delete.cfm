<!--- DELETE TAG --->
<cfquery name="deleteTag" datasource="#dsn#">
DELETE
FROM SMS_Taglines
WHERE TagID = #TagID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags">