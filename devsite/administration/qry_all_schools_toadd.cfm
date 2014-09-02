<cfquery name="AllSchoolsToAdd" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, CountryID, City, School_Other, School_Other_Phone, School_Other_Address
FROM Contacts
WHERE (SchoolID=0 OR SchoolID=NULL OR SchoolID=9999998)
AND School_Other IS NOT NULL
AND School_Other <> ''
</cfquery>