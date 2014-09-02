
<!--- UPLOAD THE FILE --->
<cftry>

	<cffile action="UPLOAD" filefield="uploadfield" destination="#request.fileroot#\download\files" nameconflict="OVERWRITE">


<!--- REPLACE ANY STRANGE CHARACTERS IN THE FILENAME TO UNDERSCORES --->
	<cfset NewFileName = Replace(File.ServerFile,  '&',  '_', 'All')>
	<cfset NewFileName = Replace(NewFileName,  '-',  '_', 'All')>
	<cfset NewFileName = Replace(NewFileName,  ' ',  '_', 'All')>
	<cfset NewFileName = Replace(NewFileName,  '?',  '_', 'All')>
	
	<cffile action="RENAME" source="#request.fileroot#\download\files\#file.serverfile#" destination="#request.fileroot#\download\files\#NewFileName#">

<cfcatch>

	<script>
	alert("There was a problem uploading your file. Please try again or contact your site administrator.")
	self.location="javascript:history.back();";
	</script>
	
	<cfabort>

</cfcatch>	

</cftry>

<!--- INSERT THE FILE --->	
<cfquery name="InsertFile" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Library(LibraryCatID, Title, Details, Author, DateUploaded, FileSize, Filename, FileFormat, DisplayOrder, Released)
VALUES(#form.libraryCatID#, '#form.title#', '#form.details#', '#form.Author#', #CreateODBCDate(localDateTime)#, '#file.filesize#', '#NewFileName#', '#file.ContentSubType#', #form.displayOrder#, #form.released#)
</cfquery>


<!--- LOG THIS ACTION --->
<cfoutput>
<cfset logdetails = 'Upload File - (File Title: #form.title#)'>
</cfoutput>

<cfinclude template="act_adminlog.cfm">


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	self.close();
}
// -->
</script>


<cfoutput>
<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_downloads')"></body>
</cfoutput>
