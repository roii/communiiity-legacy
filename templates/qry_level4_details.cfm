<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To retreive specific Level4 details</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="Level4ArticleID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="Level4ArticleDetails" format="CFML" Scope="variables" primarykeys="Level4ArticleID">
	</out>

</IO>

</fusedoc>

 --->
 
 
<cfquery name="Level4ArticleDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM level4articles
WHERE Level4ArticleID=#attributes.Level4ArticleID#
</cfquery>