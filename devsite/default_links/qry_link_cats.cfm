<!--- 

<fusedoc language="ColdFusion" FUSE="About NZGG" Specification="2.0">

<responsibilities>To retreive all Link Categories</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<out>
	<recordset name="linkCats" format="CFML" Scope="variables" primarykeys="LinkCatID">
	</out>

</IO>

</fusedoc>

 --->
 
<cfquery name="LinkCats" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM LinkCats
WHERE Fuseaction='#fuseaction#'
<cfif IsDefined("attributes.linkcatID")>
AND LinkCatID=#attributes.LinkCatID#
</cfif>

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>

</cfif>

ORDER BY DisplayOrder
</cfquery>
