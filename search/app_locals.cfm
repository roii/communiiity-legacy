<!--- 

<fusedoc language="ColdFusion" FUSE="About NZGG" Specification="2.0">

<responsibilities>To display search interface, process search requests, and display search results</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<String name="fuseaction" default="search" format="CFML" Scope="formOrUrl"/>
	<String name="fusesubaction" default="index" format="CFML" Scope="formOrUrl"/>	
	<String name="keywords" format="CFML" Scope="attributes" onCondition="fusesubaction=results"/>
	</in>
		
	<out>
	<recordset name="sectiondetails" format="CFML" Scope="variables" primarykeys="sectionID">
	<recordset name="searchresults" format="CFML" Scope="variables" primarykeys="RelatedID" onCondition="fusesubaction=results">
	</out>

</IO>

</fusedoc>

 --->
 
<cfparam name="attributes.fusesubaction" default="index">
 
<cfparam name="keywords" default="">

<cfparam name="attributes.Srow" default="1">
<cfparam name="attributes.Mrow" default="10">



<cfparam name="session.ProgrammeSearchMode" default="basic">
	<cfif IsDefined("ProgrammeSearchMode")>
		<cfset session.ProgrammeSearchMode=#ProgrammeSearchMode#>
	</cfif>