<cfparam name="uploadFileError" default="false">


<cftry>
	<cffile action="upload" filefield="LogoFile" destination="#request.fileroot#\images\charity\" nameconflict="overwrite" accept="image/*">
	<cfset tImage="Logo_#form.OrganisationID#.#File.ServerFileExt#">
	<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\images\charity\#tImage#" nameconflict="OVERWRITE">
<cfcatch>
	<cfset uploadFileError = true>
</cfcatch>
</cftry>



<!--- UPDATE ORGANISATION INFO --->	
<cfquery name="UpdateCharity" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Organisations
SET Organisation_Name='#form.Organisation_Name#', 
WorkPhone='#form.WorkPhone#', 
Address1='#form.Address1#', 
Address2='#form.Address2#', 
City='#form.City#', 

<cfif uploadFileError EQ 'false'>
	LogoFile='#tImage#',
</cfif>

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

<cfif IsDefined("form.State")>
	State='#form.State#', 
<cfelse>
	State='',
</cfif>

WebsiteURL='#form.WebsiteURL#',	
Notes='#form.Notes#',
PrimaryContactID=#form.PrimaryContactID#
WHERE OrganisationID=#form.OrganisationID#
</cfquery>



<!--- REFRESH THE CALLING PAGE --->
	
<cfoutput>
	
<script language="JavaScript">
alert("You have successfully updated the charity");
self.location="#request.webroot#/administration/dsp_edit_charity_popup.cfm?organisationID=#form.organisationID#&updatemode=viewprofile";
</script>
	
</cfoutput>
