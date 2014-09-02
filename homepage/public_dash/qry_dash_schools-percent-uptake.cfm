<!--- STUDENT REG POSITION --->
<cfquery name="topschools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolName, BM_studentreg
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_studentreg DESC
</cfquery>


