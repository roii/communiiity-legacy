<cfquery name="SectionAdvertising" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Advertising
WHERE AdvertSections LIKE '%#attributes.fuseaction#%'
</cfquery>