<!--- 

<fusedoc language="ColdFusion" FUSE="About NZGG" Specification="2.0">

<responsibilities>To display resources</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<String name="fuseaction" default="resource" format="CFML" Scope="attributes"/>
	<String name="fusesubaction" default="index" format="CFML" Scope="attributes"/>
	<number name="DocumentID" format="CFML" Scope="attributes" Optional="Yes" onCondition="fusesubaction=docs"/>
	<number name="ArticleID" format="CFML" Scope="attributes" Optional="Yes" onCondition="fusesubaction=article"/>
	<number name="SubArticleID" format="CFML" Scope="attributes" Optional="Yes" onCondition="fusesubaction=subarticle"/>
	<number name="GuidelineCatID" format="CFML" Scope="attributes" Optional="Yes" onCondition="fusesubaction=category"/>
	<number name="GuidelineID" format="CFML" Scope="attributes" Optional="Yes" onCondition="fusesubaction=guideline"/>
	</in>
		
	<out>
	<recordset name="sectiondetails" format="CFML" Scope="variables" primarykeys="sectionID">
	<recordset name="DocumentDetails" format="CFML" Scope="variables" primarykeys="DocumentID" onCondition="fusesubaction=docs">
	<recordset name="ArticleDetails" format="CFML" Scope="variables" primarykeys="ArticleID" onCondition="fusesubaction=article">
	<recordset name="subarticleDetails" format="CFML" Scope="variables" primarykeys="SubArticleID" onCondition="fusesubaction=subarticle">
	<recordset name="doclibrarylinks" format="CFML" Scope="variables" primarykeys="recordID" onCondition="when related links from Documents/Articles/Subarticles to downloads">
	<recordset name="Guidelines" format="CFML" Scope="variables" primarykeys="GuidelineID" onCondition="fusesubaction=category">
	<recordset name="GuidelineDetails" format="CFML" Scope="variables" primarykeys="GuidelineID" onCondition="fusesubaction=guideline">
	</out>

</IO>

</fusedoc>

 --->
 
 <cfparam name="attributes.fusesubaction" default="index">