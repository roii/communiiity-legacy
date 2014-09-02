
<!--- UPDATE INFO --->
	
	<cfquery name="AddSection" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	UPDATE BizIdea_Sections
	SET Title='#form.Title#',
	Details='#form.Details#',
	DisplayOrder=#form.Displayorder#,
	Released=#form.Released#
	WHERE SectionID=#form.sectionID#
	</cfquery>
	
	
	<cfquery name="IdeaStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT BizIdeaID
	FROM BizIdea_Sections
	WHERE SectionID=#form.sectionID#
	</cfquery>
	
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=business&fusesubaction=BusinessDetails&bizideaID=#IdeaStuff.bizideaID#&BizSectionID=#form.sectionID#&documentid=48')"></body>
	
	
	</cfoutput>