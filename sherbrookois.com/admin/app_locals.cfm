<!--- 

<fusedoc language="ColdFusion" FUSE="About G-I-N" Specification="2.0">

<responsibilities>To display Section information / Documents / Articles / Sub-articles and supporting "Related Information" about G-I-N</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<String name="fuseaction" default="about" format="CFML" Scope="formOrUrl"/>
	<String name="fusesubaction" default="index" format="CFML" Scope="formOrUrl"/>
	<number name="DocumentID" format="CFML" Scope="formOrUrl" Optional="Yes" onCondition="fusesubaction=docs"/>
	<number name="ArticleID" format="CFML" Scope="formOrUrl" Optional="Yes" onCondition="fusesubaction=article"/>
	<number name="SubArticleID" format="CFML" Scope="formOrUrl" Optional="Yes" onCondition="fusesubaction=subarticle"/>	
	</in>
		
	<out>
	<recordset name="sectiondetails" format="CFML" Scope="variables" primarykeys="sectionID">
	<recordset name="DocumentDetails" format="CFML" Scope="variables" primarykeys="DocumentID" onCondition="fusesubaction=docs">
	<recordset name="ArticleDetails" format="CFML" Scope="variables" primarykeys="ArticleID" onCondition="fusesubaction=article">
	<recordset name="subarticleDetails" format="CFML" Scope="variables" primarykeys="SubArticleID" onCondition="fusesubaction=subarticle">
	<recordset name="doclibrarylinks" format="CFML" Scope="variables" primarykeys="recordID" onCondition="when related links from Documents/Articles/Subarticles to downloads">
	</out>

</IO>

</fusedoc>

 --->

<cfparam name="attributes.fusesubaction" default="index">