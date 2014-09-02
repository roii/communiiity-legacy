<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To retreive specific Sub-article details</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="SubArticleID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="SubArticleDetails" format="CFML" Scope="variables" primarykeys="SubArticleID">
	</out>

</IO>

</fusedoc>

 --->
 
 
<cfquery name="SubArticleDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SubArticles
WHERE SubArticleID=#attributes.SubarticleID#
</cfquery>