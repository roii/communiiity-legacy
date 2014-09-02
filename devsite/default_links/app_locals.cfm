<!--- 

<fusedoc language="ColdFusion" FUSE="About NZGG" Specification="2.0">

<responsibilities>To display web-links</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<String name="fuseaction" default="links" format="CFML" Scope="formOrUrl"/>
	<String name="fusesubaction" default="index" format="CFML" Scope="formOrUrl"/>
	</in>
		
	<out>
	<recordset name="linkCats" format="CFML" Scope="variables" primarykeys="LinkCatID">
	<recordset name="links" format="CFML" Scope="variables" primarykeys="LinkID" onCondition="linkcats.recordCount GT 0"></recordset>
	</out>

</IO>

</fusedoc>

 --->
 
 <cfparam name="attributes.fusesubaction" default="index">