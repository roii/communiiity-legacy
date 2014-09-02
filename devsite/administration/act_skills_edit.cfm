<!--- UPDATE ARTICLE DETAILS --->
	<cfquery name="UpdateSkill" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE allmanageskills
	SET skillName = '#form.SkillName#',
	skillKeyword = '#form.SkillKeyword#' 
	WHERE id = #form.skillID#
	</cfquery>


	<cfoutput> 
		 <cflocation addtoken="no" url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manageskills&suc=2">
	</cfoutput>