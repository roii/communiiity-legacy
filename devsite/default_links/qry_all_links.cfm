<!--- 

<fusedoc language="ColdFusion" FUSE="About NZGG" Specification="2.0">

<responsibilities>To retreive all Released Links within selected category</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="LinkCatID" format="CFML" Scope="variables" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="linkCats" format="CFML" Scope="variables" primarykeys="LinkCatID">
	</out>

</IO>

</fusedoc>

 --->
 
<cfquery name="AllLinks" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT title AS LinkTitle, Details, LinkURL, LinkID, Released
FROM Links
WHERE LinkCatID=#LinkCats.LinkCatID#
<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
	AND NonMember=1
	<cfelse>
	AND Member=1
	</cfif>

</cfif>
ORDER BY LinkTitle
</cfquery>