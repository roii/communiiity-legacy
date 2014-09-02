<cfparam name="newfile" default="no">

<!--- IF A NEW FILE WAS SELECTED UPLOAD IT --->

<cfif TRIM(form.uploadfield) NEQ ''>


	<!--- UPLOAD THE FILE --->
	<cftry>
	
		<cffile action="UPLOAD" filefield="uploadfield" destination="#request.fileroot#\download\files" nameconflict="OVERWRITE">
	
	
	<!--- REPLACE ANY STRANGE CHARACTERS IN THE FILENAME TO UNDERSCORES --->
		
		<cfset NewFileName = Replace(File.ServerFile,  '&',  '_', 'All')>
		<cfset NewFileName = Replace(NewFileName,  '-',  '_', 'All')>
		<cfset NewFileName = Replace(NewFileName,  ' ',  '_', 'All')>
		<cfset NewFileName = Replace(NewFileName,  '?',  '_', 'All')>
		
		<cffile action="RENAME" source="#request.fileroot#\download\files\#file.serverfile#" destination="#request.fileroot#\download\files\#NewFileName#">

		<cfset newfile='yes'>
				
		<!--- DELETE THE OLD FILE FROM THE SERVER --->
		<cffile action="delete" file="#request.fileroot#\download\files\#form.currentfile#">
		
	
	<cfcatch>
	
		<script>
		alert("There was a problem uploading your file. Please try again or contact your site administrator.")
		self.location="javascript:history.back();";
		</script>
		
		<cfabort>
	
	</cfcatch>	
	
	</cftry>

</cfif>

<!--- UPDATE THE FILE --->	
<cfquery name="InsertFile" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Library
SET LibraryCatID=#form.libraryCatID#, 
Title='#form.title#', 
Details='#form.details#', 
Author='#form.Author#', 
<cfif newfile EQ 'yes'>
DateUploaded=#CreateODBCDate(localDateTime)#,
FileSize='#file.filesize#', 
Filename='#NewFileName#', 
FileFormat='#file.ContentSubType#', 
</cfif>
DisplayOrder=#form.displayOrder#,
Released=#form.released#
WHERE LibraryID=#LibraryID#
</cfquery>
	
<!--- LOG THIS ACTION --->
<cfoutput>
<cfset logdetails = 'Update File - (File Title: #form.title#)'>
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
