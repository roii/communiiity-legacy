<!--- GENERATE NEW DOCUMENT ID --->

	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT DocumentID
	FROM documents
	ORDER BY DocumentID DESC
	</cfquery>

	<cfif lastid.recordcount>
		<cfset newid = (lastID.DocumentID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>

	
	

<!--- INSERT DOC INFO --->

	<cfquery name="AddDoc" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Documents(DocumentID, Title, details,<cfif IsDate("#form.pubdate#")> PubDate,</cfif><cfif IsDate("#form.DocExpireDate#")> DocExpireDate,</cfif> Author, Released, AdminView, PublicView, ContactTypeView, AllowDelete, PluginModule, PageTitle, MetaContent, MetaKeywords, Homepromote)
	VALUES(#newid#, '#form.title#', '#form.details#',<cfif IsDate("#form.pubdate#")> #CreateODBCDate(form.pubdate)#,</cfif><cfif IsDate("#form.DocExpireDate#")> #CreateODBCDate(form.DocExpireDate)#,</cfif> '#form.author#', #form.released#, <cfif IsDefined("form.AdminView")>1<cfelse>0</cfif>, <cfif IsDefined("form.PublicView")>1<cfelse>0</cfif>, <cfif IsDefined("form.ContactTypeView")>'#form.contacttypeView#'<cfelse>'0'</cfif>, 1, '#form.module#', '#form.PageTitle#', '#form.MetaContent#', '#form.MetaKeywords#', <cfif IsDefined("form.HomePromote")>#form.homepromote#<cfelse>0</cfif>)
	</cfquery>




<!--- GENERATE NEW LINK ID --->	

	<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SectionDocumentID
	FROM SectionDocuments_Link
	ORDER BY SectionDocumentID DESC
	</cfquery>

	<cfif lastlinkid.recordcount>
		<cfset newlinkid = (LastLinkID.SectionDocumentID + 1)>
	<cfelse>
		<cfset newlinkid = 1>
	</cfif>



<!--- LINK TO SECTION --->

	<cfquery name="DocSecLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO SectionDocuments_Link(SectionDocumentID, DocumentID, SectionID, DisplayOrder)
	VALUES(#newlinkid#, #newid#, #form.SectionID#, #form.displayorder#)
	</cfquery>

	
	

<!--- LOG THE ACTION --->

	<cfset logdetails = 'Add Document - (Document: #form.title# | Section: #form.fuseaction#)'>
	<cfinclude template="act_adminlog.cfm">
	

	
	
<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#')"></body>
	
	
	</cfoutput>