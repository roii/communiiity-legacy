

<!--- GENERATE NEW SECTION ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SectionID
	FROM Sections
	ORDER BY SectionID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.SectionID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	<cfset newfuseaction = 'fuseaction_#newid#'>


<!--- INSERT SECTION INFO --->
	
	<cfquery name="AddSection" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Sections(SectionID, Fuseaction, Title, Details, Admin, MainMenuOrder, MenuTitle)
	VALUES(#newid#, '#newfuseaction#', '#form.title#', '#form.details#', 1, 0, '#form.title#')
	</cfquery>
	
	
	
<cftry>
<cfdirectory action="DELETE" directory="#request.fileroot#\#newfuseaction#">
<cfcatch></cfcatch>
</cftry>



<!--- CREATE THE SECTION FOLDER --->	
<cftry>
<cfdirectory action="CREATE" directory="#request.fileroot#\#newfuseaction#">
	
	<!--- COPY DEFAULT DOCUMENT HANDLING FILES --->
	<cffile action="COPY" source="#request.fileroot#\default_code\app_locals.cfm" destination="#request.fileroot#\#newfuseaction#\app_locals.cfm">
	<cffile action="COPY" source="#request.fileroot#\default_code\index.cfm" destination="#request.fileroot#\#newfuseaction#\index.cfm">
<cfcatch></cfcatch>
</cftry>




	<cfoutput>
	<cfset logdetails = 'Add Section - (Section: #form.Title#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#newfuseaction#')"></body>
	
	
	</cfoutput>
