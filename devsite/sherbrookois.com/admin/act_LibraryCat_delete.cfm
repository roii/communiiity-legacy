
<!--- GET CATEGORY NAME FOR ADMIN LOG --->
<cfquery name="GetCatname" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT LibraryCatTitle
FROM LibraryCats
WHERE LibraryCatID = #LibraryCatID#
</cfquery>


<!--- GET RELATED FILES --->
<cfquery name="AllFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT RecordID, Filename, Title
FROM Library
WHERE LibraryCatID=#LibraryCatID#
</cfquery>


<!--- DELETE RELATED ARTICLES, LINKS, AND WHAT NEW LISTINGS --->
<cfloop query="AllFiles">

	<cfquery name="DeleteFile" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Library
	WHERE RecordID=#AllFiles.RecordID#
	</cfquery>
	
	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE Type CONTAINS 'Library'
	AND LibraryID=#AllFiles.RecordID#
	</cfquery>
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='download'
	AND RelatedID=#AllFiles.RecordID#
	</cfquery>
	
	
	<cftry>
	<!--- DELETE THE FILE --->
	<cffile action="delete" file="#request.fileroot#\download\files\#AllFiles.filename#">
	<cfcatch></cfcatch>
	</cftry>
	
	
	<!--- LOG THE FILE DELETE --->
	
	<cfset logdetails = 'Delete Library Category - Linked File - (#AllFiles.Title#)'>
	<cfinclude template="act_adminlog.cfm">
	
</cfloop>



<!--- DELETE CATEGORY --->
<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE 
FROM LibraryCats
WHERE LibraryCatID = #LibraryCatID#
</cfquery>
	
	

<!--- LOG CATEGORY DELETE --->
	
	<cfset logdetails = 'Delete Library Category - (Category: #GetCatname.LibraryCatTitle#)'>	
	<cfinclude template="act_adminlog.cfm">



<!--- RELOCATE BACK TO NEWS PAGE --->
	
	<cflocation url="#request.webroot#/index.cfm?fuseaction=download">