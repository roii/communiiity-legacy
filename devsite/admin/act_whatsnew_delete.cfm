<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM WhatsNew
WHERE WNID=#WNID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?#calledfrom#">