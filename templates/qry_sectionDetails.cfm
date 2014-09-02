<cfquery name="SectionDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Sections
WHERE fuseaction='#attributes.fuseaction#'
</cfquery>