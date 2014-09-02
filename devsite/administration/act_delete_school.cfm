<!--- DELETE SCHOOL --->

<cfquery name="deleteSchool" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Schools
WHERE SchoolID=#SchoolID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools">
