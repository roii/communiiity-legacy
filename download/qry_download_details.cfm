<!--- 

<fusedoc language="ColdFusion" FUSE="Downloads" Specification="2.0">

<responsibilities>To retreive specific file download details</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<number name="recordID" format="CFML" Scope="attributes" precision="Integer"/>
</in>

</fusedoc>

 --->
 
<cfquery name="DownloadDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM Library
WHERE recordid=#attributes.libraryID#
</cfquery>