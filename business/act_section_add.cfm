<cfquery name="LastID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
	SELECT SectionID
	FROM BizIdea_Sections
	ORDER BY SectionID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.SectionID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddSection" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	INSERT INTO BizIdea_Sections(SectionID, bizideaID, Title, Details, DisplayOrder, Released, Deleted)
	VALUES(#newid#, #form.bizideaID#, '#form.title#', '#form.details#', #form.DisplayOrder#, #form.released#, 0)
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=business&fusesubaction=BusinessDetails&bizideaID=#form.bizideaID#&BizSectionID=#newid#&documentid=48')"></body>
	
	
	</cfoutput>