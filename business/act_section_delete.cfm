
<!--- UPDATE INFO --->
	
	<cfquery name="AddSection" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	UPDATE BizIdea_Sections
	SET Deleted=1
	WHERE SectionID=#sectionID#
	</cfquery>
	
	
	<cfquery name="IdeaStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT BizIdeaID
	FROM BizIdea_Sections
	WHERE SectionID=#sectionID#
	</cfquery>
	
	
	<cfoutput>
	
	
	<script language="JavaScript">
	alert("You have deleted the business sub-section.");
	self.location="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=BusinessDetails&bizideaID=#IdeaStuff.bizideaID#&documentid=48";
	</script>
	
	
	
	
	
	</cfoutput>