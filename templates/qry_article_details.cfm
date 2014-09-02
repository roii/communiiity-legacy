<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To retreive specific article details</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="ArticleID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="ArticleDetails" format="CFML" Scope="variables" primarykeys="ArticleID">
	</out>

</IO>

</fusedoc>

 --->
 
 
 <cfquery name="ArticleDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Articles
WHERE ArticleID=#attributes.articleID#
</cfquery>