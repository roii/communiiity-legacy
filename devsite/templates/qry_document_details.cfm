<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display retreive specific document details</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="DocumentID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="DocumentDetails" format="CFML" Scope="variables" primarykeys="DocumentID">
	</out>

</IO>

</fusedoc>

 --->
 
 
 <cfquery name="DocumentDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Documents
WHERE DocumentID=#attributes.documentid#
</cfquery>