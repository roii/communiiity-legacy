<!--- GET SECTION TITLE FOR LOG --->
	<cfquery name="SectionTitle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title, fuseaction
	FROM Sections
	WHERE SectionID = #SectionID#
	</cfquery>
	
	
<!--- DELETE SECTION --->
	<cfquery name="DeleteSection" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Sections
	WHERE SectionID = #SectionID#
	</cfquery>
	
	





<!--- RENAME THE DIRECTORY --->
	<cfdirectory action="RENAME" directory="#request.fileroot#\#SectionTitle.fuseaction#" newdirectory="#request.fileroot#\DELETED_#SectionTitle.fuseaction#">

<!--- DELETE THE DIRECTORY --->
	
	<!--- GET A LIST OF THE FILES IN IT --->
	<cfdirectory action="LIST" directory="#request.fileroot#\DELETED_#SectionTitle.fuseaction#" name="dirlist">
	
	<!--- LOOP THROUGH FILES AND DELETE --->
	<cfloop query="dirlist">
	
		<cfif (#dirlist.name# NEQ '.') AND (#dirlist.name# NEQ '..')>
			<cffile action="delete" file="#request.fileroot#\DELETED_#SectionTitle.fuseaction#\#dirlist.name#">
		</cfif>
	
	</cfloop>
	
	<!--- DELETE THE EMPTY FOLDER --->
	<cfdirectory action="DELETE" directory="#request.fileroot#\DELETED_#SectionTitle.fuseaction#">
	
	
	
	<cfset logdetails = 'Delete Section - (Section: #SectionTitle.title# | Section: #SectionTitle.fuseaction#)'>
	<cfinclude template="act_adminlog.cfm">

<cflocation url="#request.webroot#/index.cfm?fuseaction=homepage">