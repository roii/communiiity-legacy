<!--- SELECT THE FILE DETAILS TO DELETE AND ADD TO LOG --->
<cfquery name="FileDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FileName, Title
FROM Library
WHERE LibraryID=#LibraryID#
</cfquery>

<!--- DELETE THE  FILE FROM THE SERVER --->
<cftry>
	<cffile action="delete" file="#request.fileroot#\download\files\#FileDetails.FileName#">
<cfcatch></cfcatch>
</cftry>

<!--- DELETE THE LIBRARY RECORD --->
<cfquery name="DeleteFileDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Library
WHERE LibraryID=#LibraryID#
</cfquery>	
	
<!--- LOG THIS ACTION --->
<cfset logdetails = 'Delete File - (File Title: #FileDetails.title#)'>
<cfinclude template="act_adminlog.cfm">
	
<!--- REFRESH THE CALLING PAGE --->	
<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_downloads">