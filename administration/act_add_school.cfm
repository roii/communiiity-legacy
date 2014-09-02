<cfif TRIM(form.LogoFile) NEQ ''>
	
	<cftry>
	
		<cffile action="upload" filefield="LogoFile" destination="#request.fileroot#\images\schools\" nameconflict="overwrite" accept="image/*">
		<cfset uploadFileError = "false">
	<cfcatch>
		<cfset uploadFileError = "true">
	</cfcatch>
	</cftry>

<cfelse>
	<cfset uploadFileError = "true">
</cfif>

<!--- GENERATE NEW SCHOOL ID --->
	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT SchoolID
FROM Schools
ORDER BY SchoolID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.SchoolID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	


<!--- INSERT SCHOOL INFO --->
	
	<cfquery name="AddSchool" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Schools(SchoolID, SchoolName, Phone, Website, Address1, Address2, City, State, RegionID, CountryID, NumberStudents, NumberStaff, NumberComputers, Notes, LogoFile, schoolstatus)
	VALUES(#newid#, 
	'#form.SchoolName#', 
	'#form.Phone#', 
	'#form.Website#', 
	'#form.Address1#', 
	'#form.Address2#', 
	'#form.City#', 
	'#form.State#', 
	
	<cfif IsDefined("form.RegionID") AND IsNumeric("#form.RegionID#")>
		#form.RegionID#, 
	<cfelse>
		0,
	</cfif>
	
	<cfif IsDefined("form.countryID") AND IsNumeric("#form.countryID#")>
		#form.countryID#, 
	<cfelse>
		0,
	</cfif>
	
	<cfif IsDefined("form.NumberStudents") AND IsNumeric("#form.NumberStudents#")>
		#form.NumberStudents#, 
	<cfelse>
		0,
	</cfif>
	
	<cfif IsDefined("form.NumberStaff") AND IsNumeric("#form.NumberStaff#")>
		#form.NumberStaff#, 
	<cfelse>
		0,
	</cfif>
	
	<cfif IsDefined("form.NumberComputers") AND IsNumeric("#form.NumberComputers#")>
		#form.NumberComputers#, 
	<cfelse>
		0,
	</cfif>
	
	'#form.Notes#',
	
	<cfif uploadFileError EQ "false">
		'#file.serverfile#',
	<cfelse>
		'',
	</cfif>
	
	'Active'
	)
	</cfquery>


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("You have successfully added the school");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools')"></body>
	
	
	</cfoutput>
