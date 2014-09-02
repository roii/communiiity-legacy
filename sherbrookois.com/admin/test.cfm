<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM WhatsNew
WHERE Type='download'
AND LibraryID=''
</cfquery>

