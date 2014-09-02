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


<!--- UPDATE SCHOOL INFO --->
	
	<cfquery name="UpdateSchool" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Schools
	SET SchoolName='#form.SchoolName#', 
	Phone='#form.Phone#', 
	Website='#form.Website#',
	ContactEmail='#form.ContactEmail#',
	Address1='#form.Address1#', 
	Address2='#form.Address2#', 
	City='#form.City#',
	State='#form.State#',
	
	<cfif IsDefined("form.RegionID") AND IsNumeric("#form.RegionID#")>
		RegionID=#form.RegionID#, 
	<cfelse>
		RegionID=0,
	</cfif>
	
	<cfif IsDefined("form.countryID") AND IsNumeric("#form.countryID#")>
		CountryID=#form.countryID#, 
	<cfelse>
		CountryID=0,
	</cfif>
	
	<cfif IsDefined("form.NumberStudents") AND IsNumeric("#form.NumberStudents#")>
		NumberStudents=#form.NumberStudents#, 
	<cfelse>
		NumberStudents=0,
	</cfif>
	
	<cfif IsDefined("form.NumberStaff") AND IsNumeric("#form.NumberStaff#")>
		NumberStaff=#form.NumberStaff#, 
	<cfelse>
		NumberStaff=0,
	</cfif>
	
	<cfif IsDefined("form.NumberComputers") AND IsNumeric("#form.NumberComputers#")>
		NumberComputers=#form.NumberComputers#, 
	<cfelse>
		NumberComputers=0,
	</cfif>
	
	primaryContact=#form.PrimaryContact#,
	
	<cfif uploadFileError EQ 'False'>
		LogoFile='#file.serverfile#',
	</cfif>
	
	
	Notes='#form.Notes#'
	WHERE SchoolID=#form.SchoolID#
	</cfquery>


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	
	<cflocation url="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#form.schoolId#&updatemode=viewprofile">
	